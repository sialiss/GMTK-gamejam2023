extends RigidBody2D


@export var impulse = 1000
@export var damage = 1
@export var max_distance = 100


@onready var line = $Line


var anchor_point: Node2D
var is_connected = false


func set_anchor(new_anchor_point: Node2D):
	anchor_point = new_anchor_point


func shoot(angle: float):
	apply_impulse(Vector2.from_angle(angle) * impulse)


func get_damage():
	return damage


func _process(delta):
	line.set_point_position(1, to_local(anchor_point.global_position))
	if line.get_point_position(1).length() > max_distance:
		queue_free()


func _physics_process(delta):
	# Damage
	if is_connected: return

	for collider in get_colliding_bodies():
		if collider.has_method("receive_damage"):
			collider.receive_damage(self)

		collision_mask = 0
		freeze = true
		var global_pos = global_position
		get_parent().remove_child(self)
		collider.add_child(self)
		global_position = global_pos
		is_connected = true
		break



# func on_dealt_damage():
# 	queue_free()
