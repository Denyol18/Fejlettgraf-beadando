extends CharacterBody3D
class_name Enemy


var max_health = 50
var speed_original = 5
var attack_damage_original = 10
var attack_speed_original = 0.8

var health = max_health
var speed = speed_original
var attack_damage = attack_damage_original
var attack_speed = attack_speed_original

var on_fire = false
var slowed = false
var frozen = false

@export var player_path : NodePath
var player = null
var next_nav_point
var player_in_range = false

var sees_player = false

@onready var nav_agent = $NavigationAgent3D


func _ready():
	player = get_node(player_path)


func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	if sees_player:
		if !player_in_range && !frozen:
			nav_agent.set_target_position(player.global_transform.origin)
			next_nav_point = nav_agent.get_next_path_position()
			velocity = (next_nav_point - global_transform.origin).normalized() * speed
			rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta * 10.0)
		elif !frozen:
			look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
		
		move_and_slide()


func enemy_hit(damage):
	if damage < health:
		health -= damage
		print("enemy hp: %s" % health)
		if !sees_player:
			sees_player = true
	else:
		health = 0
		queue_free()
		print("enemy dead")


func burning(damage):
	for n in 3:
		await get_tree().create_timer(1).timeout
		print("ON FIRE!!!")
		enemy_hit(damage)
		
	on_fire = false


func slowdown(slow_value, slow_damage, slow_att_speed):
	for n in 3:
		if frozen:
			return
			
		if speed_original-slow_value <= 1:
			speed = 1
		else:
			speed = speed_original-slow_value
			
		if attack_damage_original-slow_damage <= 1:
			attack_damage = 1
		else:
			attack_damage = attack_damage_original-slow_damage
			
		if attack_speed_original+slow_att_speed >= 2.0:
			attack_speed = 2.0
		else:
			attack_speed = attack_speed_original+slow_att_speed
			
		print("Enemy stats: %s, %s, %s" % [speed, attack_damage, attack_speed])
		await get_tree().create_timer(1).timeout
		
	speed = speed_original
	attack_damage = attack_damage_original
	attack_speed = attack_speed_original
	slowed = false
	print("Enemy stats: %s, %s, %s" % [speed, attack_damage, attack_speed])


func freeze():
	for n in 2:
		if !frozen:
			return

		speed = 0
		attack_damage = 0
		attack_speed = 0
		print("Enemy stats: %s, %s, %s" % [speed, attack_damage, attack_speed])
		await get_tree().create_timer(1).timeout
		
	speed = speed_original
	attack_damage = attack_damage_original
	attack_speed = attack_speed_original
	frozen = false
	print("Enemy stats: %s, %s, %s" % [speed, attack_damage, attack_speed])


func _on_hit_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		if !sees_player:
			sees_player = true
		player_in_range = true
		while player_in_range:
			await get_tree().create_timer(attack_speed).timeout
			if player_in_range && attack_damage != 0:
				get_tree().call_group("Player", "hit", attack_damage, Vector3.ZERO)


func _on_hit_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_in_range = false


func _on_timer_timeout() -> void:
	var overlaps = $VisionArea.get_overlapping_bodies()
	if overlaps.size():
		for overlap in overlaps:
			if overlap.is_in_group("Player"):
				$VisionRayCast.look_at(overlap.global_transform.origin, Vector3.UP)
				if $VisionRayCast.is_colliding():
					var collider = $VisionRayCast.get_collider()
					if collider.is_in_group("Player"):
						sees_player = true
