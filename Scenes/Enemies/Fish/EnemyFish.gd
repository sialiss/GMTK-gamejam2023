extends Enemy

@export var speed = 150.0
@export var acceleration = 100.0
@onready var PositionNotifier = $PositionNotifier

var targetPlayer
var targetHome
var spawner_node: FishSpawn

func _ready():
	targetPlayer = Sea.sea.get_node_or_null("Creature")
	targetHome = spawner_node.get_node_or_null("FishHome")

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

func set_spawn(spawner_node: FishSpawn):
	self.spawner_node = spawner_node

func _physics_process(delta):
	var target_position
	var input
	if PositionNotifier.has_overlapping_bodies():
		# игрок в области видимости рыбки
		target_position = Sea.sea.get_node_or_null("Creature")
		input = target_position.global_position.direction_to(global_position)
	else:
		# игрока рядом нет, рыбка плывёт домой
		target_position = targetHome
		input = global_position.direction_to(targetHome.global_position)

	# Move
	linear_velocity = linear_velocity.move_toward(input * speed, acceleration * delta)

func _process(delta):
	pass

# Called when touched an enemy
func receive_damage(body):
	var damage = body.get_damage()
	health -= damage
	if health <= 0:
		die()

	if damage > 0 and body.has_method("on_dealt_damage"):
		body.on_dealt_damage()

func die():
	$CollisionShape2D.set_deferred("disabled", true)
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.5)
	tween.tween_callback(Callable(self, "queue_free"))
