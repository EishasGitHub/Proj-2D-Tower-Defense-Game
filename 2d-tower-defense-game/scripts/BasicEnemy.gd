extends BaseEnemy
class_name BasicEnemy

func setup_enemy_type():
	max_health = 100.0
	movement_speed = 100.0
	gold_reward = 10
	damage_to_player = 1
	enemy_color = Color.BLUE
	scale_modifier = 1.0
	
	# Apply the stats
	current_health = max_health
	if path_follower:
		path_follower.speed = movement_speed
