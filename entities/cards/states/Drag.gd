extends State

func enter() -> void:
	owner.start_drag()

func update(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		owner.position = owner.get_global_mouse_position() + owner.grabbed_offset

func exit() -> void:
	var bodies = owner.get_overlapping_areas()
	print(bodies.size())
	for body in bodies:
		if body is Cards:
			var target_parent = body.get_parent()
			if target_parent.name.begins_with("Column"):
				var owner_parent = owner.get_parent()
				if owner.is_good_target(body):
					if owner_parent is Column:
						print(owner.followCards)
						owner_parent.remove_cards(owner.followCards, target_parent.id)
					elif owner_parent is Draw:
						owner_parent.remove_card(target_parent.id)
					print("Is good target")
					owner.queue_free()
					return
	owner.reset_to_last_pos()
	owner.followCards.clear()
	owner.z_index = 0
