extends Enemy
class_name Speedster


const BLEED_DAMAGE = 2


func _ready():
	max_health = 50
	speed_original = 7
	attack_damage_original = 10
	attack_speed_original = 0.5
	
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
			if !GlobalVariables.speedster_discovered:
				GlobalVariables.speedster_discovered = true
	else:
		health = 0
		queue_free()
		print("enemy dead")


func _on_hit_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if !sees_player:
			sees_player = true
			if !GlobalVariables.speedster_discovered:
				GlobalVariables.speedster_discovered = true
		player_in_range = true
		while player_in_range:
			await get_tree().create_timer(attack_speed).timeout
			if player_in_range && attack_damage != 0:
				get_tree().call_group("Player", "hit", attack_damage, Vector3.ZERO)
				if !body.is_bleeding:
					body.is_bleeding = true
					get_tree().call_group("Player", "bleeding", BLEED_DAMAGE)


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
						if !GlobalVariables.speedster_discovered:
							GlobalVariables.speedster_discovered = true
