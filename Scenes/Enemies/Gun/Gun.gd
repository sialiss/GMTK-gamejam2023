extends Node2D


@export_range(-360.0, 360.0) var min_angle_degrees = -180.0
@export_range(-360.0, 360.0) var max_angle_degrees = 0.0
@export var speed_degrees = 360.0
@export var predictive = false


@onready var min_angle = deg_to_rad(min_angle_degrees)
@onready var max_angle = deg_to_rad(max_angle_degrees)
@onready var speed     = deg_to_rad(speed_degrees)


@onready var radius_area = $RadiusArea
@onready var ray = $Ray


func _physics_process(delta):
	var bodies = radius_area.get_overlapping_bodies()
	if bodies.size() == 0: return
	var creature: Creature = bodies[0]

	# Rotate towards the creature
	var old_rotation = rotation
	var creature_position = creature.global_position
	if predictive:
		creature_position += creature.linear_velocity
	look_at(creature_position)
	rotation = move_toward(old_rotation, clamp(rotation, min_angle, max_angle), speed * delta)
	
