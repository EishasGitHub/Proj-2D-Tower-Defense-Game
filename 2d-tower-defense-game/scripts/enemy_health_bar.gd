extends Control
class_name EnemyHealthBar

@onready var background = $Background
@onready var health_progress = $HealthProgress

var max_health: int = 100
var current_health: int = 100

func _ready():
	# Set initial size and position
	custom_minimum_size = Vector2(50, 8)
	
	# Configure progress bar
	if health_progress:
		health_progress.min_value = 0
		health_progress.max_value = max_health
		health_progress.value = current_health

func initialize(enemy_max_health: int):
	"""Initialize health bar with enemy's max health"""
	max_health = enemy_max_health
	current_health = max_health
	
	if health_progress:
		health_progress.max_value = max_health
		health_progress.value = current_health
	
	update_color()

func update_health(new_health: int):
	"""Update health bar display"""
	current_health = max(0, new_health)
	
	if health_progress:
		health_progress.value = current_health
	
	update_color()
	
	# Hide if enemy is dead
	if current_health <= 0:
		visible = false

func update_color():
	"""Change color based on health percentage"""
	if not health_progress:
		return
	
	var health_percent = float(current_health) / float(max_health)
	var color: Color
	
	if health_percent > 0.6:
		color = Color.GREEN
	elif health_percent > 0.3:
		color = Color.YELLOW
	else:
		color = Color.RED
	
	# Apply color to progress bar
	health_progress.add_theme_color_override("fill", color)

func get_health_percentage() -> float:
	"""Get current health as percentage"""
	return float(current_health) / float(max_health)
