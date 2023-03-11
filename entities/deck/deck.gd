extends Area2D

var deckList: Array[Cards] = []



func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		
		print(event)
