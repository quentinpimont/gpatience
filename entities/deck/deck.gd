extends Area2D
class_name Deck

var cardBase = preload("res://entities/cards/cards.tscn")
var deckList: Array[Cards] = []
@onready var sprite = $Sprite2D

# BUILT-IN
func _ready():
	randomize()
	_shuffleCards()
	EVENTS.reset_deck.connect(on_reset_deck)

# LOGIC
func _shuffleCards():
	for cardIndex in GAME.cardsInfos.size():
		var cardInfo = _getFullcardInfos(GAME.cardsInfos[cardIndex], cardIndex)
		var instance: Cards = cardBase.instantiate()
		instance.color = cardInfo["color"]
		instance.signCard = cardInfo["sign"]
		instance.frame_number = cardInfo["frame"]
		instance.number = cardInfo["number"]
		deckList.push_front(instance)
	deckList.shuffle()

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

# SIGNAL RESPONSES
func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_mask == 1:
		if deckList.size() > 0:
			var card: Cards = deckList.pop_front()
			EVENTS.draw.emit(card)
			if deckList.size() == 0:
				sprite.frame = 53
		else:
			EVENTS.deck_empty.emit()

func on_reset_deck(cards:Array[Cards]) -> void:
	deckList = cards
	if deckList.size():
		sprite.frame = 52
