extends StaticBody2D

var bullet = preload("res://scenes/projectile.tscn")
var bulletDamage = 50
var pathName
var targets = []
var currTarget

@onready var turret = $Turret
var shooting = false

func _physics_process(delta: float) -> void:
	if targets.size() != 0:
		select_enemy()
		turn()
		if !shooting:
			fire()

func turn():
	turret.look_at(currTarget.position)

func select_enemy():
	var enemy_progress_array = []
	
	for i in targets:
		enemy_progress_array.append(i.get_parent().get_progress())
		
	var max_progress = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_progress)
	
	currTarget = targets[enemy_index]
	
func fire():
	shooting = true
	currTarget.take_damage(bulletDamage)
	await get_tree().create_timer(1.5).timeout
	shooting = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		targets.append(body)
	
	print(targets)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		targets.erase(body)
