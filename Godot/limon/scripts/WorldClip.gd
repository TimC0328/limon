extends StaticBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var player =  get_node("/root/Main/Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				player.canMove = false;
			else:
				player.canMove = true;
				
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
