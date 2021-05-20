extends Control

# Declare member variables
var dialogFile;
var text;
var dialogLines: int = 0;
var dialogPos: int = 0;
var waiting: bool = false;

onready var player =  get_node("/root/Main/Player");
onready var inputTimer = get_child(4);
onready var textLabel = get_child(3);

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
		return;
	_next_line();

func _load_dialog():
	dialogFile = File.new();
	dialogFile.open("res://dialog/test.json", File.READ);
	var content = dialogFile.get_as_text();
	text = JSON.parse(content).result;
	dialogFile.close();
	
	print(text["lines"][0]["text"]);
	dialogLines = -1;
	for line in text["lines"]:
		dialogLines += 1;
	textLabel.bbcode_text = text["lines"][0]["text"];
	
	dialogPos = 0;
	waiting = true;
	inputTimer.start(1);
	# print("Initiating dialog")

func _next_line():
	textLabel.bbcode_text = text["lines"][dialogPos]["text"];
	waiting = true;
	inputTimer.start(1);

func _on_DialogTimer_timeout() -> void:
	waiting = false;
