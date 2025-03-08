extends ThrownCard
class_name ThrownFireCard

const FIRE_DAMAGE = 5

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if shape.is_colliding():
		var obj = shape.get_collider(0)
		
		if obj.is_in_group("Enemy"):
			
			# fire card specific code begin
			if !obj.on_fire && !obj.frozen:
				obj.enemy_hit(damage)
				obj.on_fire = true
				obj.burning(FIRE_DAMAGE)
				
				if slow_value != 0:
					if !obj.slowed && !obj.frozen:
						obj.slowed = true
						obj.slowdown(slow_value)
						slow_value = 0
					else:
						print("slowness not applied")
					
			elif obj.frozen:
				obj.speed = obj.SPEED_ORIGINAL
				obj.frozen = false
				print("ice melted! %s" % obj.speed)
			else:
				print("burn not applied!")
			# fire card specific code end
		else:
			print("hit something")	
		
		shape.enabled = false
		queue_free()
		

func _on_timer_timeout() -> void:
	print("gone")
	queue_free()
