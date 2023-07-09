extends RigidBody2D
class_name Enemy

@export var health = 1
@export var damage = 1

# Deals damage to the enemy
func harm(taken_damage: float):
	health = max(health - taken_damage, 0)
	if health <= 0:
		die()

func die():
	queue_free()
