extends Area2D
class_name Column

var cardInColumn: Array[Cards] = []
var y_offset: int = 15
@export var id: int = 0
@onready var cardsContainer = $CardsContainer
@onready var collisionShape = $CollisionShape2D

func _ready() -> void:
	EVENTS.add_card_in_column.connect(on_event_add_card_in_column)
	EVENTS.add_one_card_in_column.connect(on_event_add_one_card_in_column)

func remove_children() -> void:
	for child in cardsContainer.get_children():
		cardsContainer.remove_child(child)

func resize_collision_shape():
	var shapeTransform: Vector2 = Vector2.ZERO
	var shapeSize: Vector2 = Vector2(32, 44)
	if cardInColumn.size() > 1:
		var offset = cardInColumn.size() - 1
		shapeTransform.y = float((float(offset) * float(y_offset)) / 2.0)
		shapeSize.y += offset * y_offset
	collisionShape.position = shapeTransform
	collisionShape.shape.size = shapeSize

func draw() -> void:
	remove_children()
	resize_collision_shape()
	for iCard in cardInColumn.size():
		cardsContainer.add_child(cardInColumn[iCard])
		cardInColumn[iCard].position = Vector2(0, y_offset * iCard)
		if Utils.is_last_element(cardInColumn, cardInColumn[iCard]) and cardInColumn[iCard].state_machine.get_state_name() != "Front":
			cardInColumn[iCard].state_machine.set_state("Front")
		else:
			if cardInColumn[iCard].state_machine.get_state_name() == "Follow":
				cardInColumn[iCard].state_machine.set_state("SemiHide")
			if cardInColumn[iCard].state_machine.get_state_name() == "Front":
				cardInColumn[iCard].state_machine.set_state("SemiHide")

func init_add_card(card:Cards) -> bool:
	var response = false
	if cardInColumn.size() < id:
		cardInColumn.push_back(card)
		if cardInColumn.size() == id:
			draw()
		response = true
	return response

func remove_cards(cardsIndex: Array[int], targetId: int, target_is_stack: bool = false):
	var cards: Array[Cards] = []
	for index in cardsIndex:
		cards.push_front(cardInColumn.pop_at(index))
	draw()
	if target_is_stack:
		EVENTS.add_card_in_stack.emit(cards[0], targetId)
	else:
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
		cardInColumn.push_back(card)
	draw()
	
func on_event_add_one_card_in_column(card: Cards, targetId: int) -> void:
	if targetId != id:
		return
	cardInColumn.push_back(card)
	draw()
