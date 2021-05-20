extends Actor

enum State {IDLE, PATROL};

var state: int = State.IDLE;
var velocity: Vector2 = Vector2(0,0);
var hasDialog: bool = true;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	actorName = "test";
	name = actorName;

func _on_clicked():
	print("Clicked on NPC");
	# Expand collision box to regular size when targeted
	collisionBox.scale = (Vector2(1,1));
	player.target = name;
	
func _on_collided():
	if (player.target == name):
		print("Collided with " + name);
		if(hasDialog):
			_load_dialog();
	
func _physics_process(delta):
	var collision;
	# Shrink collision boxes so player has an easier time passing by
	if(player.position.distance_to(position) < 10):
		collisionBox.scale = (Vector2(0.5,0.5));
	if(state == State.IDLE):
		collision = move_and_collide(Vector2(0,0) * delta);
		# In case the player pushes the npc too far, have it return to original pos
		if(position.distance_to(spawnPos) > 10):
			position = position.move_toward(spawnPos, 2);
	elif(state == State.PATROL):
		collision = move_and_collide(Vector2(velocity) * delta);
	if collision:
		_on_collided();
	 
