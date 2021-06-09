extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var inventory = [];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _insert_item(item):
	inventory.append(item);
	print("inserted: " + item.name);
	var count = 0;
	for i in inventory:
		if(i == item):
			item.slot = count;
		count += 1;
	print(item.slot);


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
