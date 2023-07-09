extends Node2D


@export_range(-360.0, 360.0) var min_angle_degrees = -180.0
@export_range(-360.0, 360.0) var max_angle_degrees = 0.0
@export var speed_degrees = 360.0
@export var predictive = false
@export var shoot_cooldown = 1.0
@export var bullet_scene: PackedScene


@onready var min_angle = deg_to_rad(min_angle_degrees)
@onready var max_angle = deg_to_rad(max_angle_degrees)
@onready var speed     = deg_to_rad(speed_degrees)


@onready var radius_area = $RadiusArea
@onready var ray = $Ray
@onready var cooldown_timer = $CooldownTimer
@onready var bullet_position = $BulletPosition


func _ready():
	cooldown_timer.wait_time = shoot_cooldown


func _physics_process(delta):
	var bodies = radius_area.get_overlapping_bodies()
	if bodies.size() == 0: return
	var creature: Creature = bodies[0]

	# Rotate towards the creature
	var old_rotation = rotation
	var creature_position = creature.global_position
	if predictive:
		creature_position += creature.velocity
	look_at(creature_position)
	rotation = move_toward(old_rotation, clamp(rotation, min_angle, max_angle), speed * delta)

	# Shoot
	if cooldown_timer.is_stopped():
		if $Ray.get_collider() == creature:
			shoot()


func shoot():
	var bullet = bullet_scene.instantiate()
	Sea.sea.add_child(bullet)
	bullet.global_position = bullet_position.global_position
	bullet.shoot(rotation)
	$Audio.play()
	cooldown_timer.start()
