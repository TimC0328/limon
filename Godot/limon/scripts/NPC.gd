extends Actor


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var player =  get_node("/root/Main/Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	actorName = "NPC";

func _on_clicked():
	print("Clicked on NPC");
	player.target = name;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
