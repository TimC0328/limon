extends Actor


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var hasDialog: bool = true;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_toggle_player_collisions(false);
	actorName = "item_test";
	name = actorName;
	_load_item();

func _load_item():
	_instantiate_actor("actors/items/test.json");
	print("loading item");
	_change_dialogue(0);
	
func _on_clicked():
	print("Clicked on item");
	_toggle_player_collisions(true);
	player.target = name;

func _on_collided():
	if (player.target == name):
		print("Collided with " + name);
		player.moving = false;
		if(hasDialog):
			_load_dialogue();
		_toggle_player_collisions(false);
	
func _physics_process(delta):
	var collision;
	collision = move_and_collide(Vector2(0,0) * delta);
		# In case the player pushes the npc too far, have it return to original pos
	if collision:
		_on_collided();
	 
func _toggle_player_collisions(switch):
	if (!switch):
		self.set_collision_layer_bit(1, false);
		self.set_collision_mask_bit(0, false);
		switch = true;
	else:
		self.set_collision_layer_bit(1, true);
		self.set_collision_mask_bit(0, true);
		switch = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
