extends Node

var move_count: int = 0: set = set_move_count, get = get_move_count
var cardsInfos = [
	{"color": "RED", "sign": "HEART"},
	{"color": "RED", "sign": "HEART"},
	{"color": "RED", "sign": "HEART"},
	{"color": "RED", "sign": "HEART"},
	{"color": "RED", "sign": "HEART"},
	{"color": "RED", "sign": "HEART"},
	{"color": "RED", "sign": "HEART"},
	{"color": "RED", "sign": "HEART"},
	{"color": "RED", "sign": "HEART"},
	{"color": "RED", "sign": "HEART"},
	{"color": "RED", "sign": "HEART"},
	{"color": "RED", "sign": "HEART"},
	{"color": "RED", "sign": "HEART"},
	{"color": "RED", "sign": "DIAMOND"},
	{"color": "RED", "sign": "DIAMOND"},
	{"color": "RED", "sign": "DIAMOND"},
	{"color": "RED", "sign": "DIAMOND"},
	{"color": "RED", "sign": "DIAMOND"},
	{"color": "RED", "sign": "DIAMOND"},
	{"color": "RED", "sign": "DIAMOND"},
	{"color": "RED", "sign": "DIAMOND"},
	{"color": "RED", "sign": "DIAMOND"},
	{"color": "RED", "sign": "DIAMOND"},
	{"color": "RED", "sign": "DIAMOND"},
	{"color": "RED", "sign": "DIAMOND"},
	{"color": "RED", "sign": "DIAMOND"},
	{"color": "BLACK", "sign": "SPADE"},
	{"color": "BLACK", "sign": "SPADE"},
	{"color": "BLACK", "sign": "SPADE"},
	{"color": "BLACK", "sign": "SPADE"},
	{"color": "BLACK", "sign": "SPADE"},
	{"color": "BLACK", "sign": "SPADE"},
	{"color": "BLACK", "sign": "SPADE"},
	{"color": "BLACK", "sign": "SPADE"},
	{"color": "BLACK", "sign": "SPADE"},
	{"color": "BLACK", "sign": "SPADE"},
	{"color": "BLACK", "sign": "SPADE"},
	{"color": "BLACK", "sign": "SPADE"},
	{"color": "BLACK", "sign": "SPADE"},
	{"color": "BLACK", "sign": "CLUB"},
	{"color": "BLACK", "sign": "CLUB"},
	{"color": "BLACK", "sign": "CLUB"},
	{"color": "BLACK", "sign": "CLUB"},
	{"color": "BLACK", "sign": "CLUB"},
	{"color": "BLACK", "sign": "CLUB"},
	{"color": "BLACK", "sign": "CLUB"},
	{"color": "BLACK", "sign": "CLUB"},
	{"color": "BLACK", "sign": "CLUB"},
	{"color": "BLACK", "sign": "CLUB"},
	{"color": "BLACK", "sign": "CLUB"},
	{"color": "BLACK", "sign": "CLUB"},
	{"color": "BLACK", "sign": "CLUB"},
]

func set_move_count(value: int) -> void:
	if value != move_count:
		move_count = value
		EVENTS.move_count_changed.emit()

func get_move_count() -> int: return move_count
