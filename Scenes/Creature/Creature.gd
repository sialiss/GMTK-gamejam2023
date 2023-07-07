extends RigidBody2D


func _physics_process(delta):
	constant_force = Input.get_vector("move_left", "move_right", "move_up", "move_down") * 100
