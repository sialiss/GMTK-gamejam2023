class_name Creature extends CharacterBody2D

@export var max_health = 100
@export var speed = 100.0
@export var acceleration = 100.0


@onready var health = max_health


func _ready():
	update_hp(0)


func _physics_process(delta):
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Move
	# constant_force = input * force
	velocity = velocity.move_toward(input * speed, acceleration * delta)
	# velocity = velocity.lerp(Vector2.ZERO, 1*delta)
	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		print("Collided with: ", collider.name)
		if collider.has_method("get_damage"):
			receive_damage(collider)


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
