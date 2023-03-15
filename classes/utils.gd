extends Node

class_name Utils


static func is_last_element(array: Array, element) -> bool: return array[array.size() - 1] == element

static func get_empty_card() -> Cards:
	var card_base = preload("res://entities/cards/cards.tscn")
	var empty_card: Cards = card_base.instantiate()
	empty_card.color = "EMPTY"
	empty_card.frame_number = 53
	return empty_card
