extends KinematicBody2D

enum State {DEFAULT, DIALOG, PAUSE};

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var dest: Vector2 = Vector2();
var target: String = "";
var moving: bool = false;
var canMove: bool = true;
var velocity = Vector2();
var state = State.DEFAULT;

onready var camera = get_child(2);
var cameraOffset: int = 0;

func _input(event):
	if (state == State.DIALOG or state == State.PAUSE):
		return;
	if event is InputEventMouseButton:
		dest = get_global_mouse_position();
		moving = true;
		if (target != ""):
			target = "";

func _physics_process(delta):
	var collision = move_and_slide(velocity * delta);
	if collision:
		moving = false;
		velocity = Vector2(0,0);
	if moving:
		if position != dest:
			position = position.move_toward(dest, 2);
		else:
			moving = false;

func _change_player_state(newState):
	if (newState == 0):
		state = State.DEFAULT;
		if(target.find("item_", 0) != -1):
			get_node("/root/Main/"+target).queue_free();
	elif (newState == 1):
		state = State.DIALOG;
		moving = false;
	elif (newState == 2):
		state = State.PAUSE;
		moving = false;

