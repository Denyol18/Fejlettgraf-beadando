extends Area3D

signal on_card_pickedup(item)
signal on_consumable_pickedup(item)

@export var item_types : Array[ItemData] = []


func on_item_entered_area(body: Node3D):
	if (body is Card || body is Consumable):
		body.queue_free()
		var item_prefab = body.scene_file_path
		for i in item_types.size():
			if (item_types[i].item_model_prefab != null and 
			item_types[i].item_model_prefab.resource_path == item_prefab):
				print("Item picked up: " + item_types[i].item_name)
				if (body is Card):
					on_card_pickedup.emit(item_types[i])
				elif (body is Consumable):
					on_consumable_pickedup.emit(item_types[i])
				return
		
