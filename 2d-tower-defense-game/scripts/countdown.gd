extends Control

@onready var label = $countdownLabel
@export var time = 10


func _on_timer_timeout() -> void:
	time -= 1
	label.text = str(time) + "s"
	
	if time == 1:
		$Timer.stop()
