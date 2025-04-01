extends ThrownCard
class_name ThrownHealingCard

const HEAL_VALUE = 10


func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if shape.is_colliding():
		var obj = shape.get_collider(0)
		
		if obj.is_in_group("Enemy"):
			obj.enemy_hit(damage)
			get_tree().call_group("Player", "heal", HEAL_VALUE)
			
			if slow_value != 0:
				if !obj.slowed && !obj.frozen && !obj.shocked:
					obj.slowed = true
					obj.slowdown(slow_value, slow_damage, slow_att_speed)
					slow_value = 0
					slow_damage = 0
					slow_att_speed = 0
				else:
					slow_value = 0
					slow_damage = 0
					slow_att_speed = 0
					print("slowing not applied")
		else:
			print("hit something")
		
		shape.enabled = false
		queue_free()
