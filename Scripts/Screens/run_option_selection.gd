extends Control
class_name RunOptionSelection


func _ready() -> void:
	$VBoxContainer/Normal.button_pressed = true
	GlobalVariables.normal_mode = true


func _on_normal_pressed() -> void:
	GlobalVariables.normal_mode = true


func _on_no_cards_pressed() -> void:
	GlobalVariables.normal_mode = false


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")


func _on_go_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/main_menu.tscn")
