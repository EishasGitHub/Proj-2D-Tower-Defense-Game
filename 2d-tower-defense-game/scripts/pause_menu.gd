extends Control

# UI References
@onready var resume_button = $ButtonContainer/ResumeButton
@onready var main_menu_button = $ButtonContainer/MainMenuButton
@onready var background = $ColorRect

func _ready():
	# Button signals should be connected through the editor (Node tab)
	# No need to connect them in code if done through editor
	
	# Connect to GameManager pause signal
	GameManager.pause_toggled.connect(_on_pause_toggled)
	
	# Initially hide the pause menu
	hide_menu()
	
	# Set up UI styling
	_setup_ui_style()
	
	# Make sure this menu can process input when paused
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _setup_ui_style():
	"""Set up the visual styling for the pause menu"""
	# Semi-transparent dark background
	if background:
		background.color = Color(0, 0, 0, 0.7)
		background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	
	# Center the VBoxContainer
	#var vbox = $ButtonContainer
	#if vbox:
		#vbox.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
		#vbox.position.x -= vbox.size.x / 2
		#vbox.position.y -= vbox.size.y / 2

func _unhandled_input(event):
	"""Handle input when pause menu is visible"""
	if visible and event.is_action_pressed("ui_cancel"):
		_on_resume_button_pressed()
		get_viewport().set_input_as_handled()

# === SIGNAL HANDLERS ===

func _on_pause_toggled(is_paused: bool):
	"""Show/hide pause menu based on game pause state"""
	if is_paused:
		show_menu()
	else:
		hide_menu()

func _on_resume_button_pressed():
	"""Resume the game"""
	print("Resume button pressed")
	GameManager.resume_game()

func _on_main_menu_button_pressed():
	"""Return to main menu"""
	print("Returning to main menu from pause")
	GameManager.go_to_main_menu()

# === MENU VISIBILITY ===

func show_menu():
	"""Show the pause menu with animation"""
	visible = true
	modulate.a = 0.0
	
	# Fade in animation
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.2)
	
	# Focus the resume button for keyboard navigation
	if resume_button:
		resume_button.grab_focus()

func hide_menu():
	"""Hide the pause menu"""
	visible = false

# === UTILITY FUNCTIONS ===

func is_menu_visible() -> bool:
	"""Check if pause menu is currently visible"""
	return visible
