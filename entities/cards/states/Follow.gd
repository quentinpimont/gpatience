extends State

func enter() -> void:
	owner.z_index = 1

func update(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		owner.position = owner.get_global_mouse_position() + owner.grabbed_offset

func exit() -> void:
	owner.z_index = 0
