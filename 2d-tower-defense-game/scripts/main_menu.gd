extends Node2D

@onready var credits = $CanvasLayer/Credits

func _on_start_button_pressed() -> void:
	print("Starting game...")
	
	GameManager.reset_game()
	# Transition to game screen
	get_tree().change_scene_to_file("res://scenes/game_screen.tscn")


func _on_credits_button_pressed() -> void:
	credits.popup_centered()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
