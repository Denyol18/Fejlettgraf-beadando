extends CharacterBody3D
class_name Player


const JUMP_VELOCITY = 4.8

var speed = 8.0
var gravity = 9.8
var sensitivity = 0.003

@onready var head = $Head
@onready var camera = $Head/Camera3D

const MAX_HEALTH = 50
var health = MAX_HEALTH

enum slots {
	SLOT1,
	SLOT2,
	SLOT3,
	SLOT4,
	SLOT5,
	SLOT6,
	SLOT7
}

var current_slot


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#current_slot = slots.SLOT1
	#$PlayerUI/CardSwitchMenu/Slot1/Panel/SlotNumber.set(
	#			"theme_override_colors/font_color", Color(1.0,1.0,0.0,1.0))


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(80))


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("slot_1"):
		current_slot = slots.SLOT1
		$PlayerUI/CardSwitchMenu/Slot1/Panel/SlotNumber.set(
			"theme_override_colors/font_color", Color(1.0,1.0,0.0,1.0))
				
		$PlayerUI/CardSwitchMenu/Slot2/Panel/SlotNumber.set(
			"theme_override_colors/font_color", Color(1.0,1.0,1.0,1.0))
		$PlayerUI/CardSwitchMenu/Slot3/Panel/SlotNumber.set(
			"theme_override_colors/font_color", Color(1.0,1.0,1.0,1.0))	
		$PlayerUI/CardSwitchMenu/Slot4/Panel/SlotNumber.set(
			"theme_override_colors/font_color", Color(1.0,1.0,1.0,1.0))
		$PlayerUI/CardSwitchMenu/Slot5/Panel/SlotNumber.set(
			"theme_override_colors/font_color", Color(1.0,1.0,1.0,1.0))
		$PlayerUI/CardSwitchMenu/Slot6/Panel/SlotNumber.set(
			"theme_override_colors/font_color", Color(1.0,1.0,1.0,1.0))
		$PlayerUI/CardSwitchMenu/Slot7/Panel/SlotNumber.set(
			"theme_override_colors/font_color", Color(1.0,1.0,1.0,1.0))
			
		#"2": 
		#	current_slot = slots.SLOT2
		#	$PlayerUI/CardSwitchMenu/Slot2/Panel/SlotNumber.set(
		#		"theme_override_colors/font_color", Color(1.0,1.0,0.0,1.0))
		#"3": 
		#	current_slot = slots.SLOT3
		#	$PlayerUI/CardSwitchMenu/Slot3/Panel/SlotNumber.set(
		#		"theme_override_colors/font_color", Color(1.0,1.0,0.0,1.0))
		#"4": 
		#	current_slot = slots.SLOT4
		#	$PlayerUI/CardSwitchMenu/Slot4/Panel/SlotNumber.set(
		#		"theme_override_colors/font_color", Color(1.0,1.0,0.0,1.0))
		#"5": 
		#	current_slot = slots.SLOT5
		#	$PlayerUI/CardSwitchMenu/Slot5/Panel/SlotNumber.set(
		#		"theme_override_colors/font_color", Color(1.0,1.0,0.0,1.0))
		#"6": 
		#	current_slot = slots.SLOT6
		#	$PlayerUI/CardSwitchMenu/Slot6/Panel/SlotNumber.set(
		#		"theme_override_colors/font_color", Color(1.0,1.0,0.0,1.0))
		#"7": 
		#	current_slot = slots.SLOT7
		#	$PlayerUI/CardSwitchMenu/Slot7/Panel/SlotNumber.set(
		#		"theme_override_colors/font_color", Color(1.0,1.0,0.0,1.0))

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
