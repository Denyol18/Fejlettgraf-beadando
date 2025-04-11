extends Control
class_name Collection


var card_in_collection = false
var cons_in_collection = false
var enemy_in_collection = false


func _ready() -> void:
	$HBoxContainer/Cards.grab_focus()
	cards_menu_controller()

func _on_go_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Screens/main_menu.tscn")


func _on_cards_pressed() -> void:
	cards_menu_controller()
	
	$"ScrollContainer/VBoxContainer/The Fist".visible = false
	$"ScrollContainer/VBoxContainer/The Snail".visible = false
	$"ScrollContainer/VBoxContainer/The Printer".visible = false
	
	$ScrollContainer/VBoxContainer/Enemy.visible = false
	$ScrollContainer/VBoxContainer/Speedster.visible = false
	$ScrollContainer/VBoxContainer/Tank.visible = false
	$"ScrollContainer/VBoxContainer/Armored Enemy".visible = false
	$ScrollContainer/VBoxContainer/Boss.visible = false


func _on_consumables_pressed() -> void:
	cons_menu_controller()
	
	$ScrollContainer/VBoxContainer/Card.visible = false
	$"ScrollContainer/VBoxContainer/Fire Card".visible = false
	$"ScrollContainer/VBoxContainer/Ice Card".visible = false
	$"ScrollContainer/VBoxContainer/Healing Card".visible = false
	$"ScrollContainer/VBoxContainer/Metal Card".visible = false
	$"ScrollContainer/VBoxContainer/Lightning Card".visible = false
	
	$ScrollContainer/VBoxContainer/Enemy.visible = false
	$ScrollContainer/VBoxContainer/Speedster.visible = false
	$ScrollContainer/VBoxContainer/Tank.visible = false
	$"ScrollContainer/VBoxContainer/Armored Enemy".visible = false
	$ScrollContainer/VBoxContainer/Boss.visible = false


func _on_enemies_pressed() -> void:
	enemy_menu_controller()
	
	$ScrollContainer/VBoxContainer/Card.visible = false
	$"ScrollContainer/VBoxContainer/Fire Card".visible = false
	$"ScrollContainer/VBoxContainer/Ice Card".visible = false
	$"ScrollContainer/VBoxContainer/Healing Card".visible = false
	$"ScrollContainer/VBoxContainer/Metal Card".visible = false
	$"ScrollContainer/VBoxContainer/Lightning Card".visible = false
	
	$"ScrollContainer/VBoxContainer/The Fist".visible = false
	$"ScrollContainer/VBoxContainer/The Snail".visible = false
	$"ScrollContainer/VBoxContainer/The Printer".visible = false


func cards_menu_controller():
	if GlobalVariables.card_discovered:
		$ScrollContainer/VBoxContainer/Card.visible = true
		if !card_in_collection:
			card_in_collection = true
			
	if GlobalVariables.fire_card_discovered:
		$"ScrollContainer/VBoxContainer/Fire Card".visible = true
		if !card_in_collection:
			card_in_collection = true
			
	if GlobalVariables.ice_card_discovered:
		$"ScrollContainer/VBoxContainer/Ice Card".visible = true
		if !card_in_collection:
			card_in_collection = true
			
	if GlobalVariables.healing_card_discovered:
		$"ScrollContainer/VBoxContainer/Healing Card".visible = true
		if !card_in_collection:
			card_in_collection = true
			
	if GlobalVariables.metal_card_discovered:
		$"ScrollContainer/VBoxContainer/Metal Card".visible = true
		if !card_in_collection:
			card_in_collection = true
			
	if GlobalVariables.lightning_card_discovered:
		$"ScrollContainer/VBoxContainer/Lightning Card".visible = true
		if !card_in_collection:
			card_in_collection = true
			
	if !card_in_collection:
		$"ScrollContainer/VBoxContainer/No Items".visible = true
	else:
		$"ScrollContainer/VBoxContainer/No Items".visible = false


func cons_menu_controller():
	if GlobalVariables.the_fist_discovered:
		$"ScrollContainer/VBoxContainer/The Fist".visible = true
		if !cons_in_collection:
			cons_in_collection = true
			
	if GlobalVariables.the_snail_discovered:
		$"ScrollContainer/VBoxContainer/The Snail".visible = true
		if !cons_in_collection:
			cons_in_collection = true
		
	if GlobalVariables.the_printer_discovered:
		$"ScrollContainer/VBoxContainer/The Printer".visible = true
		if !cons_in_collection:
			cons_in_collection = true
	
	if !cons_in_collection:
		$"ScrollContainer/VBoxContainer/No Items".visible = true
	else:
		$"ScrollContainer/VBoxContainer/No Items".visible = false


func enemy_menu_controller():
	if GlobalVariables.enemy_discovered:
		$ScrollContainer/VBoxContainer/Enemy.visible = true
		if !enemy_in_collection:
			enemy_in_collection = true
	
	if GlobalVariables.speedster_discovered:
		$ScrollContainer/VBoxContainer/Speedster.visible = true
		if !enemy_in_collection:
			enemy_in_collection = true
		
	if GlobalVariables.tank_discovered:
		$ScrollContainer/VBoxContainer/Tank.visible = true
		if !enemy_in_collection:
			enemy_in_collection = true
		
	if GlobalVariables.armored_discovered:
		$"ScrollContainer/VBoxContainer/Armored Enemy".visible = true
		if !enemy_in_collection:
			enemy_in_collection = true
		
	if GlobalVariables.boss_discovered:
		$ScrollContainer/VBoxContainer/Boss.visible = true
		if !enemy_in_collection:
			enemy_in_collection = true
	
	if !enemy_in_collection:
		$"ScrollContainer/VBoxContainer/No Items".visible = true
	else:
		$"ScrollContainer/VBoxContainer/No Items".visible = false
