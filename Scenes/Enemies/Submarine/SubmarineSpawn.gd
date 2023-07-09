extends Area2D


@export var submarine_scene: PackedScene


func spawn():
	var submarine = submarine_scene.instantiate()
	submarine.global_position = global_position
	Sea.sea.add_child(submarine)
	$Audio.play()
