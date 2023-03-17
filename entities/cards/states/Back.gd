extends State

func enter() -> void:
	owner.sprite.frame = owner.default_frame
	owner.collisionShape.disabled = true

func exit() -> void:
	owner.collisionShape.disabled = false
