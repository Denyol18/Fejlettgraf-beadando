extends Control
class_name Collection


func _on_go_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/main_menu.tscn")


func _on_cards_pressed() -> void:
	$ScrollContainer/VBoxContainer/Card.visible = true
	$"ScrollContainer/VBoxContainer/Fire Card".visible = true
	$"ScrollContainer/VBoxContainer/Ice Card".visible = true
	$"ScrollContainer/VBoxContainer/Healing Card".visible = true
	$"ScrollContainer/VBoxContainer/Metal Card".visible = true
	$"ScrollContainer/VBoxContainer/Lightning Card".visible = true
	
	$"ScrollContainer/VBoxContainer/The Fist".visible = false
	$"ScrollContainer/VBoxContainer/The Snail".visible = false
	$"ScrollContainer/VBoxContainer/The Printer".visible = false
	
	$ScrollContainer/VBoxContainer/Enemy.visible = false
	$ScrollContainer/VBoxContainer/Speedster.visible = false
	$ScrollContainer/VBoxContainer/Tank.visible = false
	$"ScrollContainer/VBoxContainer/Armored Enemy".visible = false
	$ScrollContainer/VBoxContainer/Boss.visible = false


func _on_consumables_pressed() -> void:
	$ScrollContainer/VBoxContainer/Card.visible = false
	$"ScrollContainer/VBoxContainer/Fire Card".visible = false
	$"ScrollContainer/VBoxContainer/Ice Card".visible = false
	$"ScrollContainer/VBoxContainer/Healing Card".visible = false
	$"ScrollContainer/VBoxContainer/Metal Card".visible = false
	$"ScrollContainer/VBoxContainer/Lightning Card".visible = false
	
	$"ScrollContainer/VBoxContainer/The Fist".visible = true
	$"ScrollContainer/VBoxContainer/The Snail".visible = true
	$"ScrollContainer/VBoxContainer/The Printer".visible = true
	
	$ScrollContainer/VBoxContainer/Enemy.visible = false
	$ScrollContainer/VBoxContainer/Speedster.visible = false
	$ScrollContainer/VBoxContainer/Tank.visible = false
	$"ScrollContainer/VBoxContainer/Armored Enemy".visible = false
	$ScrollContainer/VBoxContainer/Boss.visible = false


func _on_enemies_pressed() -> void:
	$ScrollContainer/VBoxContainer/Card.visible = false
	$"ScrollContainer/VBoxContainer/Fire Card".visible = false
	$"ScrollContainer/VBoxContainer/Ice Card".visible = false
	$"ScrollContainer/VBoxContainer/Healing Card".visible = false
	$"ScrollContainer/VBoxContainer/Metal Card".visible = false
	$"ScrollContainer/VBoxContainer/Lightning Card".visible = false
	
	$"ScrollContainer/VBoxContainer/The Fist".visible = false
	$"ScrollContainer/VBoxContainer/The Snail".visible = false
	$"ScrollContainer/VBoxContainer/The Printer".visible = false
	
	$ScrollContainer/VBoxContainer/Enemy.visible = true
	$ScrollContainer/VBoxContainer/Speedster.visible = true
	$ScrollContainer/VBoxContainer/Tank.visible = true
	$"ScrollContainer/VBoxContainer/Armored Enemy".visible = true
	$ScrollContainer/VBoxContainer/Boss.visible = true
