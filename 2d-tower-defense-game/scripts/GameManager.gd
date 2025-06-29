extends Node

# Game state signals
signal gold_changed(new_amount)
signal lives_changed(new_amount)
signal wave_changed(new_wave)
signal game_over_triggered
signal pause_toggled(is_paused)

# Game state variables
var gold: int = 100
var lives: int = 20
var current_wave: int = 1
var is_game_paused: bool = false
var is_game_over: bool = false

# Game settings
var starting_gold: int = 200
var starting_lives: int = 10

func _ready():
	# Handle pause input globally
	set_process_unhandled_input(true)

func _unhandled_input(event):
	# Handle pause toggle (ESC key)
	if event.is_action_pressed("ui_cancel") and not is_game_over:
		toggle_pause()

# === CORE GAME STATE MANAGEMENT ===

func new_game():
	"""Start a new game with default values"""
	gold = starting_gold
	lives = starting_lives
	current_wave = 1
	is_game_over = false
	is_game_paused = false
	
	# Emit initial values
	gold_changed.emit(gold)
	lives_changed.emit(lives)
	wave_changed.emit(current_wave)
	
	print("New game started - Gold: %d, Lives: %d, Wave: %d" % [gold, lives, current_wave])

func reset_game():
	"""Reset game state (useful for returning to main menu)"""
	is_game_paused = false
	is_game_over = false
	get_tree().paused = false

# === PAUSE SYSTEM ===

func toggle_pause():
	"""Toggle pause state"""
	if not is_game_over:
		is_game_paused = !is_game_paused
		get_tree().paused = is_game_paused
		pause_toggled.emit(is_game_paused)
		print("Game paused: ", is_game_paused)

func pause_game():
	"""Explicitly pause the game"""
	if not is_game_over and not is_game_paused:
		is_game_paused = true
		get_tree().paused = true
		pause_toggled.emit(is_game_paused)

func resume_game():
	"""Explicitly resume the game"""
	if is_game_paused:
		is_game_paused = false
		get_tree().paused = false
		pause_toggled.emit(is_game_paused)

# === GOLD MANAGEMENT ===

func add_gold(amount: int):
	"""Add gold to player's total"""
	gold += amount
	gold_changed.emit(gold)
	print("Gold added: +%d (Total: %d)" % [amount, gold])

func spend_gold(amount: int) -> bool:
	"""Attempt to spend gold. Returns true if successful"""
	if gold >= amount:
		gold -= amount
		gold_changed.emit(gold)
		print("Gold spent: -%d (Remaining: %d)" % [amount, gold])
		return true
	else:
		print("Not enough gold! Need: %d, Have: %d" % [amount, gold])
		return false

func get_gold() -> int:
	"""Get current gold amount"""
	return gold

# === LIVES MANAGEMENT ===

func lose_life(amount: int = 1):
	"""Lose lives (when enemies reach the end)"""
	lives -= amount
	lives = max(0, lives)  # Don't go below 0
	lives_changed.emit(lives)
	print("Lives lost: -%d (Remaining: %d)" % [amount, lives])
	
	# Check for game over
	if lives <= 0:
		trigger_game_over()

func get_lives() -> int:
	"""Get current lives"""
	return lives

# === WAVE MANAGEMENT ===

func next_wave():
	"""Advance to the next wave"""
	current_wave += 1
	wave_changed.emit(current_wave)
	print("Wave advanced to: %d" % current_wave)

func get_current_wave() -> int:
	"""Get current wave number"""
	return current_wave

# === GAME OVER SYSTEM ===

func trigger_game_over():
	"""Trigger game over state"""
	if not is_game_over:
		is_game_over = true
		is_game_paused = false
		get_tree().paused = false
		
		print("Game Over! Final Stats - Wave: %d, Gold: %d" % [current_wave, gold])
		
		# Change to game over scene instead of emitting signal
		get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")

func is_game_finished() -> bool:
	"""Check if game is in game over state"""
	return is_game_over

# === SCENE MANAGEMENT ===

func go_to_main_menu():
	"""Return to main menu and reset game state"""
	reset_game()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func restart_game():
	"""Restart the current game"""
	reset_game()
	get_tree().change_scene_to_file("res://scenes/game_screen.tscn")

# === UTILITY FUNCTIONS ===

func get_game_stats() -> Dictionary:
	"""Get current game statistics"""
	return {
		"gold": gold,
		"lives": lives,
		"wave": current_wave,
		"is_paused": is_game_paused,
		"is_game_over": is_game_over
	}
