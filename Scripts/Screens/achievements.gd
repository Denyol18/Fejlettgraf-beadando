extends Control
class_name Achievements


func _ready() -> void:
	if GlobalVariables.in_a_hurry_unlocked:
		$"ScrollContainer/VBoxContainer/In a Hurry/Label4".text = "Unlocked"
		
	if GlobalVariables.hoarder_unlocked:
		$ScrollContainer/VBoxContainer/Hoarder/Label4.text = "Unlocked"
		
	if GlobalVariables.survivor_unlocked:
		$ScrollContainer/VBoxContainer/Survivor/Label4.text = "Unlocked"
		
	if GlobalVariables.destroyer_unlocked:
		$ScrollContainer/VBoxContainer/Destroyer/Label4.text = "Unlocked"
		
	if GlobalVariables.completionist_unlocked:
		$ScrollContainer/VBoxContainer/Completionist/Label4.text = "Unlocked"


func _on_go_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/main_menu.tscn")
