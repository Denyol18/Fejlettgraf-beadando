extends Control
class_name InventorySlot

@export var icon_slot : TextureRect

var inventory_slot_id : int = -1
var is_filled : bool = false
var is_in_focus : bool = false
var slot_data = ItemData


func fill_slot(data : ItemData):
	slot_data = data
	is_filled = true
	icon_slot.texture = data.icon
