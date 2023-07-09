class_name EnemyFish extends Fish


@onready var attack_cooldown = $AttackCooldown


var target_position = Vector2.ZERO


func _physics_process(delta):
	if PositionNotifier.has_overlapping_bodies():
		# игрок в области видимости рыбки
		target_position = Sea.sea.get_node("Creature").global_position
	else:
		# игрока рядом нет, рыбка плывёт домой
		target_position = targetHome.global_position
	var input = global_position.direction_to(target_position)

	# Move
	constant_force = input * speed
	$Sprite2D.look_at(global_position + linear_velocity)

	# Damage
	if attack_cooldown.is_stopped():
		for collider in get_colliding_bodies():
			if collider.has_method("receive_damage") and not (collider is EnemyFish):
				collider.receive_damage(self)


func get_damage():
	return damage


func on_dealt_damage():
	attack_cooldown.start()


func get_upgrade(body):
	body.update_max_health(body.max_health + 2)
	body.update_health(body.health + 2)

	body.attack_distance = clamp(body.attack_distance + 10, 0, 400)
