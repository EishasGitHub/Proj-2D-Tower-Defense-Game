extends Area2D
class_name TankTower

@export var detection_range: float = 200.0
@export var rotation_speed: float = 0.8
@export var fire_rate: float = 1.0
@export var bullet_speed: float = 400.0
@export var bullet_damage: int = 10

@onready var tank_sprite = $TankSprite
@onready var bullet_spawn = $BulletSpawn
@onready var collision_shape = $CollisionShape2D

var current_target: Node2D = null
var enemies_in_range: Array[Node2D] = []
var can_shoot: bool = true

func _ready():
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = detection_range
	collision_shape.shape = circle_shape
	
	body_entered.connect(_on_enemy_entered)
	body_exited.connect(_on_enemy_exited)

func _process(delta):
	find_target()
	if current_target:
		rotate_tank_to_target(delta)
		if can_shoot and is_facing_target():
			shoot()

func find_target():
	enemies_in_range = enemies_in_range.filter(func(enemy): return is_instance_valid(enemy))
	
	if enemies_in_range.is_empty():
		current_target = null
		return
	
	var closest_enemy = null
	var closest_distance = INF
	
	for enemy in enemies_in_range:
		var distance = global_position.distance_to(enemy.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy
	
	current_target = closest_enemy

func rotate_tank_to_target(delta):
	if not current_target:
		return
	
	# Calculate direction vector from tank to enemy
	var direction_to_enemy = (current_target.global_position - global_position).normalized()
	var target_angle = direction_to_enemy.angle()
	
	var current_angle = rotation
	
	# Calculate the shortest rotation path
	var angle_diff = angle_difference(current_angle, target_angle)
	var rotation_step = rotation_speed * delta
	
	if abs(angle_diff) > rotation_step:
		rotation += sign(angle_diff) * rotation_step
	else:
		rotation = target_angle

func is_facing_target() -> bool:
	if not current_target:
		return false
	
	# Always return true - tank can shoot while rotating
	return true

func shoot():
	if not current_target:
		return
	
	can_shoot = false
	create_bullet()
	
	await get_tree().create_timer(1.0 / fire_rate).timeout
	can_shoot = true

func create_bullet():
	var bullet = Area2D.new()
	bullet.name = "Bullet"
	
	# Visual
	var rect = ColorRect.new()
	rect.color = Color.YELLOW
	rect.size = Vector2(8, 3)
	rect.position = Vector2(-4, -1.5)  # Center the bullet
	bullet.add_child(rect)
	
	# Collision
	var collision = CollisionShape2D.new()
	var rect_shape = RectangleShape2D.new()
	rect_shape.size = Vector2(8, 3)
	collision.shape = rect_shape
	bullet.add_child(collision)
	
	# Set position at nozzle tip
	bullet.global_position = bullet_spawn.global_position
	
	# Bullet travels straight ahead in the direction the nozzle is pointing
	var nozzle_forward_direction = Vector2.RIGHT.rotated(rotation)
	bullet.rotation = rotation
	
	# Add to scene
	get_tree().current_scene.add_child(bullet)
	
	# Move bullet straight forward from nozzle tip
	var travel_distance = 1000.0
	var travel_time = travel_distance / bullet_speed
	var end_position = bullet.global_position + nozzle_forward_direction * travel_distance
	
	var tween = create_tween()
	tween.tween_property(bullet, "global_position", end_position, travel_time)
	tween.tween_callback(bullet.queue_free)
	
	# Connect collision
	bullet.body_entered.connect(_on_bullet_hit.bind(bullet))

func _on_bullet_hit(bullet, body):
	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			body.take_damage(bullet_damage)
		bullet.queue_free()

func _on_enemy_entered(body):
	if body.is_in_group("enemies"):
		enemies_in_range.append(body)
		print("Enemy entered range: ", body.name)

func _on_enemy_exited(body):
	enemies_in_range.erase(body)
	print("Enemy left range: ", body.name)

# Debug function - add this to see the aiming direction
func _draw():
	if current_target:
		var direction = current_target.global_position - global_position
		draw_line(Vector2.ZERO, direction.normalized() * 50, Color.RED, 3.0)
		
		# Draw tank facing direction for comparison
		var tank_direction = Vector2.RIGHT.rotated(rotation)
		draw_line(Vector2.ZERO, tank_direction * 40, Color.BLUE, 2.0)
