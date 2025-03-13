extends Control
class_name LevelCompleted


@export var info_label : Label
@export var level_1_name = preload("res://Scripts/level_1.gd").LEVEL_NAME


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	info_label.text = "%s completed! Time to complete: %s" % [level_1_name, GlobalVariables.time_to_complete]


func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
