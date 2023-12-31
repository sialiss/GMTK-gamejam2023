class_name Creature extends CharacterBody2D


signal reached_full_hp


@export var max_health = 100
@export var speed = 100.0
@export var acceleration = 100.0
@export var attack_tentacle_scene: PackedScene
@export var attack_distance = 100


@onready var health = max_health
@onready var attack_tentacle_position = $AttackTentaclePosition
@onready var bars = $Bars
@onready var tentacles = $Tentacles.get_children()


func _ready():
	update_health(20)


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


func upgrade(upgrade_func: Callable):
	upgrade_func.call(self)
	update_bars()


# Called when touched an enemy
func receive_damage(body):
	var damage = body.get_damage()
	update_health(health - damage)
	if health <= 0:
		die()

	if damage > 0 and body.has_method("on_dealt_damage"):
		body.on_dealt_damage()


func die():
	get_tree().change_scene_to_packed(load("res://Scenes/Menu/Death.tscn"))


func update_max_health(new_max_health: float):
	var old_health = max_health
	max_health = clamp(new_max_health, 0, 100)
	if old_health < 100 and new_max_health >= 100:
		reached_full_hp.emit()


func update_health(new_health: float):
	health = clamp(new_health, 0, max_health)
	update_bars()


func update_bars():
	bars.get_node("%Health").value = health
	bars.get_node("%Speed").value = speed
	bars.get_node("%Attack").value = attack_distance


func shoot():
	var tentacle = attack_tentacle_scene.instantiate()
	tentacle.set_anchor(attack_tentacle_position)
	tentacle.max_distance = attack_distance
	add_sibling(tentacle)
	tentacle.global_position = attack_tentacle_position.global_position
	tentacle.shoot(get_local_mouse_position().angle())
	# cooldown_timer.start()
