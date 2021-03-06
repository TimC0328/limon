extends KinematicBody2D

class_name Actor

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var actorName = "actor";
var actorFile;
var actorInfo;
var dialogueFile: String = "res://dialogue/test-branch.json";

onready var spawnPos = position;

onready var player =  get_node("/root/Main/Player");
onready var dialogueWindow =  get_node("/root/Main/Windows/DialogueWindow");
onready var collisionBox = get_node("BoxCollider");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _instantiate_actor(file):
	actorFile = File.new();
	actorFile.open(file, File.READ);
	var content = actorFile.get_as_text();
	actorInfo = JSON.parse(content).result;
	actorFile.close();
	
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
	
func _load_dialogue():
	dialogueWindow.visible = true;
	player._change_player_state(1);
	dialogueWindow._load_dialogue(dialogueFile);

func _change_dialogue(index):
	dialogueFile = actorInfo["dialogue"][index];
	print(dialogueFile);

func _input(event):
	if event is InputEventMouseButton:
		if(player.target != actorName):
			_toggle_player_collisions(false);

func _toggle_player_collisions(switch):
	if (!switch):
		self.set_collision_layer_bit(1, false);
		self.set_collision_mask_bit(0, false);
		switch = true;
	else:
		self.set_collision_layer_bit(1, true);
		self.set_collision_mask_bit(0, true);
		switch = false;
