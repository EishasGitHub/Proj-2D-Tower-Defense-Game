extends BaseEnemy
class_name TankEnemy

func setup_enemy_type():
	max_health = 300.0
	movement_speed = 50.0
	gold_reward = 30
	damage_to_player = 3
	enemy_color = Color.RED
	scale_modifier = 1.5
	
	# Apply the stats
	current_health = max_health
	if path_follower:
		path_follower.speed = movement_speed
