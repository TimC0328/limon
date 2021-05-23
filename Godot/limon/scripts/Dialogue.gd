extends Control

# Declare member variables
var dialogueFile;
var text;
var dialogueLines: int = 0;
var dialoguePos: int = 0;
var waiting: bool = true;
var writingLine: bool = true;

onready var player =  get_node("/root/Main/Player");
onready var charTimer = get_child(6);
onready var inputTimer = get_child(5);
onready var textLabel = get_child(4);
onready var nameTag = get_child(3);
onready var portrait = get_child(2);

onready var typingSFX = get_child(7);
onready var dingSFX = get_child(8);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false;
	
func _input(event):
	if(!self.visible):
		return;
	if(waiting):
		return;
	if (event is InputEventMouseButton or event is InputEventKey):
		waiting = true;
		if(writingLine):
			inputTimer.set_paused(false);
			writingLine = false;
			return;
		else:
			dialoguePos += 1;
		inputTimer.set_paused(false);
	else:
		return;
	if(dialoguePos > dialogueLines):
		player._change_player_state(0);
		self.visible = false;
		return;
	_next_line();

func _load_dialogue(file):
	dialogueFile = File.new();
	dialogueFile.open(file, File.READ);
	var content = dialogueFile.get_as_text();
	text = JSON.parse(content).result;
	dialogueFile.close();
	
	dialogueLines = -1;
	for line in text["lines"]:
		dialogueLines += 1;
		
	dialoguePos = 0;
	waiting = true;
	inputTimer.wait_time = 0.1;
	inputTimer.start();
	inputTimer.set_paused(false);
	charTimer.wait_time = 0.025;
	dingSFX.set_pitch_scale(.9);
	print("Initiating dialogue");
	_next_line();

func _next_line():
	waiting = true;
	nameTag.bbcode_text = text["lines"][dialoguePos]["name"] + ":";
	portrait.texture = load(text["lines"][dialoguePos]["image"]);
	# textLabel.bbcode_text = text["lines"][dialoguePos]["text"];
	_draw_line(text["lines"][dialoguePos]["text"]);

func _on_DialogueTimer_timeout() -> void:
	inputTimer.set_paused(true);
	waiting = false;

func _draw_line(line):
	var tempString = "";
	writingLine = true;
	for letter in line:
		charTimer.start();
		if(!writingLine):
			charTimer.stop();
			textLabel.bbcode_text = line;
			break;
		tempString+=letter;
		typingSFX.play(0);
		textLabel.bbcode_text = tempString;
		yield(charTimer, "timeout");
		typingSFX.stop();
	dingSFX.play(0);
