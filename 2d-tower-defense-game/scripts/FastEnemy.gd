extends BaseEnemy
class_name FastEnemy

func setup_enemy_type():
	max_health = 30.0
	movement_speed = 100
	gold_reward = 15
	#damage_to_player = 1
	
	# Apply the stats
	current_health = max_health
