extends Node2D
class_name Column

var cardInColumn: Array[Cards] = []
var yOffset: int = 15
@export var initialPos: int = 0

func _ready():
	pass
	
func place_card(card:Cards, isInit: bool = false) -> void:
	if isInit:
		card.position.y += cardInColumn.size() * yOffset
	else:
		var positionLastCard = cardInColumn[cardInColumn.size() - 1].global_position
		card.global_position = Vector2(positionLastCard.x, positionLastCard.y + yOffset)
	cardInColumn.push_back(card)
	add_child(card)

func init_place_card(card:Cards) -> bool:
	var response = true
	if cardInColumn.size() == initialPos:
		response = false
	else:
		if cardInColumn.size() == initialPos - 1:
			card.state = card.STATES.FRONT
		place_card(card, true)
	return response
