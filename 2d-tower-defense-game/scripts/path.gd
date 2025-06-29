extends Path2D

signal enemyKilled(gold_reward)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var enemy = $PathFollow2D/Enemy
	enemy.enemyDied.connect(_on_enemy_died)

func _on_enemy_died(gold_reward):
	emit_signal("enemyKilled", gold_reward)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
