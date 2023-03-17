extends Area2D
class_name Stack

var cardInStack: Array[Cards] = []
var history: Dictionary = {}
@export var id: int = 0
@onready var collisionShape = $CollisionShape2D
@onready var cardsContainer = $CardsContainer

func _ready():
	EVENTS.add_card_in_stack.connect(on_event_add_card_in_stack)
	draw()

func remove_children():
	for child in cardsContainer.get_children():
		cardsContainer.remove_child(child)

func draw():
	remove_children()
	for card in cardInStack:
		card.position = Vector2.ZERO
		cardsContainer.add_child(card)
		if Utils.is_last_element(cardInStack, card):
			card.state_machine.set_state("Front")
		else:
			card.state_machine.set_state("Hide")

func remove_card(targetId: int, target_is_stack: bool = false):
	history[str(GAME.get_move_count())] = cardInStack.duplicate(true)
	var card: Cards = cardInStack.pop_back()
	if cardInStack.size():
		cardInStack[cardInStack.size() - 1].state_machine.set_state("Front")
	draw()
	if target_is_stack:
		EVENTS.add_card_in_stack.emit(card, targetId)
	else:
		EVENTS.add_one_card_in_column.emit(card, targetId)

func redo(move_count_str: String) -> void:
	if history.has(move_count_str):
		cardInStack = history[move_count_str]
		history.erase(history[move_count_str])
		remove_children()

func on_event_add_card_in_stack(card: Cards, stackId: int):
	if stackId != id:
		return
	history[str(GAME.get_move_count())] = cardInStack.duplicate(true)
	cardInStack.push_back(card)
	draw()
	EVENTS.check_win.emit()
