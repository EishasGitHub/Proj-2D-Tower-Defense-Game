extends Path2D

signal enemyKilled(gold_reward)

@onready var baseEnemy = $PathFollow2D/Enemy
@onready var fastEnemy = $PathFollow2D/FastEnemy

var enemy
var enemyToSpawn
var enemySpeed 

@onready var pathfollow = $PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if enemyToSpawn == 0:
		enemy = baseEnemy
	elif enemyToSpawn == 1:
		enemy = fastEnemy
		
	enemy.visible = true
	enemySpeed = enemy.movement_speed
	enemy.enemyDied.connect(_on_enemy_died)

func _process(delta: float) -> void:
	pathfollow.progress += enemySpeed*delta
	
	#if pathfollow.progress_ratio >= 1.0:
		#GameManager.lose_life(1)

func _on_enemy_died(gold_reward):
	emit_signal("enemyKilled", gold_reward)
		
