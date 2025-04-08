extends Control
class_name GameOver


@export var game_over_reason_label : Label


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	game_over_reason_label.text = GlobalVariables.game_over_reason


func _on_new_run_pressed() -> void:
	if GlobalVariables.completionist_unlocked:
		get_tree().change_scene_to_file("res://Scenes/Screens/run_option_selection.tscn")
	else:
		GlobalVariables.normal_mode = true
		get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/main_menu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
