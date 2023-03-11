extends Node2D

var drawedList: Array[Cards] = []

func _ready():
	EVENTS.draw.connect(on_card_drawed)
	EVENTS.deck_empty.connect(on_deck_empty)

func set_cards_back(card: Cards) -> void:
	card.state = card.STATES.BACK
func on_card_drawed(card: Cards) -> void:
	if get_child_count() > 0:
		remove_child(get_child(0))
	drawedList.push_front(card)
	card.state = card.STATES.FRONT
	add_child(card)

func on_deck_empty():
	remove_child(get_child(0))
	drawedList.map(set_cards_back)
	var deck: Array[Cards] = drawedList.duplicate(true)
	drawedList.clear()
	EVENTS.reset_deck.emit(deck)
