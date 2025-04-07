extends Node
class_name Global


const GRAVITY = 9.8
const FINAL_LEVEL_NAME = "Level 2"


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

var level_name
var level_name_file_format
var cards_on_ground
var enemies
var game_paused = false

var time_to_complete_text
var time_to_complete
var game_over_reason
var cards_in_inventory
