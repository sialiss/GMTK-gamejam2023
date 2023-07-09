extends Fish


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
	linear_velocity = linear_velocity.move_toward(input * speed, acceleration * delta)
	
