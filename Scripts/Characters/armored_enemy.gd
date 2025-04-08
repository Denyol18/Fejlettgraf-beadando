extends Enemy
class_name ArmoredEnemy


const MAX_ARMOR = 50
var armor = MAX_ARMOR


func enemy_hit(damage, is_metal):
	if armor > 0 && !is_metal:
		if damage < armor:
			armor -= damage
			print("enemy armor: %s, hp: %s" % [armor, health])
			if !sees_player:
				sees_player = true
				if !GlobalVariables.armored_discovered:
					GlobalVariables.armored_discovered = true
		else:
			var helper = armor
			armor = 0
			print("armor broken")
			if damage-helper < health:
				health -= damage-helper
				print("enemy armor: %s, hp: %s" % [armor, health])
				if !sees_player:
					sees_player = true
					if !GlobalVariables.armored_discovered:
						GlobalVariables.armored_discovered = true
			else:
				health = 0
				queue_free()
				GlobalVariables.enemies_killed += 1
				print("enemy dead")
			
	elif is_metal:
		if damage < health:
			health -= damage
			print("enemy armor: %s, hp: %s" % [armor, health])
			if !sees_player:
				sees_player = true
				if !GlobalVariables.armored_discovered:
					GlobalVariables.armored_discovered = true
		else:
			health = 0
			queue_free()
			GlobalVariables.enemies_killed += 1
			print("enemy dead")
		
	else:
		if damage < health:
			health -= damage
			print("enemy hp: %s" % health)
			if !sees_player:
				sees_player = true
				if !GlobalVariables.armored_discovered:
					GlobalVariables.armored_discovered = true
		else:
			health = 0
			queue_free()
			GlobalVariables.enemies_killed += 1
			print("enemy dead")


func _on_hit_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if !sees_player:
			sees_player = true
			if !GlobalVariables.armored_discovered:
				GlobalVariables.armored_discovered = true
		player_in_range = true
		while player_in_range:
			await get_tree().create_timer(attack_speed).timeout
			if player_in_range && attack_damage != 0:
				get_tree().call_group("Player", "hit", attack_damage, Vector3.ZERO)


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
						if !GlobalVariables.armored_discovered:
							GlobalVariables.armored_discovered = true
