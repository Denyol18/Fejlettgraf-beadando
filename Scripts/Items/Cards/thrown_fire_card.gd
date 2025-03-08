extends ThrownCard
class_name ThrownFireCard

const FIRE_DAMAGE = 5

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if shape.is_colliding():
		var obj = shape.get_collider(0)
		
		if obj.is_in_group("Enemy"):
			obj.enemy_hit(damage)
			
			if !obj.slowed && slow_value != 0:
				obj.slowed = true
				obj.slowdown(slow_value)
				slow_value = 0
			
			# fire card specific code begin
			if !obj.on_fire:
				obj.on_fire = true
				obj.burning(FIRE_DAMAGE)
			else:
				print("cant apply the effect!")
			# fire card specific code end
		else:
			print("hit something")	
		
		shape.enabled = false
		queue_free()
		

func _on_timer_timeout() -> void:
	print("gone")
	queue_free()
