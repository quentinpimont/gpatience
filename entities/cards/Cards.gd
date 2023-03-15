extends Area2D
class_name Cards

var card_base = preload("res://entities/cards/cards.tscn")
var color: String = ""
var signCard: String = ""
var number: int = 0
var frame_number: int = 0
var default_frame: int = 52
var grabbed_offset: Vector2 = Vector2.ZERO
var lastPosition := Vector2.ZERO
var followCards: Array[int] = []
var state_before_move: String
@onready var state_machine: StateMachine = $StateMachie
@onready var sprite = $Sprite2D
@onready var collisionShape = $CollisionShape2D

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and (state_machine.get_state_name() == "Front" or state_machine.get_state_name() == "SemiHide"):
		state_machine.set_state("Drag")
	if event is InputEventMouseButton and not event.is_pressed() and state_machine.get_state_name() == "Drag":
		state_machine.set_state(state_machine.get_previous_state())

func start_drag():
	z_index = 1
	lastPosition = position
	grabbed_offset = position - get_global_mouse_position()
	var parent = get_parent()
	if parent is Column:
		followCards = parent.get_follow_cards(self, grabbed_offset)

func reset_to_last_pos() -> void:
	position = lastPosition
	if followCards.size():
		var parentCards = get_parent().cardInColumn
		var selfIndex = parentCards.find(self)
		for cardIndex in followCards:
			if cardIndex == selfIndex:
				continue
			parentCards[cardIndex].reset_to_last_pos()
			parentCards[cardIndex].state_machine.set_state(parentCards[cardIndex].state_machine.get_previous_state())

func is_good_target(cardTarget:Cards) -> bool:
	var response = false
	if (color != cardTarget.color and number + 1 == cardTarget.number) or (number == 13 and cardTarget.color == "EMPTY"):
		response = true
	return response

func duplicate_card() -> Cards:
	var new_card: Cards = card_base.instantiate()
	new_card.color = color
	new_card.signCard = signCard
	new_card.number = number
	new_card.frame_number = frame_number
	new_card.state_before_move = state_machine.get_previous_state_name()
	return new_card
