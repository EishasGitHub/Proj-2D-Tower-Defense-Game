extends Node2D
class_name Castle

@onready var goal_area = $Area2D
#var castle_health_bar: CastleHealthBar

signal enemy_reached_goal(enemy)

@onready var castle_health_bar = $CastleHealthBar

func _ready():
	# Connect area signal
	if goal_area:
		goal_area.body_entered.connect(_on_enemy_entered)
	
	# Create castle health bar
	create_health_bar()

#func create_health_bar():
	#"""Create castle health bar UI"""
	#var health_bar_scene = preload("res://scenes/castle_health_bar.tscn")
	#castle_health_bar = health_bar_scene.instantiate()
	#
	## Add to scene tree (will appear on screen)
	#add_child(castle_health_bar)
	#
	## Connect destruction signal
	#castle_health_bar.castle_destroyed.connect(_on_castle_destroyed)
	
func create_health_bar():
	"""Connect to manually instantiated castle health bar"""
	if castle_health_bar:
		print("Castle health bar found!")
		castle_health_bar.castle_destroyed.connect(_on_castle_destroyed)
		castle_health_bar.initialize_castle(100)
	else:
		print("Castle health bar not found!")

func _on_enemy_entered(body):
	"""Enemy reached castle"""
	if body.is_in_group("enemies"):
		print("Enemy reached castle!")
		
		# Castle takes damage
		if castle_health_bar:
			castle_health_bar.take_damage(10)  # Damage per enemy
		
		# Remove enemy
		body.queue_free()
		
		# Lose life in GameManager
		GameManager.lose_life(1)

func _on_castle_destroyed():
	"""Castle was destroyed"""
	print("Castle destroyed! Game Over!")
	GameManager.trigger_game_over()
