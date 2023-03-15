extends Node
class_name StateMachine

var current_state: State: set = set_state
var previous_state: State: get = get_previous_state

signal state_changed(state)

func set_state(state) -> void:
	if state is String:
		state = get_node_or_null(state)
	
	if state == current_state:
		return
	
	if current_state != null:
		current_state.exit()
	
	previous_state = current_state 
	current_state = state
	if current_state != null:
		current_state.enter()
	
	state_changed.emit(current_state)

func get_state() -> State: return current_state
func get_state_name() -> String: return current_state.name

func get_previous_state() -> State: return previous_state
func get_previous_state_name() -> String: return previous_state.name

func _ready() -> void:
	set_state(get_child(0))

func _process(delta: float) -> void:
	if current_state != null:
		current_state.update(delta)
