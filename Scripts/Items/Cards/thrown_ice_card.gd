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
						obj.slowdown(slow_value)
						slow_value = 0
					else:
						print("slowness not applied")
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
