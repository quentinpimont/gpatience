extends Area2D
class_name Cards

var color: String = ""
var signCard: String = ""
var number: int = 0
var frame_number: int = 0
var default_frame: int = 52
var grabbed_offset: Vector2 = Vector2.ZERO
var lastPosition := Vector2.ZERO
var followCards: Array[int] = []
var parent_name: String
@onready var state_machine: StateMachine = $StateMachie
@onready var sprite = $Sprite2D
@onready var collisionShape = $CollisionShape2D

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.double_click and state_machine.get_state_name() == "Front":
		print("double click")
		state_machine.set_state("Autoplacement")
	elif event is InputEventMouseButton and event.is_pressed() and (state_machine.get_state_name() == "Front" or state_machine.get_state_name() == "SemiHide"):
		state_machine.set_state("Drag")
	if event is InputEventMouseButton and not event.is_pressed() and state_machine.get_state_name() == "Drag":
		state_machine.set_state(state_machine.get_previous_state())

func start_drag():
	lastPosition = position
	grabbed_offset = position - get_global_mouse_position()
	var parent = get_parent().get_parent()
	parent_name = parent.name
	if parent is Column:
		followCards = parent.get_follow_cards(self, grabbed_offset)

func reset_to_last_pos() -> void:
	position = lastPosition
	if followCards.size():
		var parentCards = get_parent().get_parent().cardInColumn
		var selfIndex = parentCards.find(self)
		for cardIndex in followCards:
			if cardIndex == selfIndex:
				continue
			parentCards[cardIndex].reset_to_last_pos()
			parentCards[cardIndex].state_machine.set_state(parentCards[cardIndex].state_machine.get_previous_state())

func is_good_target(containerTarget) -> bool:
	var response = false
	if containerTarget is Stack:
		var cards: Array[Cards] = containerTarget.cardInStack
		if cards.size() > 0:
			var targetCard: Cards = cards[cards.size() - 1]
			var good_number: int = number - 1
			if (targetCard.number == good_number and signCard == targetCard.signCard):
				response = true
		else:
			if number == 1:
				response = true
	else:
		var cards: Array[Cards] = containerTarget.cardInColumn
		if cards.size() > 0:
			var targetCard: Cards = cards[cards.size() - 1]
			response = is_good_target_for_column(targetCard)
		else:
			if number == 13:
				response = true
	return response

func is_good_target_for_column(targetCard: Cards) -> bool:
	var response = false
	var good_number: int = number + 1
	if color != targetCard.color and good_number == targetCard.number:
		response = true
	return response
