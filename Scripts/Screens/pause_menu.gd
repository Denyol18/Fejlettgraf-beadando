extends Control
class_name PauseMenu


@onready var main = $".."


func _process(delta: float) -> void:
	if main.paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_resume_pressed() -> void:
	main.on_pause()


func _on_new_run_pressed() -> void:
	if GlobalVariables.completionist_unlocked:
		get_tree().change_scene_to_file("res://Scenes/Screens/run_option_selection.tscn")
	else:
		GlobalVariables.normal_mode = true
		get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")
	main.on_pause()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/main_menu.tscn")
	main.on_pause()


func _on_quit_pressed() -> void:
	get_tree().quit()
