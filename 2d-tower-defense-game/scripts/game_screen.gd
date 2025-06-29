#extends Control
#
## UI References
#@onready var hud = $HUD
#@onready var pause_menu = $PauseMenu
#
## Game world references (add your game nodes here)
## @onready var tower_manager = $TowerManager
## @onready var enemy_spawner = $EnemySpawner
## @onready var path_follow = $PathFollow
#
## UI References
#@onready var green_tank_button = $InventoryUI/HBoxContainer/GreentankButton
#@onready var red_tank_button = $InventoryUI/HBoxContainer/RedTankButton
#@onready var money_label = $InventoryUI/MoneyLabel
#@onready var drag_preview = $DragPreview
#
## Game References
#@onready var game_world = $GameWorld
#@onready var map = $GameWorld/Map
#@onready var tilemap = $GameWorld/Map/TileMap2
#
## Tank Scenes
#const GREEN_TANK_SCENE = preload("res://scenes/tower_1.tscn")
#const RED_TANK_SCENE = preload("res://scenes/tower_2.tscn")
#
## Game State
#var player_money = 500
#var dragging_tank = null
#var drag_data = {}
#
## Tank Costs
#const TANK_COSTS = {
	#"green": 50,
	#"red": 100
#}
#
#func _ready():
	#print("GameScreen loaded")
	#
	## Initialize new game through GameManager
	#GameManager.new_game()
	#
	## Connect to GameManager signals for game state changes
	#GameManager.game_over_triggered.connect(_on_game_over)
	#GameManager.pause_toggled.connect(_on_pause_toggled)
	#
	## Ensure UI elements are properly set up
	#_setup_ui_layers()
	#
	## Start the game logic
	#_start_game()
	#
	#setup_ui()
	#update_money_display()
#
#func _setup_ui_layers():
	#"""Set up UI layering and initial states"""
	## Make sure UI elements have correct process modes
	#if hud:
		#hud.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	#if pause_menu:
		#pause_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	#
	#print("UI layers configured")
#
#func _start_game():
	#"""Initialize and start the game logic"""
	#print("Starting tower defense game...")
	#
	#print("Game will end in 10 seconds for testing...")
	##await get_tree().create_timer(10.0).timeout
	##print("20 seconds passed - triggering game over for testing")
	##
	##GameManager.trigger_game_over()
	## Game is now ready - no demo events
	## Add your actual game logic here later
#
## === GAME STATE HANDLERS ===
#
#func _on_game_over():
	#print("Game over detected in GameScreen")
	#
	## Make sure the game over screen is visible and on top
	##if game_over_screen:
		##print("Showing game over screen...")
		##game_over_screen.show_screen()
	##else:
		##print("ERROR: Game over screen not found!")
		#
	## Stop all game logic
	## enemy_spawner.stop_spawning()
	## tower_manager.disable_towers()
	#
	## The GameOverScreen will automatically show due to its signal connection
#
#func _on_pause_toggled(is_paused: bool):
	#"""Handle pause state changes"""
	#print("Game pause toggled: ", is_paused)
	## You can pause/resume specific game systems here if needed
	## For example:
	## if is_paused:
	##     enemy_spawner.pause_spawning()
	##     tower_manager.pause_towers()
	## else:
	##     enemy_spawner.resume_spawning()
	##     tower_manager.resume_towers()
#
#func _on_tower_placed(tower_type: String, position: Vector2):
	#"""Handle tower placement from inventory"""
	#print("Tower placed: ", tower_type, " at position: ", position)
#
## === UTILITY FUNCTIONS ===
#
#func get_current_game_state() -> Dictionary:
	#"""Get current game state for debugging"""
	#return GameManager.get_game_stats()
#
#func force_game_over():
	#"""Force game over (useful for testing)"""
	#GameManager.trigger_game_over()
#
#func add_debug_gold(amount: int = 100):
	#"""Add gold for debugging purposes"""
	#GameManager.add_gold(amount)
	#
#func setup_ui():
	#green_tank_button.pressed.connect(_on_green_tank_pressed)
	#red_tank_button.pressed.connect(_on_red_tank_pressed)
	#drag_preview.visible = false
	#drag_preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
#
#func _on_green_tank_pressed():
	#start_tank_drag("green", GREEN_TANK_SCENE, green_tank_button.texture_normal)
#
#func _on_red_tank_pressed():
	#start_tank_drag("red", RED_TANK_SCENE, red_tank_button.texture_normal)
#
#func start_tank_drag(tank_type: String, tank_scene: PackedScene, icon: Texture2D):
	#var cost = TANK_COSTS[tank_type]
	#
	#if player_money < cost:
		#print("Not enough money! Need $" + str(cost))
		#return
	#
	#dragging_tank = tank_type
	#drag_data = {
		#"scene": tank_scene,
		#"cost": cost,
		#"type": tank_type
	#}
	#
	#drag_preview.texture = icon
	#drag_preview.visible = true
	#drag_preview.modulate = Color(1, 1, 1, 0.7)
	#
	#print("Started dragging " + tank_type + " tank")
#
#func _input(event):
	#if dragging_tank:
		#if event is InputEventMouseMotion:
			#drag_preview.global_position = get_global_mouse_position() - Vector2(32, 32)
		#elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			#attempt_tank_placement()
#
#func attempt_tank_placement():
	#var drop_position = get_global_mouse_position()
	#
	#if is_valid_placement(drop_position):
		#place_tank(drop_position)
		#spend_money(drag_data.cost)
		#print(drag_data.type + " tank deployed!")
	#else:
		#print("Invalid placement!")
	#
	#stop_dragging()
#
#func place_tank(position: Vector2):
	#var tank_instance = drag_data.scene.instantiate()
	#var snapped_pos = snap_to_grid(position)
	#tank_instance.global_position = snapped_pos
	#map.add_child(tank_instance)
#
#func is_valid_placement(position: Vector2) -> bool:
	#var local_pos = tilemap.to_local(position)
	#var tile_coords = tilemap.local_to_map(local_pos)
	#var tile_id = tilemap.get_cell_source_id(0, tile_coords)
	#
	## Allow placement on tile ID 0 (adjust as needed)
	#return tile_id == 0
#
#func snap_to_grid(position: Vector2) -> Vector2:
	#var local_pos = tilemap.to_local(position)
	#var tile_coords = tilemap.local_to_map(local_pos)
	#return tilemap.to_global(tilemap.map_to_local(tile_coords))
#
#func stop_dragging():
	#dragging_tank = null
	#drag_data.clear()
	#drag_preview.visible = false
#
#func spend_money(amount: int):
	#player_money -= amount
	#update_money_display()
#
#func update_money_display():
	#money_label.text = "Money: $" + str(player_money)




extends Control

# UI References
@onready var hud = $HUD
@onready var pause_menu = $PauseMenu

# Tank UI References (removed money_label)
@onready var green_tank_button = $InventoryUI/HBoxContainer/GreentankButton
@onready var red_tank_button = $InventoryUI/HBoxContainer/RedTankButton
@onready var drag_preview = $DragPreview

# Game References
@onready var game_world = $GameWorld
@onready var map = $GameWorld/Map
@onready var tilemap = $GameWorld/Map/TileMap2
@onready var blocked_area = $GameWorld/Map/BlockedArea

# Tank Scenes
const GREEN_TANK_SCENE = preload("res://scenes/tower_1.tscn")
const RED_TANK_SCENE = preload("res://scenes/tower_2.tscn")

# Game State
var dragging_tank = null
var drag_data = {}

# Tank Costs
const TANK_COSTS = {
	"green": 50,
	"red": 100
}

func _ready():
	print("GameScreen loaded")
	
	# Initialize new game through GameManager
	GameManager.new_game()
	
	# Connect to GameManager signals for game state changes
	GameManager.game_over_triggered.connect(_on_game_over)
	GameManager.pause_toggled.connect(_on_pause_toggled)
	
	# Ensure UI elements are properly set up
	_setup_ui_layers()
	
	# Start the game logic
	_start_game()
	
	setup_ui()

func _setup_ui_layers():
	"""Set up UI layering and initial states"""
	if hud:
		hud.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	if pause_menu:
		pause_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
	print("UI layers configured")

func _start_game():
	"""Initialize and start the game logic"""
	print("Starting tower defense game...")

# === GAME STATE HANDLERS ===

func _on_game_over():
	print("Game over detected in GameScreen")

func _on_pause_toggled(is_paused: bool):
	"""Handle pause state changes"""
	print("Game pause toggled: ", is_paused)

func _on_tower_placed(tower_type: String, position: Vector2):
	"""Handle tower placement from inventory"""
	print("Tower placed: ", tower_type, " at position: ", position)

# === TANK PLACEMENT SYSTEM ===

func setup_ui():
	green_tank_button.pressed.connect(_on_green_tank_pressed)
	red_tank_button.pressed.connect(_on_red_tank_pressed)
	drag_preview.visible = false
	drag_preview.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_green_tank_pressed():
	start_tank_drag("green", GREEN_TANK_SCENE, green_tank_button.texture_normal)

func _on_red_tank_pressed():
	start_tank_drag("red", RED_TANK_SCENE, red_tank_button.texture_normal)

func start_tank_drag(tank_type: String, tank_scene: PackedScene, icon: Texture2D):
	var cost = TANK_COSTS[tank_type]
	
	# Use GameManager for money check
	if GameManager.get_gold() < cost:
		print("Not enough money! Need $" + str(cost))
		# Flash the gold label in HUD to show insufficient funds
		if hud and hud.has_method("flash_gold_label"):
			hud.flash_gold_label()
		return
	
	dragging_tank = tank_type
	drag_data = {
		"scene": tank_scene,
		"cost": cost,
		"type": tank_type
	}
	
	drag_preview.texture = icon
	drag_preview.visible = true
	drag_preview.modulate = Color(1, 1, 1, 0.7)
	
	print("Started dragging " + tank_type + " tank")

func _input(event):
	if dragging_tank:
		if event is InputEventMouseMotion:
			drag_preview.global_position = get_global_mouse_position() - Vector2(32, 32)
		elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			attempt_tank_placement()

func attempt_tank_placement():
	var drop_position = get_global_mouse_position()
	
	if is_valid_placement(drop_position):
		place_tank(drop_position)
		# Use GameManager to spend money
		GameManager.spend_gold(drag_data.cost)
		print(drag_data.type + " tank deployed!")
	else:
		print("Invalid placement - blocked area!")
	
	stop_dragging()

func place_tank(position: Vector2):
	var tank_instance = drag_data.scene.instantiate()
	tank_instance.global_position = position
	map.add_child(tank_instance)

func is_valid_placement(position: Vector2) -> bool:
	# Manual polygon checking
	if blocked_area:
		for child in blocked_area.get_children():
			if child is CollisionPolygon2D:
				if is_point_in_polygon(position, child):
					print("Blocked by polygon: ", child.name)
					return false
	
	# Other checks...
	var viewport_rect = get_viewport().get_visible_rect()
	if not viewport_rect.has_point(position):
		return false
	
	if position.y < 80:
		return false
	
	return true

func is_point_in_polygon(point: Vector2, collision_polygon: CollisionPolygon2D) -> bool:
	if not collision_polygon.polygon or collision_polygon.polygon.is_empty():
		return false
	
	# Convert point to polygon's local space
	var local_point = collision_polygon.to_local(point)
	
	# Use Godot's built-in polygon collision check
	return Geometry2D.is_point_in_polygon(local_point, collision_polygon.polygon)

func stop_dragging():
	dragging_tank = null
	drag_data.clear()
	drag_preview.visible = false

# === UTILITY FUNCTIONS ===

func get_current_game_state() -> Dictionary:
	"""Get current game state for debugging"""
	return GameManager.get_game_stats()

func force_game_over():
	"""Force game over (useful for testing)"""
	GameManager.trigger_game_over()

func add_debug_gold(amount: int = 100):
	"""Add gold for debugging purposes"""
	GameManager.add_gold(amount)
