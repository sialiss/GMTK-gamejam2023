class_name Creature extends CharacterBody2D

@export var max_health = 100
@export var speed = 100.0
@export var acceleration = 100.0
@export var attack_tentacle_scene: PackedScene


@onready var health = max_health
@onready var attack_tentacle_position = $AttackTentaclePosition
@onready var tentacles = $Tentacles.get_children()


func _ready():
	update_hp(0)


func _physics_process(delta):
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Move
	# constant_force = input * force
	velocity = velocity.move_toward(input * speed, acceleration * delta)
	# velocity = velocity.lerp(Vector2.ZERO, 1*delta)
	move_and_slide()

	# Tentacles
	for tentacle in tentacles:
		var tentacle_segments = tentacle.get_point_count()
		for i in tentacle_segments:
			if i == 0: continue
			var point = tentacle.get_point_position(i)
			var last_point = tentacle.get_point_position(i-1)

			tentacle.set_point_position(
				i,
				point.lerp(last_point - velocity / tentacle_segments, 5*delta)
			)

	if Input.is_action_just_pressed("shoot"):
		shoot()


# Called when touched an enemy
func receive_damage(body):
	var damage = body.get_damage()
	update_hp(damage)
	if health <= 0:
		die()

	if damage > 0 and body.has_method("on_dealt_damage"):
		body.on_dealt_damage()


func die():
	#queue_free()
	pass


func update_hp(taken_damage: float):
	health -= taken_damage
	$Health/HP.text = "%d/%d" % [health, max_health]


func _on_area_2d_body_entered(body):
	#update_hp(body.damage)
	pass


func shoot():
	var tentacle = attack_tentacle_scene.instantiate()
	tentacle.set_anchor(attack_tentacle_position)
	add_sibling(tentacle)
	tentacle.global_position = attack_tentacle_position.global_position
	tentacle.shoot(get_local_mouse_position().angle())
	# cooldown_timer.start()
