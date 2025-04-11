extends Node
class_name Global


const GRAVITY = 9.8
const FINAL_LEVEL_NAME = "Level 3"


var game_started = false

var card_discovered = false
var fire_card_discovered = false
var ice_card_discovered = false
var healing_card_discovered = false
var metal_card_discovered = false
var lightning_card_discovered = false

var the_fist_discovered = false
var the_snail_discovered = false
var the_printer_discovered = false

var enemy_discovered = false
var speedster_discovered = false
var tank_discovered = false
var armored_discovered = false
var boss_discovered = false

var in_a_hurry_unlocked = false
var hoarder_unlocked = false
var survivor_unlocked = false
var destroyer_unlocked = false
var completionist_unlocked = false

var enemies_killed = 0

var normal_mode
var level_name
var level_name_file_format
var cards_on_ground
var enemies
var game_paused = false

var time_to_complete_text
var game_over_reason
var cards_in_inventory


func save_data():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	var save_dict = {
		"card_discovered" : card_discovered,
		"fire_card_discovered" : fire_card_discovered,
		"ice_card_discovered" : ice_card_discovered,
		"healing_card_discovered" : healing_card_discovered,
		"metal_card_discovered" : metal_card_discovered,
		"lightning_card_discovered" : lightning_card_discovered,
		
		"the_fist_discovered" : the_fist_discovered,
		"the_snail_discovered" : the_snail_discovered,
		"the_printer_discovered" : the_printer_discovered,

		"enemy_discovered" : enemy_discovered,
		"speedster_discovered" : speedster_discovered,
		"tank_discovered" : tank_discovered,
		"armored_discovered" : armored_discovered,
		"boss_discovered" : boss_discovered,

		"in_a_hurry_unlocked" : in_a_hurry_unlocked,
		"hoarder_unlocked" : hoarder_unlocked,
		"survivor_unlocked" : survivor_unlocked,
		"destroyer_unlocked" : destroyer_unlocked,
		"completionist_unlocked" : completionist_unlocked,

		"enemies_killed" : enemies_killed
	}
	
	var json_string = JSON.stringify(save_dict)
	save_file.store_line(json_string)
	
	print(json_string)


func load_data():
	if not FileAccess.file_exists("user://savegame.save"):
		save_data()
		
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var data = JSON.parse_string(save_file.get_as_text())
	
	card_discovered = data["card_discovered"]
	fire_card_discovered = data["fire_card_discovered"]
	ice_card_discovered = data["ice_card_discovered"]
	healing_card_discovered = data["healing_card_discovered"]
	metal_card_discovered = data["metal_card_discovered"]
	lightning_card_discovered = data["lightning_card_discovered"]
	
	the_fist_discovered = data["the_fist_discovered"]
	the_snail_discovered = data["the_snail_discovered"]
	the_printer_discovered = data["the_printer_discovered"]
	
	enemy_discovered = data["enemy_discovered"]
	speedster_discovered = data["speedster_discovered"]
	tank_discovered = data["tank_discovered"]
	armored_discovered = data["armored_discovered"]
	boss_discovered = data["boss_discovered"]
	
	in_a_hurry_unlocked = data["in_a_hurry_unlocked"]
	hoarder_unlocked = data["hoarder_unlocked"]
	survivor_unlocked = data["survivor_unlocked"]
	destroyer_unlocked = data["destroyer_unlocked"]
	completionist_unlocked = data["completionist_unlocked"]
	
	enemies_killed = data["enemies_killed"]
	
	print(data)


func delete_save():
	DirAccess.remove_absolute("user://savegame.save")
	
	card_discovered = false
	fire_card_discovered = false
	ice_card_discovered = false
	healing_card_discovered = false
	metal_card_discovered = false
	lightning_card_discovered = false

	the_fist_discovered = false
	the_snail_discovered = false
	the_printer_discovered = false

	enemy_discovered = false
	speedster_discovered = false
	tank_discovered = false
	armored_discovered = false
	boss_discovered = false

	in_a_hurry_unlocked = false
	hoarder_unlocked = false
	survivor_unlocked = false
	destroyer_unlocked = false
	completionist_unlocked = false

	enemies_killed = 0
	
	load_data()
