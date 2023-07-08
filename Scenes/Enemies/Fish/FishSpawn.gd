class_name FishSpawn extends Node2D

var fish = preload("res://Scenes/Enemies/Fish/EnemyFish.tscn")


@export var spawn_to_node: Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$FishTimer.start()


func _on_FishTimer_timeout():
	# Create a new instance of the Mob scene.
	# var mob = mob_scenes[randi() % mob_scenes.size()].instance()
	var mob = fish.instantiate()
	mob.set_spawn(self)

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("Path2D/PathFollow2D")
	mob_spawn_location.set_progress_ratio(randf_range(0, 1))


	# Spawn the mob by adding it to the Main scene.
	spawn_to_node.add_child(mob)
	mob.set_location(mob_spawn_location)
