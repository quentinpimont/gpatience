extends Node2D

var cardBase = preload("res://entities/cards/cards.tscn")
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
var cards = []
@onready var deck = $deck

func _ready():
	randomize()
	_shuffleCards()
	

func _getFullcardInfos(infos: Dictionary, index: int) -> Dictionary:
	var numberTmp = index + 1
	var number = 0
	if numberTmp <= 13:
		number = numberTmp
	else:
		number = numberTmp % 13
		if number == 0 : number = 13
	return {
		"color": infos["color"],
		"sign": infos["sign"],
		"frame": index,
		"number": number
	}

func _shuffleCards():
	for cardIndex in cardsInfos.size():
		cards.push_back(_getFullcardInfos(cardsInfos[cardIndex], cardIndex))
	
	cards.shuffle()
	for card in cards:
		var instance: Cards = cardBase.instantiate()
		instance.color = card["color"]
		instance.signCard = card["sign"]
		instance.frame_number = card["frame"]
		instance.number = card["number"]
		deck.add_child(instance)
