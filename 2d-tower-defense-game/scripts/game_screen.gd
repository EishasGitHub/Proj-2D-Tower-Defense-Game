extends Control

# UI References
@onready var hud = $HUD
@onready var pause_menu = $PauseMenu

# Game world references (add your game nodes here)
# @onready var tower_manager = $TowerManager
# @onready var enemy_spawner = $EnemySpawner
# @onready var path_follow = $PathFollow

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

func _setup_ui_layers():
	"""Set up UI layering and initial states"""
	# Make sure UI elements have correct process modes
	if hud:
		hud.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	if pause_menu:
		pause_menu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
	print("UI layers configured")

func _start_game():
	"""Initialize and start the game logic"""
	print("Starting tower defense game...")
	
	print("Game will end in 10 seconds for testing...")
	#await get_tree().create_timer(10.0).timeout
	#print("20 seconds passed - triggering game over for testing")
	#
	#GameManager.trigger_game_over()
	# Game is now ready - no demo events
	# Add your actual game logic here later

# === GAME STATE HANDLERS ===

func _on_game_over():
	print("Game over detected in GameScreen")
	
	# Make sure the game over screen is visible and on top
	#if game_over_screen:
		#print("Showing game over screen...")
		#game_over_screen.show_screen()
	#else:
		#print("ERROR: Game over screen not found!")
		
	# Stop all game logic
	# enemy_spawner.stop_spawning()
	# tower_manager.disable_towers()
	
	# The GameOverScreen will automatically show due to its signal connection

func _on_pause_toggled(is_paused: bool):
	"""Handle pause state changes"""
	print("Game pause toggled: ", is_paused)
	# You can pause/resume specific game systems here if needed
	# For example:
	# if is_paused:
	#     enemy_spawner.pause_spawning()
	#     tower_manager.pause_towers()
	# else:
	#     enemy_spawner.resume_spawning()
	#     tower_manager.resume_towers()

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
