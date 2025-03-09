extends CharacterBody3D
class_name Enemy


const MAX_HEALTH = 50
const SPEED_ORIGINAL = 5
const ATTACK_DAMAGE_ORIGINAL = 10
const ATTACK_SPEED_ORIGINAL = 1

var health = MAX_HEALTH
var speed = SPEED_ORIGINAL
var attack_damage = ATTACK_DAMAGE_ORIGINAL
var attack_speed = ATTACK_SPEED_ORIGINAL

var on_fire = false
var slowed = false
var frozen = false

var player = null
@export var player_path : NodePath
var player_in_range = false

@onready var nav_agent = $NavigationAgent3D


func _ready():
	player = get_node(player_path)


func _process(delta: float) -> void:
	velocity = Vector3.ZERO
	
	if !player_in_range:
		nav_agent.set_target_position(player.global_transform.origin)
		var next_nav_point = nav_agent.get_next_path_position()
		velocity = (next_nav_point - global_transform.origin).normalized() * speed
		rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta * 10.0)
	else:
		look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP)
	
	move_and_slide()


func enemy_hit(damage):
	if damage < health:
		health -= damage
		print("enemy hp: %s" % health)
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
			
		if (SPEED_ORIGINAL-slow_value <= 1 && 
			ATTACK_DAMAGE_ORIGINAL-slow_damage <= 1 &&
		 	ATTACK_SPEED_ORIGINAL+slow_att_speed >= 1.9):
			speed = 1
			attack_damage = 1
			attack_speed = 1.9
		else:
			speed = SPEED_ORIGINAL-slow_value
			attack_damage = ATTACK_DAMAGE_ORIGINAL-slow_damage
			attack_speed = ATTACK_SPEED_ORIGINAL+slow_att_speed
		print("Enemy stats: %s, %s, %s" % [speed, attack_damage, attack_speed])
		await get_tree().create_timer(1).timeout
		
	speed = SPEED_ORIGINAL
	attack_damage = ATTACK_DAMAGE_ORIGINAL
	attack_speed = ATTACK_SPEED_ORIGINAL
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
		
	speed = SPEED_ORIGINAL
	attack_damage = ATTACK_DAMAGE_ORIGINAL
	attack_speed = ATTACK_SPEED_ORIGINAL
	frozen = false
	print("Enemy stats: %s, %s, %s" % [speed, attack_damage, attack_speed])


func _on_hit_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_in_range = true
		while player_in_range:
			await get_tree().create_timer(attack_speed).timeout
			if player_in_range && attack_damage != 0:
				get_tree().call_group("Player", "hit", attack_damage)


func _on_hit_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_in_range = false
