extends Control

@onready var game_over_label = $VBoxContainer/GameOverLabel
@onready var stats_label = $VBoxContainer/StatisticsLabel
@onready var main_menu_button = $VBoxContainer/MainMenuButton
@onready var quit_button = $VBoxContainer/QuitButton
@onready var background = $ColorRect

func _ready():
	print("GameOverScreen loaded as separate scene")
	
	# Set up UI
	setup_ui()
	
	# Display final stats
	display_game_stats()

func setup_ui():
	# Black background
	background.color = Color(0, 0, 0, 0.8)
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	
	# Style title
	game_over_label.text = "GAME OVER"
	game_over_label.add_theme_font_size_override("font_size", 48)
	game_over_label.add_theme_color_override("font_color", Color.RED)
	
	# Center container
	$VBoxContainer.set_anchors_and_offsets_preset(Control.PRESET_CENTER)

func display_game_stats():
	# Get stats from GameManager
	if GameManager:
		var stats = GameManager.get_game_stats()
		stats_label.text = """Final Statistics:

Wave Reached: %d
Gold Remaining: %d
Lives Lost: %d

Thank you for playing!""" % [
			stats.wave,
			stats.gold,
			GameManager.starting_lives - stats.lives
		]
	else:
		stats_label.text = "Game Over!"
	
	stats_label.add_theme_font_size_override("font_size", 20)

func _on_main_menu_button_pressed():
	print("Returning to main menu")
	GameManager.go_to_main_menu()

func _on_quit_button_pressed():
	print("Quitting game")
	get_tree().quit()
