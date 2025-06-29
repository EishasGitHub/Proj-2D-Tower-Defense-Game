extends CharacterBody2D
class_name BaseEnemy

# Base stats that will be overridden by enemy types
@export var max_health: int = 50
@export var movement_speed: float = 50
@export var gold_reward: int = 10
@export var damage_to_player: int = 1

# Visual properties
#@export var enemy_color: Color = Color.WHITE
#@export var scale_modifier: float = 1.0

var current_health: float
var path_follower: PathFollower

# Signals
signal enemy_died(enemy: BaseEnemy)
signal enemy_reached_end(enemy: BaseEnemy)

@export var speed = 150

#var health_bar: EnemyHealthBar
@onready var health_bar = $EnemyHealthBar

func _ready():
	current_health = max_health
	#path_follower = get_parent() as PathFollower
	#
	#if path_follower:
		#path_follower.speed = movement_speed
		#path_follower.enemy_reached_end.connect(_on_reached_end)
	
	# Apply visual modifications
	#scale = Vector2(scale_modifier, scale_modifier)
	#modulate = enemy_color
	
	setup_enemy_type()
	
	# Initialize health
	current_health = max_health
	
	# Create health bar
	create_health_bar()
	
	# Add to enemies group
	add_to_group("enemies")

func _process(delta: float) -> void:
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	
	if get_parent().get_progress_ratio() == 1:
		queue_free()
		
	# Update health bar position
	#update_health_bar_position()
		

func setup_enemy_type():
	# Override this in child classes
	pass

#func take_damage(damage: float):
	#current_health -= damage
	#
	#if current_health <= 0:
		#await get_tree().create_timer(0.2).timeout
		#die()

#func die():
	#enemy_died.emit(self)
	#queue_free()

func _on_reached_end():
	enemy_reached_end.emit(self)
	queue_free()

func get_health_percentage() -> float:
	return current_health / max_health
	
func enemy():
	pass	
	
func create_health_bar():
	# Health bar already exists, just initialize it
	if health_bar:
		#print("Found manually instantiated health bar!")
		health_bar.initialize(int(max_health))
		#update_health_bar_position()
	else:
		print("Health bar not found!")
	
func update_health_bar_position():
	"""Keep health bar positioned above enemy"""
	if health_bar:
		health_bar.global_position = global_position + Vector2(-25, -40)
		
func take_damage(damage_amount: int):
	"""Enemy takes damage"""
	current_health -= damage_amount
	
	# Update health bar
	if health_bar:
		health_bar.update_health(current_health)
	
	#print("Enemy took ", damage_amount, " damage. Health: ", current_health)
	
	if current_health <= 0:
		die()
		
func die():
	"""Enemy dies"""
	# Remove health bar
	if health_bar:
		health_bar.queue_free()
	
	#print("Enemy died!")
	enemy_died.emit(self)
	queue_free()
