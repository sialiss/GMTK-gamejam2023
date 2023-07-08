class_name Submarine extends CharacterBody2D


@export var speed = 100.0
@export var acceleration = 100.0


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
