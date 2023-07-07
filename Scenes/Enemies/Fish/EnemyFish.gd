extends Enemy

func _ready():
	pass

func set_location(location: Node2D):
	# Set the mob's direction perpendicular to the path direction.
	var direction = location.rotation + PI / 2

	# Set the mob's position to a random location.
	global_position = location.global_position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	rotation = direction

	# Choose the velocity
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	linear_velocity = velocity.rotated(direction)

func _process(delta):
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func die():
	$CollisionShape2D.set_deferred("disabled", true)
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.5)
	tween.tween_callback(Callable(self, "queue_free"))
