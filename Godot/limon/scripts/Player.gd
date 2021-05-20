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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hello world");

func _input(event):
	if (state == State.DIALOG):
		return;
	if event is InputEventMouseButton:
		dest = event.position;
		moving = true;
		if (target != ""):
			target = "";

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta, false);
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
	elif (newState == 1):
		state = State.DIALOG;
	elif (newState == 2):
		state = State.PAUSE;
