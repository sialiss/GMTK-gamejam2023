extends StaticBody2D

@export var health = 20
@export var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Called when touched an enemy
func receive_damage(body):
	var damage = body.get_damage()
	health -= damage
	if health <= 0:
		die()
		if body.has_method("upgrade"):
			body.upgrade(self.get_upgrade)

	if damage > 0 and body.has_method("on_dealt_damage"):
		body.on_dealt_damage()

func die():

	get_parent().queue_free()

func get_upgrade(body):
	pass
