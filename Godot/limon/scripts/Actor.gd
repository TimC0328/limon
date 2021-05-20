extends KinematicBody2D

class_name Actor

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var actorName = "actor";
var actorFile = "";
onready var spawnPos = position;

onready var player =  get_node("/root/Main/Player");
onready var dialogWindow =  get_node("/root/Main/Windows/DialogWindow");
onready var collisionBox = get_node("BoxCollider");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		_on_clicked();
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _on_clicked():
	print("Clicked on Actor");
	
func _on_collided():
	print("Collided with Actor");
	
func _load_dialog():
	print("Initiating dialog");
	dialogWindow.visible = true;
	player._change_player_state(1);
	dialogWindow._load_dialog();

