extends Node3D
class_name Level1


const LEVEL_NAME = "Level 1"

const MAX_CARDS = 30
const MAX_CONS = 6

var cards_spawned = 0
var cons_spawned = 0

@onready var hit_rect = $PlayerHitUi/ColorRect

@onready var card_spawn_points = $CardSpawnPoints
@onready var cons_spawn_points = $ConsSpawnPoints

var card_spawn_array
var cons_spawn_array

var card = load("res://Scenes/Items/Cards/card.tscn")
var fire_card = load("res://Scenes/Items/Cards/fire_card.tscn")
var ice_card = load("res://Scenes/Items/Cards/ice_card.tscn")
var healing_card = load("res://Scenes/Items/Cards/healing_card.tscn")
var metal_card = load("res://Scenes/Items/Cards/metal_card.tscn")
var lightning_card = load("res://Scenes/Items/Cards/lightning_card.tscn")

var the_fist = load("res://Scenes/Items/Consumables/the_fist.tscn")
var the_snail = load("res://Scenes/Items/Consumables/the_snail.tscn")
var the_printer = load("res://Scenes/Items/Consumables/the_printer.tscn")

var card_instance
var cons_instance

var rng = RandomNumberGenerator.new()

@onready var pause_menu = $PauseMenu
var paused = false

func _ready() -> void:
	randomize()
	
	GlobalVariables.level_name = LEVEL_NAME
	GlobalVariables.cards_on_ground = 0
	
	spawn_cards()
	spawn_cons()
	
	print("%s" % cards_spawned)
	print("%s" % cons_spawned)


func _process(delta: float) -> void:
	GlobalVariables.enemies = get_tree().get_nodes_in_group("Enemy")
	if Input.is_action_just_pressed("pause"):
		on_pause()


func on_pause():
	if paused:
		GlobalVariables.game_paused = false
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		GlobalVariables.game_paused = true
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused


func spawn_cards():
	while(cards_spawned != MAX_CARDS):
		var card_spawner = get_random_child(card_spawn_points)
		if !card_spawner.is_filled:
			
			card_spawner.is_filled = true
			var random_number = rng.randi_range(1, 10)
			
			if random_number == 1:
				card_instance = ice_card.instantiate()
			elif random_number == 2:
				card_instance = fire_card.instantiate()
			elif random_number == 3 && GlobalVariables.survivor_unlocked:
				card_instance = healing_card.instantiate()
			elif random_number == 4 && GlobalVariables.destroyer_unlocked:
				card_instance = metal_card.instantiate()
			elif random_number == 5 && GlobalVariables.in_a_hurry_unlocked:
				card_instance = lightning_card.instantiate()
			else:
				card_instance = card.instantiate()
				
			card_instance.position = card_spawner.global_position
			$".".add_child(card_instance)
			GlobalVariables.cards_on_ground += 1
			cards_spawned += 1


func spawn_cons():
	while(cons_spawned != MAX_CONS):
		var cons_spawner = get_random_child(cons_spawn_points)
		if !cons_spawner.is_filled:
			
			cons_spawner.is_filled = true
			var random_number = rng.randi_range(1, 10)
		
			if 1 <= random_number && random_number <= 3: 
				cons_instance = the_snail.instantiate()
			elif 4 <= random_number && random_number <= 6 && GlobalVariables.hoarder_unlocked:
				cons_instance = the_printer.instantiate()
			else:
				cons_instance = the_fist.instantiate()
			
			cons_instance.position = cons_spawner.global_position
			$".".add_child(cons_instance)
			cons_spawned += 1


func get_random_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)


func _on_player_player_hit() -> void:
	hit_rect.visible = true
	await get_tree().create_timer(0.2).timeout
	hit_rect.visible = false
