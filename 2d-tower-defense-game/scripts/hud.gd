extends CanvasLayer

# UI References
@onready var gold_label = $MarginContainer/HBoxContainer/GoldLabel
@onready var lives_label = $MarginContainer/HBoxContainer/LivesLabel
@onready var wave_label = $MarginContainer/HBoxContainer/WaveLabel

func _ready():
	# Connect to GameManager signals
	GameManager.gold_changed.connect(_on_gold_changed)
	GameManager.lives_changed.connect(_on_lives_changed)
	GameManager.wave_changed.connect(_on_wave_changed)
	
	# Initialize display with current values
	_update_all_displays()
	
	# Style the labels
	_setup_label_styles()

func _setup_label_styles():
	"""Set up the visual styling for HUD labels"""
	# You can customize these styles based on your Kenney assets
	for label in [gold_label, lives_label, wave_label]:
		if label:
			label.add_theme_font_size_override("font_size", 24)
			# You can add more styling here like colors, fonts, etc.

func _update_all_displays():
	"""Update all HUD displays with current GameManager values"""
	_on_gold_changed(GameManager.get_gold())
	_on_lives_changed(GameManager.get_lives())
	_on_wave_changed(GameManager.get_current_wave())

# === SIGNAL HANDLERS ===

func _on_gold_changed(new_gold: int):
	"""Update gold display"""
	if gold_label:
		gold_label.text = "Gold: %d" % new_gold

func _on_lives_changed(new_lives: int):
	"""Update lives display"""
	if lives_label:
		lives_label.text = "Lives: %d" % new_lives
		
		# Change color based on remaining lives
		if new_lives <= 5:
			lives_label.modulate = Color.RED
		elif new_lives <= 10:
			lives_label.modulate = Color.YELLOW
		else:
			lives_label.modulate = Color.WHITE

func _on_wave_changed(new_wave: int):
	"""Update wave display"""
	if wave_label:
		wave_label.text = "Wave: %d" % new_wave

# === UTILITY FUNCTIONS ===

func show_hud():
	"""Show the HUD"""
	visible = true

func hide_hud():
	"""Hide the HUD"""
	visible = false

func flash_gold_label():
	"""Flash the gold label (useful for insufficient funds feedback)"""
	if gold_label:
		var tween = create_tween()
		tween.tween_property(gold_label, "modulate", Color.RED, 0.1)
		tween.tween_property(gold_label, "modulate", Color.WHITE, 0.1)
		tween.tween_property(gold_label, "modulate", Color.RED, 0.1)
		tween.tween_property(gold_label, "modulate", Color.WHITE, 0.1)

func flash_lives_label():
	"""Flash the lives label when taking damage"""
	if lives_label:
		var tween = create_tween()
		var original_scale = lives_label.scale
		tween.tween_property(lives_label, "scale", original_scale * 1.2, 0.1)
		tween.tween_property(lives_label, "scale", original_scale, 0.1)
