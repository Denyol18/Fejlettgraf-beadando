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
				obj.enemy_hit(damage, false)
				obj.on_fire = true
				obj.burning(FIRE_DAMAGE)
				
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
			
			elif obj.on_fire:
				obj.enemy_hit(damage, false)
				print("only damage, no burn")
			
			elif obj.frozen:
				obj.speed = obj.speed_original
				obj.frozen = false
				print("ice melted! %s" % obj.speed)
			# fire card specific code end
		else:
			print("hit something")	
		
		shape.enabled = false
		queue_free()
		

func _on_timer_timeout() -> void:
	print("gone")
	queue_free()
