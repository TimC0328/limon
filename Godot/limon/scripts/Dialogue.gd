extends Control

# Declare member variables
enum State {DEFAULT, BRANCH};
var state: int = State.DEFAULT;
var dialogueFile;
var text;
var dialogueLines: int = 0;
var dialoguePos: int = 0;
var waiting: bool = true;
var writingLine: bool = true;
var choice = 0;
var totalOptions = 0;
var currentBranch = -1;

onready var player =  get_node("/root/Main/Player");
onready var charTimer = get_child(6);
onready var inputTimer = get_child(5);
onready var textLabel = get_child(4);
onready var nameTag = get_child(3);
onready var portrait = get_child(9);
onready var cursor = get_child(10);

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
	if(state == State.BRANCH):
		_handle_branch(event)
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
	state = State.DEFAULT;
	_next_line();

func _next_line():
	waiting = true;
	if(text["lines"][dialoguePos]["name"] == "EXIT"):
		player._change_player_state(0);
		self.visible = false;
		return;
	if(dialoguePos > 0 and text["lines"][dialoguePos]["branch"] >= 0):
		_branch(text["lines"][dialoguePos]["branch"]);
		return;
	nameTag.bbcode_text = text["lines"][dialoguePos]["name"] + ":";
	# portrait.texture = load(text["lines"][dialoguePos]["image"]);
	portrait.set_animation(text["lines"][dialoguePos]["animation"]);
	# textLabel.bbcode_text = text["lines"][dialoguePos]["text"];
	_draw_line(text["lines"][dialoguePos]["text"]);


func _on_DialogueTimer_timeout() -> void:
	inputTimer.set_paused(true);
	waiting = false;

func _draw_line(line):
	var tempString = "";
	writingLine = true;
	portrait.play("", false);
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

func _branch(branch):
	var options = "";
	
	state = State.BRANCH;
	cursor.visible = true;
	choice = 0;
	totalOptions = 0;
	
	for option in text["branches"][branch]["options"]:
		options += option + "\n";
		totalOptions += 1;
	textLabel.bbcode_text = options;
	currentBranch = branch

func _handle_branch(event):
	if (event is InputEventKey):
		if (event.scancode == KEY_ENTER):
			dialoguePos = (text["branches"][currentBranch]["newlines"][choice]);
			state = State.DEFAULT;
			cursor.visible = false;
			cursor.position.y = 460;
			waiting = true;
			_next_line();
		elif (event.scancode == KEY_UP):
			if(choice != 0):
				choice -= 1;
				cursor.position.y -= 30;
		elif (event.scancode == KEY_DOWN):
			if(choice != (totalOptions - 1)):
				choice += 1;
				cursor.position.y += 30;
		waiting = true;
		inputTimer.set_paused(false);
func _on_PortraitAnimated_animation_finished() -> void:
	portrait.stop();
