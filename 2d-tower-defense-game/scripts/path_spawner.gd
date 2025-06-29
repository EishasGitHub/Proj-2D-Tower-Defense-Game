extends Node2D

@onready var path = preload("res://scenes/path.tscn")
signal enemyDead(gold_reward)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var new_path = path.instantiate()
	add_child(new_path)
	new_path.enemyKilled.connect(_on_enemy_dead)

func _on_enemy_dead(gold_reward):
	emit_signal("enemyDead", gold_reward)
