extends BaseEnemy
class_name BasicEnemy

func setup_enemy_type():
	max_health = 50
	movement_speed = 50
	gold_reward = 10
	#damage_to_player = 1
	
	# Apply the stats
	current_health = max_health
