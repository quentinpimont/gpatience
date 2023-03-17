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

func _input(event):
	if event.is_action_pressed("redo"):
		print("Redo")
		on_event_redo()

func _ready() -> void:
	EVENTS.check_win.connect(on_event_check_win)
	EVENTS.check_auto_placement.connect(on_event_check_auto_placement)
	EVENTS.move_count_changed.connect(on_event_move_count_changed)
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

func on_event_check_auto_placement(card: Cards) -> void:
	card.duplicate()
	var target = null
	var card_parent = card.get_parent().get_parent()
	if not card_parent is Draw and not card_parent is Column:
		card.state_machine.set_state("Front")
		return
	
	for stack in stacks:
		if card.is_good_target(stack):
			target = stack
			break
	
	if target != null:
		if card_parent is Column:
			card.start_drag()
			card_parent.remove_cards(card.followCards, target.id, true)
			card.followCards.clear()
		elif card_parent is Draw:
			card_parent.remove_card(target.id, true)
		GAME.set_move_count(GAME.move_count + 1)
	else:
		card.state_machine.set_state("Front")

func on_event_move_count_changed() -> void:
	print(GAME.move_count)

func on_event_redo():
	if GAME.move_count == 0:
		return
	GAME.set_move_count(GAME.move_count - 1)
	for container in get_children():
		container.redo(str(GAME.get_move_count()))
	for container in get_children():
		if not container is Deck:
			container.draw()
