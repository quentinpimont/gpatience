extends Node
signal draw(card: Cards)
signal reset_deck(list: Array[Cards])
signal deck_empty
signal add_card_in_column(card: Array[Cards], targetId: int)
signal add_one_card_in_column(card: Cards, targetId: int)
