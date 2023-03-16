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

@onready var stacks: Array[Node] = [
	$Stack,
	$Stack2,
	$Stack3,
	$Stack4
]

func _ready() -> void:
	EVENTS.check_win.connect(on_event_check_win)
	cards_distribution()

func cards_distribution() -> void:
	var numberOfCards = 28
	while numberOfCards > 0:
		var card:Cards = deck.deckList.pop_back()
		for column in columns:
			if column.init_add_card(card):
				numberOfCards -= 1
				break

func on_event_check_win():
	var response: bool = true
	for stack in stacks:
		if stack.cardInStack.size() < 13:
			response = false
			break
	if response:
		print("win")
