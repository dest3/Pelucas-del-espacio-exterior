extends Control

@onready var video_intro = $VideoStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	video_intro.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("click"):
		if video_intro.is_playing():
			get_tree().change_scene_to_file("res://escenas/niveles/menu.tscn")
	


func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://escenas/niveles/menu.tscn")
