extends Node2D

var recorte = null
var recortes = []
# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(self.area_entered)
	$Area2D.area_exited.connect(self.area_exited)

func area_entered(area):
	var recorte = area.get_parent()
	recortes.push_back(recorte)
	
func area_exited(area):
	var recorte = area.get_parent()
	recortes.erase(recorte)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("click"):
		recorte = null
		recortes.map(func(un_recorte):
			if(recorte == null):
				recorte = un_recorte
			if(un_recorte and un_recorte.z_index >= recorte.z_index):
				recorte = un_recorte
		)
		if(recorte):
			recorte.apretado()
