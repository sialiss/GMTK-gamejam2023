extends Fish

func _physics_process(delta):
	var target_position
	var input
	if PositionNotifier.has_overlapping_bodies():
		# игрок в области видимости рыбки
		target_position = Sea.sea.get_node_or_null("Creature")
		input = global_position.direction_to(target_position.global_position)
	else:
		# игрока рядом нет, рыбка плывёт домой
		target_position = targetHome
		input = global_position.direction_to(targetHome.global_position)

	# Move
	linear_velocity = linear_velocity.move_toward(input * speed, acceleration * delta)
