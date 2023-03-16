extends State

func enter() -> void:
	owner.collisionShape.disabled = true

func exit() -> void:
	owner.collisionShape.disabled = false

