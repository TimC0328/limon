extends Control

# Declare member variables
var dialogLines: int = 1;
var dialogPos: int = 0;
var waiting: bool = false;

onready var player =  get_node("/root/Main/Player");
onready var inputTimer = get_child(4);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _input(event):
	if(!self.visible):
		return;
	if(waiting):
		return;
	if (event is InputEventMouseButton or event is InputEventKey):
		dialogPos += 1;
	else:
		return;
	if(dialogPos > dialogLines):
		player._change_player_state(0);
		self.visible = false;
	_next_line();

func _load_dialog():
	dialogPos = 0;
	waiting = true;
	inputTimer.start(3);
	print("Initiating dialog");

func _next_line():
	waiting = true;
	inputTimer.start(3);

func _on_DialogTimer_timeout() -> void:
	waiting = false;
