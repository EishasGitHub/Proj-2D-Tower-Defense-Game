extends Node2D

@onready var path = preload("res://scenes/path.tscn")
signal enemyDead(gold_reward)

var new_path 
var wave_number
var spawn_interval = 3.0

@onready var spawnTimer = $SpawnTimer
@onready var waveTimer = $WaveTimer
var wave_countdown =  preload("res://scenes/countdown.tscn")



func _ready() -> void:
	GameManager.wave_changed.connect(new_wave)
	new_wave()

func new_wave():
	wave_number = GameManager.current_wave
	
	waveTimer.stop()
	spawnTimer.stop()
	
	var countdown = wave_countdown.instantiate()
	get_tree().current_scene.add_child(countdown)
	
	
	await get_tree().create_timer(10).timeout

	countdown.queue_free()
	
	waveTimer.start()
	spawnTimer.start(spawn_interval)
	
	if wave_number < 5:
		spawn_interval -= 0.4
	
	else: 
		spawn_interval -= 0.2
	
func _on_timer_timeout() -> void:
	var new_path = path.instantiate()
	
	if wave_number < 3:
		new_path.enemyToSpawn = 0
	else:
		new_path.enemyToSpawn = randi_range(0,1)
		
	add_child(new_path)
	new_path.enemyKilled.connect(_on_enemy_dead)
	
	spawnTimer.start(spawn_interval)

func _on_enemy_dead(gold_reward):
	emit_signal("enemyDead", gold_reward)


func _on_wave_timer_timeout() -> void:
	GameManager.emit_signal("wave_changed")
	
	
