extends RigidBody2D


@export var impulse = 1000
@export var damage = 1


func shoot(angle):
	apply_impulse(Vector2.from_angle(angle) * impulse)


func get_damage():
	if linear_velocity.length() > 100:
		return damage
	else:
		return 0


func on_dealt_damage():
	queue_free()
