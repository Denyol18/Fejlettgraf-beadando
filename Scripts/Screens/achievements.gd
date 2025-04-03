extends Control
class_name Achievements


func _on_go_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/main_menu.tscn")
