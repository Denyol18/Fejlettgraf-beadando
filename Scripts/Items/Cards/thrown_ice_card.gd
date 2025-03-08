extends ThrownCard
class_name ThrownIceCard

const ICE_CARD_PLUS_DAMAGE = 5

func _process(delta: float) -> void:
	
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if shape.is_colliding():
		var obj = shape.get_collider(0)
		
		if obj.is_in_group("Enemy"):
			obj.enemy_hit(damage+ICE_CARD_PLUS_DAMAGE)
			
			if !obj.slowed && slow_value != 0:
				obj.slowed = true
				obj.slowdown(slow_value)
				slow_value = 0
			
			# ice card specific code begin
			if !obj.frozen:
				obj.frozen = true
				obj.freeze()
			else:
				print("cant apply the effect!")
			# ice card specific code end
		else:
			print("hit something")	
		
		shape.enabled = false
		queue_free()
		

func _on_timer_timeout() -> void:
	print("gone")
	queue_free()
