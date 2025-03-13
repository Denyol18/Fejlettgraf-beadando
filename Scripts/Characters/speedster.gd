extends Enemy
class_name Speedster


const BLEED_DAMAGE = 2


func _ready():
	max_health = 70
	speed_original = 7
	attack_damage_original = 15
	attack_speed_original = 0.5
	
	health = max_health
	speed = speed_original
	attack_damage = attack_damage_original
	attack_speed = attack_speed_original
	
	player = get_node(player_path)


func _on_hit_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_in_range = true
		while player_in_range:
			await get_tree().create_timer(attack_speed).timeout
			if player_in_range && attack_damage != 0:
				get_tree().call_group("Player", "hit", attack_damage, Vector3.ZERO)
				if !body.is_bleeding:
					body.is_bleeding = true
					get_tree().call_group("Player", "bleeding", BLEED_DAMAGE)
