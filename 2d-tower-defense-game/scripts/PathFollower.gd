extends PathFollow2D
class_name PathFollower

@export var speed: float = 100.0
#@export var loop: bool = false

var is_moving: bool = true

signal path_completed
signal enemy_reached_end

func _ready():
	# Start at the beginning of the path
	progress = 0.0

func _process(delta):
	if not is_moving:
		return
	
	# Move along the path
	progress += speed * delta
	
	# Check if we've reached the end
	if progress_ratio >= 1.0:
		if loop:
			progress = 0.0
		else:
			is_moving = false
			path_completed.emit()
			enemy_reached_end.emit()

func set_speed(new_speed: float):
	speed = new_speed

func pause_movement():
	is_moving = false

func resume_movement():
	is_moving = true

func get_progress_percentage() -> float:
	return progress_ratio
