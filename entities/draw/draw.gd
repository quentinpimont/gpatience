extends Node2D
class_name Draw
var drawedList: Array[Cards] = []
@onready var cardsContainer = $CardsContainer

func _ready():
	EVENTS.draw.connect(on_card_drawed)
	EVENTS.deck_empty.connect(on_deck_empty)

func set_cards_back(card: Cards) -> void:
	card.state_machine.set_state("Back")

func remove_children() -> void:
	for child in cardsContainer.get_children():
		cardsContainer.remove_child(child)

func draw() -> void:
	remove_children()
	for card in drawedList:
		cardsContainer.add_child(card)
		if Utils.is_last_element(drawedList, card):
			card.state_machine.set_state("Front")
		else:
			card.state_machine.set_state("Hide")

func remove_card(targetId: int, target_is_stack: bool = false):
	var card: Cards = drawedList.pop_back()
	draw()
	if target_is_stack:
		EVENTS.add_card_in_stack.emit(card, targetId)
	else:
		EVENTS.add_one_card_in_column.emit(card, targetId)

func on_card_drawed(card: Cards) -> void:
	drawedList.push_back(card)
	draw()

func on_deck_empty():
	drawedList.map(set_cards_back)
	var deck: Array[Cards] = drawedList.duplicate(true)
	drawedList.clear()
	draw()
	EVENTS.reset_deck.emit(deck)
