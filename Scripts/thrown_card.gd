extends Node3D
class_name ThrownCard

const SPEED = 40
var damage = 10

@onready var mesh = $MeshInstance3D
@onready var shape = $ShapeCast3D


func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if shape.is_colliding():
		var obj = shape.get_collider(0)
		
		if obj.is_in_group("Enemy"):
			obj.enemy_hit(damage)
		
		print("hit")
		shape.enabled = false
		queue_free()
		

func _on_timer_timeout() -> void:
	print("gone")
	queue_free()
