extends State

func enter() -> void:
	owner.z_index = 1
	owner.start_drag()

func update(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		owner.position = owner.get_global_mouse_position() + owner.grabbed_offset

func exit() -> void:
	owner.z_index = 0
	var bodies = owner.get_overlapping_areas()
	var parent = owner.get_parent().get_parent()
	if owner.parent_name == parent.name:
		for body in bodies:
			if body is Stack or body is Column:
				if owner.is_good_target(body):
					if parent is Column:
						parent.remove_cards(owner.followCards, body.id, body is Stack)
					elif parent is Draw or parent is Stack:
						parent.remove_card(body.id, body is Stack)
					GAME.set_move_count(GAME.move_count + 1)
					owner.followCards.clear()
					return
		owner.reset_to_last_pos()
		owner.followCards.clear()
