extends Control
class_name GameOver


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
