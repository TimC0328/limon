extends KinematicBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var dest: Vector2 = Vector2();
var target: String = "";
var moving: bool = false;
var canMove: bool = true;
var velocity = Vector2();


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hello world");

func _input(event):
	if event is InputEventMouseButton:
		dest = event.position;
		moving = true;

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta);
	if collision:
		print(collision.collider.name)
		moving = false;
	if moving:
		if position != dest:
			position = position.move_toward(dest, 2);
		else:
			moving = false;
