extends BaseEnemy
class_name FastEnemy

func setup_enemy_type():
	max_health = 60.0
	movement_speed = 180.0
	gold_reward = 15
	damage_to_player = 1
	enemy_color = Color.GREEN
	scale_modifier = 0.8
	
	# Apply the stats
	current_health = max_health
	if path_follower:
		path_follower.speed = movement_speed
