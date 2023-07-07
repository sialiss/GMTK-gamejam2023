extends RigidBody2D


var force = 200
var torque = 1000


func _physics_process(delta):
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Move
	constant_force = input * force
	

	if input == Vector2.ZERO:
		constant_torque = 0
	else:
		var angle = Vector2.UP.rotated(global_rotation).angle_to(input)
		constant_torque = angle * torque

