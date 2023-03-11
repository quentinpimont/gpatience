extends Node2D

@onready var deck: Deck = $Deck
@onready var columns: Array[Node] = [
	$Column,
	$Column2,
	$Column3,
	$Column4,
	$Column5,
	$Column6,
	$Column7
]
func _ready() -> void:
	cards_distribution()

func cards_distribution() -> void:
	var numberOfCards = 28
	while numberOfCards > 0:
		var card:Cards = deck.deckList.pop_back()
		for column in columns:
			if column.init_place_card(card):
				numberOfCards -= 1
				break
