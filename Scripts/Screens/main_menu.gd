extends Control
class_name MainMenu


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")


func _on_description_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/game_description.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
