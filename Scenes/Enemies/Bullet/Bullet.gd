extends RigidBody2D


@export var impulse = 1000


func shoot(angle):
	apply_impulse(Vector2.from_angle(angle) * impulse)
