class_name Creature extends RigidBody2D

@export var max_health = 100
@onready var health = max_health
var force = 200
var torque = 1000

func _ready():
	update_hp(0)

func _physics_process(delta):
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Move
	constant_force = input * force

	# if input == Vector2.ZERO:
	# 	constant_torque = 0
	# else:
	# 	var angle = Vector2.UP.rotated(global_rotation).angle_to(input)
	# 	constant_torque = angle * torque
	var angle = get_local_mouse_position().angle() - TAU/4
	constant_torque = angle * torque

# Called when touched an enemy
#func get_damage(body):
#	update_hp(body.damage)
#	if health <= 0:
#		die()

func die():
	#queue_free()
	pass

func update_hp(taken_damage: float):
	health -= taken_damage
	$Health/HP.text = "%d/%d" % [health, max_health]

func _on_area_2d_body_entered(body):
	#update_hp(body.damage)
	pass
