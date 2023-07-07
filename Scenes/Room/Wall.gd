class_name Wall extends StaticBody2D


@export var exterior = false
@export var health = 1
@export var connected_rooms: Array[Room] = []


func on_collided():
	pass