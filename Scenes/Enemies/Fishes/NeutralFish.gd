extends Fish

func _physics_process(delta):
	var target_position
	var input
	if PositionNotifier.has_overlapping_bodies():
		# игрок в области видимости рыбки
		target_position = Sea.sea.get_node_or_null("Creature")
		input = target_position.global_position.direction_to(global_position)
	else:
		# игрока рядом нет, рыбка плывёт домой
		target_position = targetHome
		input = global_position.direction_to(targetHome.global_position)

	# Move
	# linear_velocity = linear_velocity.move_toward(input * speed, acceleration * delta)
	constant_force = input * speed

	# Rotate
	# var old_rotation = global_rotation
	# look_at(global_position + input)
	# var target_rotation = global_rotation
	# rotation = old_rotation

	# var old_rotation = Vector2.from_angle(global_rotation)
	# var target_rotation = constant_force.normalized()
	# constant_torque = old_rotation.angle_to(target_rotation) * 1000

	$Sprite2D.look_at(global_position + linear_velocity)
