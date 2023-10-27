extends Node2D
@onready var label = $Label

@export var time = 10
var timer_on = true

func _process(delta):
	if(timer_on):
		time -= delta
		if time <= 0:
			get_tree().change_scene_to_file("res://escenas/niveles/perder.tscn")
	
	var secs = fmod(time,60)
	var mins = fmod(time, 60*60) / 60
	
	
	var time_passed = " %02d:%02d " % [mins,secs]
	label.text = time_passed# + " : " + var2str(time)
	
	pass
