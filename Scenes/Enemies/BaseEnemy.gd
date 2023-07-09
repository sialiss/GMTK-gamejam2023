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
	$CollisionShape2D.set_deferred("disabled", true)
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.5)
	tween.tween_callback(Callable(self, "queue_free"))
