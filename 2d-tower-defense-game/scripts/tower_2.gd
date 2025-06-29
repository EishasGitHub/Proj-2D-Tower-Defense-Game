extends StaticBody2D

var bullet = preload("res://scenes/projectile_2.tscn")
var bulletDamage = 30
var pathName
var targets = []
var currTarget

var shooting = false

@onready var turret = $Turret
@onready var marker = $Turret/Marker2D
var rotation_speed: float = 30

@export var tower_cost: int = 100

func _physics_process(delta: float) -> void:
	if targets.size() != 0:
		select_enemy()

		var angle_to_target = global_position.angle_to_point(currTarget.global_position)
		angle_to_target += deg_to_rad(90)
		turret.rotation = lerp_angle(turret.rotation, angle_to_target, rotation_speed*delta)
		
		if !shooting:
			fire()

func select_enemy():
	var enemy_progress_array = []
	
	for i in targets:
		enemy_progress_array.append(i.get_parent().get_progress())
		
	var max_progress = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_progress)
	
	currTarget = targets[enemy_index]

func fire():
	shooting = true
	var fired_bullet = bullet.instantiate()
	fired_bullet.global_position = marker.global_position
	
	var shoot_direction = (currTarget.global_position-fired_bullet.global_position).normalized()
	fired_bullet.rotation = shoot_direction.angle()
	
	get_tree().current_scene.add_child(fired_bullet)
	
	#currTarget.take_damage(bulletDamage)
	
	await get_tree().create_timer(3).timeout
	shooting = false
	

func get_tower_cost() -> int:
	return tower_cost


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		targets.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		targets.erase(body)


func get_tile_position() -> Vector2i:
	var tilemap = get_node("../../TileMap2")
	var local_pos = tilemap.to_local(global_position)
	return tilemap.local_to_map(local_pos)
