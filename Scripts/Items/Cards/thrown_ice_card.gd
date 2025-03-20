extends ThrownCard
class_name ThrownIceCard

const ICE_CARD_PLUS_DAMAGE = 5

func _process(delta: float) -> void:
	
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if shape.is_colliding():
		var obj = shape.get_collider(0)
		
		if obj.is_in_group("Enemy"):
			
			# ice card specific code begin
			if !obj.frozen && !obj.on_fire:
				obj.enemy_hit(damage+ICE_CARD_PLUS_DAMAGE)
				obj.frozen = true
				obj.freeze()
				
				if slow_value != 0:
					if !obj.slowed && !obj.frozen:
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
			
			elif obj.frozen:
				obj.enemy_hit(damage)
				print("only damage, no freeze")
				
			else:
				print("freeze not applied!")
			# ice card specific code end
		else:
			print("hit something")	
		
		shape.enabled = false
		queue_free()
		

func _on_timer_timeout() -> void:
	print("gone")
	queue_free()
