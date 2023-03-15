extends Node2D
class_name Column

var cardInColumn: Array[Cards] = []
var y_offset: int = 15
@export var id: int = 0

func _ready() -> void:
	EVENTS.add_card_in_column.connect(on_event_add_card_in_column)
	EVENTS.add_one_card_in_column.connect(on_event_add_one_card_in_column)

func remove_children() -> void:
	for child in get_children():
		remove_child(child)

func draw_column() -> void:
	remove_children()
	if cardInColumn.size() == 0:
		var empty_card = Utils.get_empty_card()
		add_child(empty_card)
		empty_card.state_machine.set_state("Front")
	else:
		for iCard in cardInColumn.size():
			add_child(cardInColumn[iCard])
			if Utils.is_last_element(cardInColumn, cardInColumn[iCard]):
				cardInColumn[iCard].state_machine.set_state("Front")
			else:
				if cardInColumn[iCard].state_machine.get_state_name() == "Back" and cardInColumn[iCard].state_before_move != "":
					cardInColumn[iCard].state_machine.set_state("SemiHide")
				if cardInColumn[iCard].state_machine.get_state_name() == "Front":
					cardInColumn[iCard].state_machine.set_state("SemiHide")

func add_card(card: Cards):
	card.position = Vector2(0, cardInColumn.size() * y_offset)
	cardInColumn.push_back(card)

func init_add_card(card:Cards) -> bool:
	var response = false
	if cardInColumn.size() < id:
		add_card(card)
		if cardInColumn.size() == id:
			draw_column()
		response = true
	return response

func remove_cards(cardsIndex: Array[int], targetId: int):
	var cards: Array[Cards] = []
	for index in cardsIndex:
		cards.push_front(cardInColumn.pop_at(index))
	draw_column()
	EVENTS.add_card_in_column.emit(cards, targetId)


func get_follow_cards(card: Cards, grab_off: Vector2) -> Array[int]:
	var followIndex: Array[int] = []
	var selectedIndex = cardInColumn.find(card)
	followIndex.push_front(selectedIndex)
	var index = selectedIndex + 1
	while index < cardInColumn.size():
		cardInColumn[index].state_machine.set_state("Follow")
		cardInColumn[index].grabbed_offset = Vector2(grab_off.x, grab_off.y + y_offset * (index - selectedIndex))
		cardInColumn[index].lastPosition = cardInColumn[index].position
		followIndex.push_front(index)
		index += 1
	return followIndex

func on_event_add_card_in_column(cards: Array[Cards], targetId: int) -> void:
	if targetId != id:
		return
	for card in cards:
		var new_card: Cards = card.duplicate_card()
		add_card(new_card)
	draw_column()
	
func on_event_add_one_card_in_column(card: Cards, targetId: int) -> void:
	if targetId != id:
		return
	var new_card: Cards = card.duplicate_card()
	add_card(new_card)
	draw_column()
