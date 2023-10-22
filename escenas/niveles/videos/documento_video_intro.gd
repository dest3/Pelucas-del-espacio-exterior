extends Control

@onready var video_documentos = $VideoStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	video_documentos.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("click"):
		if video_documentos.is_playing():
			get_tree().change_scene_to_file("res://escenas/niveles/mi_cucha_game.tscn")
