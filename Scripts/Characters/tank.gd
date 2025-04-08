extends Enemy
class_name Tank


func _ready():
	max_health = 100
	speed_original = 4
	attack_damage_original = 20
	attack_speed_original = 1.1
	
	health = max_health
	speed = speed_original
	attack_damage = attack_damage_original
	attack_speed = attack_speed_original
	
	player = get_node(player_path)


func enemy_hit(damage, is_metal):
	if damage < health:
		health -= damage
		print("enemy hp: %s" % health)
		if !sees_player:
			sees_player = true
			if !GlobalVariables.tank_discovered:
				GlobalVariables.tank_discovered = true
	else:
		health = 0
		queue_free()
		GlobalVariables.enemies_killed += 1
		print("enemy dead")


func _on_hit_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if !sees_player:
			sees_player = true
			if !GlobalVariables.tank_discovered:
				GlobalVariables.tank_discovered = true
		player_in_range = true
		while player_in_range:
			await get_tree().create_timer(attack_speed).timeout
			if player_in_range && attack_damage != 0:
				var dir = global_position.direction_to(player.global_position)
				get_tree().call_group("Player", "hit", attack_damage, dir)


func _on_timer_timeout() -> void:
	var overlaps = $VisionArea.get_overlapping_bodies()
	if overlaps.size():
		for overlap in overlaps:
			if overlap.is_in_group("Player"):
				$VisionRayCast.look_at(overlap.global_transform.origin, Vector3.UP)
				if $VisionRayCast.is_colliding():
					var collider = $VisionRayCast.get_collider()
					if collider.is_in_group("Player"):
						sees_player = true
						if !GlobalVariables.tank_discovered:
							GlobalVariables.tank_discovered = true
