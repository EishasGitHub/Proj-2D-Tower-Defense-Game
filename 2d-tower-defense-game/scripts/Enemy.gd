extends CharacterBody2D
class_name BaseEnemy

# Base stats that will be overridden by enemy types
@export var max_health: float = 150.0
@export var movement_speed: float = 100.0
@export var gold_reward: int = 10
@export var damage_to_player: int = 1

# Visual properties
@export var enemy_color: Color = Color.WHITE
@export var scale_modifier: float = 1.0

var current_health: float
var path_follower: PathFollower

# Signals
signal enemy_died(enemy: BaseEnemy)
signal enemy_reached_end(enemy: BaseEnemy)

@export var speed = 150

func _ready():
	current_health = max_health
	#path_follower = get_parent() as PathFollower
	#
	#if path_follower:
		#path_follower.speed = movement_speed
		#path_follower.enemy_reached_end.connect(_on_reached_end)
	
	# Apply visual modifications
	scale = Vector2(scale_modifier, scale_modifier)
	modulate = enemy_color
	
	setup_enemy_type()

func _process(delta: float) -> void:
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	
	if get_parent().get_progress_ratio() == 1:
		queue_free()
		

func setup_enemy_type():
	# Override this in child classes
	pass

func take_damage(damage: float):
	current_health -= damage
	
	print(current_health)
	
	if current_health <= 0:
		die()

func die():
	enemy_died.emit(self)
	queue_free()

func _on_reached_end():
	enemy_reached_end.emit(self)
	queue_free()

func get_health_percentage() -> float:
	return current_health / max_health
	
func enemy():
	pass	
