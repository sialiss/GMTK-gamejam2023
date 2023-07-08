extends Node2D

var fish = preload("res://Scenes/Enemies/Fish/EnemyFish.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$FishTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_FishTimer_timeout():
	# Create a new instance of the Mob scene.
	# var mob = mob_scenes[randi() % mob_scenes.size()].instance()
	var mob = fish.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("Path2D/PathFollow2D")
	mob_spawn_location.set_progress_ratio(randf_range(0, 1))


	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	mob.set_location(mob_spawn_location)
