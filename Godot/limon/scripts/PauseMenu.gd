extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var player =  get_node("/root/Main/Player");
onready var title = get_child(1);
onready var inventory = get_child(2);
onready var currentWindow = 0;
var toggleTimer = 25;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false;
	inventory.visible = false;

func _input(event):
	if (event is InputEventKey):
		if (event.scancode == KEY_ESCAPE):
			_toggle_menu(0);
		elif (event.scancode == KEY_I):
			_toggle_menu(1);

func _toggle_menu(index):
	if(toggleTimer != 25):
		return;
	if(self.visible):
		if(index > 0):
			_navigate(index);
		else:
			player._change_player_state(0);
			self.visible = false;
	else:
		player._change_player_state(1);
		self.visible = true;
		_navigate(index);
	toggleTimer = 0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(toggleTimer != 25):
		toggleTimer += 1;

func _navigate(index):
	currentWindow = index;
	if(currentWindow == 0):
		title.text = "PAUSE"
		inventory.visible = false;
	elif(currentWindow == 1):
		title.text = "ITEMS"
		inventory.visible = true;
	elif(currentWindow == 2):
		title.text = "NOTES"
		inventory.visible = false;
