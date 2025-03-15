extends Node3D
class_name Level1

const LEVEL_NAME = "Level 1"

@onready var hit_rect = $PlayerHitUi/ColorRect

@onready var card_spawns = $CardSpawners/CardSpawn
@onready var card_spawns2 = $CardSpawners/CardSpawn2
@onready var card_spawns3 = $CardSpawners/CardSpawn3
@onready var card_spawns4 = $CardSpawners/CardSpawn4
@onready var card_spawns5 = $CardSpawners/CardSpawn5
@onready var card_spawns6 = $CardSpawners/CardSpawn6

@onready var cons_spawns = $ConsSpawners/ConsSpawn
@onready var cons_spawns2 = $ConsSpawners/ConsSpawn2
@onready var cons_spawns3 = $ConsSpawners/ConsSpawn3
@onready var cons_spawns4 = $ConsSpawners/ConsSpawn4
@onready var cons_spawns5 = $ConsSpawners/ConsSpawn5

var card_spawn_array
var cons_spawn_array

var card = load("res://Scenes/Items/Cards/card.tscn")
var consumable = load("res://Scenes/Items/Consumables/the_fist.tscn")
var card_instance
var cons_instance


func _ready() -> void:
	GlobalVariables.level_name = LEVEL_NAME
	GlobalVariables.cards_on_ground = 0
	
	card_spawn_array = [card_spawns, card_spawns2, card_spawns3, card_spawns4, 
						card_spawns5, card_spawns6]
	
	cons_spawn_array = [cons_spawns, cons_spawns2, cons_spawns3, cons_spawns4, cons_spawns5]
	
	#spawn_cards(card_spawn_array)
	spawn_cons(cons_spawn_array)


func _process(delta: float) -> void:
	GlobalVariables.enemies = get_tree().get_nodes_in_group("Enemy")


func get_random_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)


func spawn_cards(array):
	for card_spawner in array:
		for spawn_point in card_spawner.get_children():
			card_instance = card.instantiate()
			card_instance.position = spawn_point.global_position
			$".".add_child(card_instance)
			GlobalVariables.cards_on_ground += 1


func spawn_cons(array):
	for cons_spawner in array:
		cons_instance = consumable.instantiate()
		cons_instance.position = cons_spawner.global_position
		$".".add_child(cons_instance)


func _on_player_player_hit() -> void:
	hit_rect.visible = true
	await get_tree().create_timer(0.2).timeout
	hit_rect.visible = false
