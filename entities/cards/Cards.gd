extends Area2D
class_name Cards

enum STATES {
	BACK,
	FRONT,
	DRAG
}

var state = STATES.BACK
var color: String = ""
var signCard: String = ""
var number: int = 0
var frame_number: int = 0
var default_frame: int = 52
var grabbed_offset: Vector2 = Vector2.ZERO
var lastPosition := Vector2.ZERO
@onready var sprite = $Sprite2D

func _ready():
	set_frame()

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and state == STATES.FRONT:
		state = STATES.DRAG
		lastPosition = position
		grabbed_offset = position - get_global_mouse_position()
	if event is InputEventMouseButton and not event.is_pressed() and state == STATES.DRAG:
		state = STATES.FRONT
		finish_drag()

func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and state == STATES.DRAG:
		position = get_global_mouse_position() + grabbed_offset

func set_frame() -> void:
	if state == STATES.FRONT:
		sprite.frame = frame_number
	else:
		sprite.frame = default_frame

func finish_drag() -> void:
	for card in get_overlapping_areas():
		if card is Cards:
			var targetParent: Column = card.get_parent()
			if card.state == STATES.FRONT and targetParent.name.begins_with("Column") and targetParent.cardInColumn[targetParent.cardInColumn.size() - 1] == card:
				targetParent.place_card(self)
				get_parent().cardInColumn.pop_back()
				get_parent().cardInColumn.map(
					func display(card): 
						print(card.number) 
						print(card.signCard)
				)
