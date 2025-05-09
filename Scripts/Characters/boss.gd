extends Enemy
class_name Boss


func _ready():
	max_health = 100
	speed_original = 6
	attack_damage_original = 30
	attack_speed_original = 0.6
	
	health = max_health
	speed = speed_original
	attack_damage = attack_damage_original
	attack_speed = attack_speed_original
	
	player = get_node(player_path)
	
	material = body.get_surface_override_material(0)
	original_color = material.albedo_color
	current_color = material.albedo_color


func enemy_hit(damage, is_metal):
	if damage < health:
		health -= damage
		print("enemy hp: %s" % health)
		if !sees_player:
			sees_player = true
			if !GlobalVariables.boss_discovered:
				GlobalVariables.boss_discovered = true
				
		material.albedo_color = Color8(255, 255, 255)
		await get_tree().create_timer(0.1).timeout
		material.albedo_color = current_color
	else:
		health = 0
		queue_free()
		GlobalVariables.enemies_killed += 1
		print("enemy dead")


func _on_hit_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if !sees_player:
			sees_player = true
			if !GlobalVariables.boss_discovered:
				GlobalVariables.boss_discovered = true
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
						if !GlobalVariables.boss_discovered:
							GlobalVariables.boss_discovered = true
