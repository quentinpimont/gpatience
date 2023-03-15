extends Node2D
class_name Draw
var drawedList: Array[Cards] = []

func _ready():
	EVENTS.draw.connect(on_card_drawed)
	EVENTS.deck_empty.connect(on_deck_empty)

func set_cards_back(card: Cards) -> void:
	card.state_machine.set_state("Back")

func on_card_drawed(card: Cards) -> void:
	if drawedList.size() > 0:
		drawedList[0].state_machine.set_state("Hide")
	drawedList.push_front(card)
	add_child(card)
	card.state_machine.set_state("Front")

func on_deck_empty():
	for child in get_children():
		remove_child(child)
	drawedList.map(set_cards_back)
	var deck: Array[Cards] = drawedList.duplicate(true)
	drawedList.clear()
	EVENTS.reset_deck.emit(deck)

func remove_card(columnId: int):
	var card: Cards = drawedList.pop_front()
	remove_child(get_child(get_child_count() - 1))
	if drawedList.size():
		drawedList[0].state_machine.set_state("Front")
	EVENTS.add_one_card_in_column.emit(card, columnId)
