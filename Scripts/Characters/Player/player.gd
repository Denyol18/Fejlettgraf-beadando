extends CharacterBody3D
class_name Player


const JUMP_VELOCITY = 4.8
const MAX_HEALTH = 50
const HIT_STAGGER = 30

var health = MAX_HEALTH
var speed = 8.0
var sensitivity = 0.003

var is_bleeding = false
var is_dead = false

signal player_hit

@onready var head = $Head
@onready var camera = $Head/Camera3D


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(80))


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= Global.GRAVITY * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input_dir := Input.get_vector("left", "right", "forward", "backwards")
	var direction = (head.transform.basis * transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)

	move_and_slide()


func hit(damage, knockback):
	if damage < health:
		health -= damage
		emit_signal("player_hit")
		print("player hp: %s" % health)
		if knockback != Vector3.ZERO:
			velocity += knockback * HIT_STAGGER
	else:
		health = 0
		print("player dead")
		GlobalVariables.game_over_reason = "You've been killed by the enemy!"
		get_tree().change_scene_to_file("res://Scenes/Screens/game_over.tscn")


func bleeding(damage):
	for n in 3:
		await get_tree().create_timer(1).timeout
		print("Player bleeding!!!")
		hit(damage, Vector3.ZERO)
		
	is_bleeding = false
