extends Area2D
class_name Cards

var color: String = ""
var signCard: String = ""
var number: int = 0
var frame_number: int = 0
var default_frame: int = 54
@onready var sprite = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.frame = default_frame
