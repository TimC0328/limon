extends Control

# Declare member variables
var dialogueFile;
var text;
var dialogueLines: int = 0;
var dialoguePos: int = 0;
var waiting: bool = false;

onready var player =  get_node("/root/Main/Player");
onready var inputTimer = get_child(5);
onready var textLabel = get_child(4);
onready var nameTag = get_child(3);
onready var portrait = get_child(2);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false;
	
func _input(event):
	if(!self.visible):
		return;
	if(waiting):
		return;
	if (event is InputEventMouseButton or event is InputEventKey):
		dialoguePos += 1;
	else:
		return;
	if(dialoguePos > dialogueLines):
		player._change_player_state(0);
		self.visible = false;
		return;
	_next_line();

func _load_dialogue():
	dialogueFile = File.new();
	dialogueFile.open("res://dialogue/test.json", File.READ);
	var content = dialogueFile.get_as_text();
	text = JSON.parse(content).result;
	dialogueFile.close();
	
	dialogueLines = -1;
	for line in text["lines"]:
		dialogueLines += 1;
		
	dialoguePos = 0;
	waiting = true;
	inputTimer.start(1);
	print("Initiating dialogue");
	_next_line();

func _next_line():
	nameTag.bbcode_text = text["lines"][dialoguePos]["name"] + ":";
	portrait.texture = load(text["lines"][dialoguePos]["image"]);
	textLabel.bbcode_text = text["lines"][dialoguePos]["text"];
	waiting = true;
	inputTimer.start(1);

func _on_DialogueTimer_timeout() -> void:
	waiting = false;
