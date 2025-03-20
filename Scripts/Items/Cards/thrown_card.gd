extends Node3D
class_name ThrownCard

const SPEED = 40
var damage = 10
var slow_value = 0
var slow_damage = 0
var slow_att_speed = 0

@onready var mesh = $MeshInstance3D
@onready var shape = $ShapeCast3D


func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if shape.is_colliding():
		var obj = shape.get_collider(0)
		
		if obj.is_in_group("Enemy"):
			obj.enemy_hit(damage)
			
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
		else:
			print("hit something")
		
		shape.enabled = false
		queue_free()
		

func _on_timer_timeout() -> void:
	print("gone")
	queue_free()
