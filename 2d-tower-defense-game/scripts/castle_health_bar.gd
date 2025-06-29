extends CanvasLayer
class_name CastleHealthBar

@onready var castle_label = $HealthContainer/HealthDisplay/CastleLabel
@onready var castle_health_progress = $HealthContainer/HealthDisplay/CastleHealthProgress

var max_health: int = 100
var current_health: int = 100

signal castle_destroyed

func _ready():
	# Initialize castle health
	initialize_castle(100)

func initialize_castle(castle_max_health: int):
	"""Initialize castle health bar"""
	max_health = castle_max_health
	current_health = max_health
	
	if castle_health_progress:
		castle_health_progress.max_value = max_health
		castle_health_progress.value = current_health
	
	update_display()

func take_damage(damage_amount: int):
	"""Castle takes damage"""
	current_health = max(0, current_health - damage_amount)
	
	if castle_health_progress:
		castle_health_progress.value = current_health
	
	update_display()
	
	# Check if castle is destroyed
	if current_health <= 0:
		castle_destroyed.emit()
		print("Castle destroyed!")

func heal_castle(heal_amount: int):
	"""Heal castle (if needed for gameplay)"""
	current_health = min(max_health, current_health + heal_amount)
	
	if castle_health_progress:
		castle_health_progress.value = current_health
	
	update_display()

func update_display():
	"""Update health bar color and label"""
	if not castle_health_progress or not castle_label:
		return
	
	var health_percent = float(current_health) / float(max_health)
	var color: Color
	
	# Color based on health
	if health_percent > 0.7:
		color = Color.BLUE
	elif health_percent > 0.4:
		color = Color.YELLOW
	elif health_percent > 0.2:
		color = Color.ORANGE
	else:
		color = Color.RED
	
	# Apply color
	castle_health_progress.add_theme_color_override("fill", color)
	
	# Update label
	castle_label.text = "Castle Health: %d/%d" % [current_health, max_health]

func get_health_percentage() -> float:
	"""Get castle health percentage"""
	return float(current_health) / float(max_health)

func is_destroyed() -> bool:
	"""Check if castle is destroyed"""
	return current_health <= 0
