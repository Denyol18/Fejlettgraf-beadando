extends Control
class_name PlayerUI


@export var player_health_label : Label
@export var stopwatch_label : Label
@export var enemy_count_label : Label
@export var level_label : Label 

var player_health
var time = 0.0
var stopped = false
var enemies


func _process(delta: float) -> void:
	update_stopwatch_label()
	player_health = $"..".health
	
	level_label.text = GlobalVariables.level_name
	player_health_label.text = "Health: %s" % player_health
	enemy_count_label.text = "Enemies left: %s" % GlobalVariables.enemies.size()
	
	if GlobalVariables.enemies.size() == 0:
		stopped = true
		GlobalVariables.time_to_complete = stopwatch_label.text
		await get_tree().create_timer(3).timeout
		
		if GlobalVariables.level_name == GlobalVariables.FINAL_LEVEL_NAME:
			get_tree().change_scene_to_file("res://Scenes/Screens/final_level_completed.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/Screens/level_completed.tscn")
	
	if stopped:
		return
	time += delta


func reset():
	time = 0.0
	

func update_stopwatch_label():
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var minute = time / 60
	
	var format_string = "%02d : %02d : %02d"
	var actual_string = format_string % [minute, sec, msec]
	
	stopwatch_label.text = actual_string
