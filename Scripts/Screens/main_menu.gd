extends Control
class_name MainMenu


func _on_play_pressed() -> void:
	if GlobalVariables.completionist_unlocked:
		get_tree().change_scene_to_file("res://Scenes/Screens/run_option_selection.tscn")
	else:
		GlobalVariables.normal_mode = true
		get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")


func _on_description_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/game_description.tscn")


func _on_achievements_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/achievements.tscn")


func _on_collection_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/collection.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
