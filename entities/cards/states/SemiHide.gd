extends State

func enter() -> void:
	owner.sprite.frame = owner.frame_number
	owner.collisionShape.shape.size.y = 14
	owner.collisionShape.position.y = -15

func exit() -> void:
	owner.collisionShape.shape.size.y = 44
	owner.collisionShape.position.y = 0
