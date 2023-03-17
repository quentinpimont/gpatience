extends State

func enter() -> void:
	EVENTS.check_auto_placement.emit(owner)
