extends Control
class_name PlayerUI


@export var player_health_label : Label
@export var stopwatch_label : Label
@export var enemy_count_label : Label
@export var level_label : Label
@export var level_1 = preload("res://Scripts/level_1.gd")

var player_health
var time = 0.0
var stopped = false
var enemies

func _ready() -> void:
	level_label.text = level_1.LEVEL_NAME
	

func _process(delta: float) -> void:
	update_stopwatch_label()
	player_health = $"..".health
	player_health_label.text = "Health: %s" % player_health
	enemy_count_label.text = "Enemies left: %s" % count_enemies()
	
	if count_enemies() == 0:
		stopped = true
	
	if stopped:
		return
	time += delta


func reset():
	time = 0.0


func count_enemies():
	enemies = $".".get_tree().get_nodes_in_group("Enemy")
	return enemies.size()
	

func update_stopwatch_label():
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var minute = time / 60
	
	var format_string = "%02d : %02d : %02d"
	var actual_string = format_string % [minute, sec, msec]
	
	stopwatch_label.text = actual_string
