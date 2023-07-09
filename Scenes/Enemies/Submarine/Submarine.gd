class_name Submarine extends CharacterBody2D


@export var speed = 100.0
@export var acceleration = 100.0
@export var health = 20
@export var damage = 1

@onready var creature_position = $CreaturePosition
@onready var creature_position_under = $AreaUnder/CreaturePositionUnder
@onready var area_under = $AreaUnder

var target


func _ready():
	target = get_parent().get_node_or_null("Creature")


func _physics_process(delta):
	var target_creature_position = creature_position
	if area_under.has_overlapping_bodies():
		target_creature_position = creature_position_under

	var input = target_creature_position.global_position.direction_to(target.global_position)

	# Move
	velocity = velocity.move_toward(input * speed, acceleration * delta)
	move_and_slide()

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
	$Bang.play()
	# $CollisionShape2D.set_deferred("disabled", true)
	collision_layer = 0
	# collision_mask = 0
	$AnimationPlayer.play("die")

	var particles = get_node("ExplosionParticles")
	var timer = get_node("ExplosionParticles/Timer")
	particles.get_parent().remove_child(particles)
	Sea.sea.add_child(particles)
	particles.global_position = global_position
	particles.emitting = true
	timer.start()

func get_upgrade(body):
	pass
