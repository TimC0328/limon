extends Actor

enum State {IDLE, PATROL};

var state: int = State.IDLE;
var velocity: Vector2 = Vector2(0,0);
onready var player =  get_node("/root/Main/Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	actorName = "test";
	name = actorName;

func _on_clicked():
	print("Clicked on NPC");
	player.target = name;
	
func _on_collided():
	if (player.target == name):
		print("Collided with an NPC");
	
func _physics_process(delta):
	var collision;
	if(state == State.IDLE):
		collision = move_and_collide(Vector2(0,0) * delta);
	elif(state == State.PATROL):
		collision = move_and_collide(Vector2(velocity) * delta);
	if collision:
		_on_collided();
