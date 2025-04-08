extends Node
class_name InventoryHandler


@export var item_slot_count : int = 7
@export var inventory_grid : HBoxContainer
@export var inventory_slot_prefab : PackedScene = preload("res://Scenes/inventory_slot.tscn")
@export var pause_menu = preload("res://Scripts/Screens/pause_menu.gd")

var inventory_slots : Array[InventorySlot] = []
var current_slot : InventorySlot

var instance
var player_rotation

var fist_pickedup = false
var snail_pickedup = false

const FIST_BONUS_DAMAGE = 10
var bonus_damage = 0
const SNAIL_SLOW_VALUE = 2
const SNAIL_ATTACK_DAMAGE = 3
const SNAIL_ATTACK_SPEED = 0.3
var slow_value = 0
var slow_damage = 0
var slow_att_speed = 0

@onready var player_body = $"../.."
@onready var head = $"../../Head"
@onready var marker = $"../../Head/Camera3D/Marker3D"


func _ready() -> void:
	for i in item_slot_count:
		
		var slot = inventory_slot_prefab.instantiate() as InventorySlot
		inventory_grid.add_child(slot)
		slot.inventory_slot_id = 1
		slot.slot_data = null
		inventory_slots.append(slot)
	
	inventory_slots[0].grab_focus()
	inventory_slots[0].is_in_focus = true
	current_slot = inventory_slots[0]
	
	if GlobalVariables.normal_mode:
		var starter : ItemData = ItemData.new()
		starter.item_name = "Card"
		starter.item_model_prefab = preload("res://Scenes/Items/Cards/card.tscn")
		starter.thrown_item_model_prefab = preload("res://Scenes/Items/Cards/thrown_card.tscn")
		starter.icon = preload("res://Icons/card.png")
		GlobalVariables.card_discovered = true
		
		inventory_slots[0].fill_slot(starter)
		inventory_slots[1].fill_slot(starter)
		inventory_slots[2].fill_slot(starter)
		inventory_slots[3].fill_slot(starter)
		inventory_slots[4].fill_slot(starter)

func pickup_card(item : ItemData):
	var found_slot = false
	
	for slot in inventory_slots:
		if (!slot.is_filled):
			slot.fill_slot(item)
			GlobalVariables.cards_on_ground -= 1
			found_slot = true
			match item.item_name:
				"Card":
					if !GlobalVariables.card_discovered:
						GlobalVariables.card_discovered = true
				"Fire Card":
					if !GlobalVariables.fire_card_discovered:
						GlobalVariables.fire_card_discovered = true
				"Ice Card":
					if !GlobalVariables.ice_card_discovered:
						GlobalVariables.ice_card_discovered = true
				"Healing Card":
					if !GlobalVariables.healing_card_discovered:
						GlobalVariables.healing_card_discovered = true
				"Metal Card":
					if !GlobalVariables.metal_card_discovered:
						GlobalVariables.metal_card_discovered = true
				"Lightning Card":
					if !GlobalVariables.lightning_card_discovered:
						GlobalVariables.lightning_card_discovered = true
			break
			
	if (!found_slot):
		instance = item.item_model_prefab.instantiate()
		layer_changer(instance)
		instance.position = marker.global_position
		instance.transform.basis = marker.global_transform.basis
		get_parent().add_child(instance)
		player_rotation = marker.global_transform.basis.z.normalized()
		instance.apply_central_impulse(player_rotation * -5 + Vector3(0, 1.5, 0))
		print("cant pickup!")
		await get_tree().create_timer(0.5).timeout
		layer_changer_back(instance)


func pickup_consumable(item : ItemData):
	match (item.item_name):
		"The Fist":
			fist_pickedup = true
			bonus_damage += FIST_BONUS_DAMAGE
			print("Next thrown card deals bonus damage!")
			if !GlobalVariables.the_fist_discovered:
				GlobalVariables.the_fist_discovered = true
		
		"The Snail":
			snail_pickedup = true
			slow_value += SNAIL_SLOW_VALUE
			slow_damage += SNAIL_ATTACK_DAMAGE
			slow_att_speed += SNAIL_ATTACK_SPEED
			print("Next thrown card slows down the enemy!")
			if !GlobalVariables.the_snail_discovered:
				GlobalVariables.the_snail_discovered = true
		
		"The Printer":
			if !GlobalVariables.the_printer_discovered:
				GlobalVariables.the_printer_discovered = true
			var helper = 0
			for slot in inventory_slots:
				if slot.is_in_focus && slot.is_filled:
					for slot2 in inventory_slots:
						if (!slot2.is_filled):
							slot2.fill_slot(slot.slot_data)
							helper += 1
							if helper == 2:
								print("Created two copies of the card currently in your hand!")
								break
					if helper == 1:
						print("Created only one copy of the card currently in your hand!")
					elif helper == 0:
						print("No free space to create copies of the card currently in your hand!")
					break
				elif slot.is_in_focus && !slot.is_filled:
					print("No card in hand, no copies were created!")
					break


func _process(_delta: float) -> void:
	is_game_over()
	
	if !GlobalVariables.game_paused:
		current_slot.grab_focus()
	
	if current_slot.slot_data != null:
		if current_slot.slot_data.item_name == "Lightning Card":
			get_tree().call_group("Player", "change_speed", 11.0)
		else:
			get_tree().call_group("Player", "change_speed", player_body.ORIGINAL_SPEED)
	else:
		get_tree().call_group("Player", "change_speed", player_body.ORIGINAL_SPEED)
	
	if Input.is_action_just_released("slot_up"):
		var index = 0
		for slot in inventory_slots:
			if slot.is_in_focus == true:
				if index == item_slot_count-1:
					index = 0
					slot.is_in_focus = false
					inventory_slots[0].grab_focus()
					inventory_slots[0].is_in_focus = true
					current_slot = inventory_slots[0]
					break
				slot.is_in_focus = false
				inventory_slots[index+1].grab_focus()
				inventory_slots[index+1].is_in_focus = true
				current_slot = inventory_slots[index+1]
				break
			index += 1

	if Input.is_action_just_released("slot_down"):
		var index = 0
		for i in inventory_slots:
			if i.is_in_focus == true:
				i.is_in_focus = false
				inventory_slots[index-1].grab_focus()
				inventory_slots[index-1].is_in_focus = true
				current_slot = inventory_slots[index-1]
				break
			index += 1

	if Input.is_action_just_pressed("card_throw") && !GlobalVariables.game_paused:
		for i in inventory_slots:
			if i.is_in_focus && i.is_filled:
				instance = i.slot_data.thrown_item_model_prefab.instantiate()
				if fist_pickedup:
					instance.damage += bonus_damage
					bonus_damage = 0
					fist_pickedup = false
				if snail_pickedup:
					instance.slow_value += slow_value
					instance.slow_damage += slow_damage
					instance.slow_att_speed += slow_att_speed
					slow_value = 0
					slow_damage = 0
					slow_att_speed = 0
					snail_pickedup = false
				remove_from_slot(i)
				print("card thrown")

	if Input.is_action_just_pressed("card_drop"):
		for i in inventory_slots:
			if i.is_in_focus && i.is_filled:
				instance = i.slot_data.item_model_prefab.instantiate()
				layer_changer(instance)
				remove_from_slot(i)
				player_rotation = marker.global_transform.basis.z.normalized()
				instance.apply_central_impulse(player_rotation * -5 + Vector3(0, 1.5, 0))
				GlobalVariables.cards_on_ground += 1
				print("card dropped")
				await get_tree().create_timer(0.5).timeout
				layer_changer_back(instance)


func remove_from_slot(slot : InventorySlot):
	instance.position = marker.global_position
	instance.transform.basis = marker.global_transform.basis
	get_parent().add_child(instance)
	
	slot.is_filled = false
	slot.slot_data = null
	slot.icon_slot.texture = null


func is_game_over():
	#print(GlobalVariables.cards_on_ground)
	if GlobalVariables.cards_on_ground == 0 && GlobalVariables.enemies.size() != 0:
		var is_empty = true
		
		for slot in inventory_slots:
			if (slot.is_filled):
				is_empty = false
				break
				
		if is_empty:
			GlobalVariables.game_over_reason = "You ran out of cards!"
			await get_tree().create_timer(3).timeout
			get_tree().change_scene_to_file("res://Scenes/Screens/game_over.tscn")


func cards_in_inventory():
	GlobalVariables.cards_in_inventory = 0
	for slot in inventory_slots:
		if slot.is_filled:
			GlobalVariables.cards_in_inventory += 1


func layer_changer(card):
	card.set_collision_layer_value(2, true)
	card.set_collision_mask_value(2, true)
	card.set_collision_layer_value(1, false)
	card.set_collision_mask_value(1, false)
	card.set_collision_layer_value(3, false)
	card.set_collision_mask_value(3, false)
	

func layer_changer_back(card):
	card.set_collision_layer_value(2, false)
	card.set_collision_mask_value(2, false)
	card.set_collision_layer_value(1, true)
	card.set_collision_mask_value(1, true)
	card.set_collision_layer_value(3, true)
	card.set_collision_mask_value(3, true)
