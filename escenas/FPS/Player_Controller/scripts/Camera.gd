extends Node3D

@onready var MainCamera = get_node("%MainCamera")

@export_group("Weapon Spray Parametres")
@export var weapon_spray_max_x := 15.0
@export var weapon_spray_max_z := 20.0

@export_range (0.0,0.1)var screen_shake_bounce_response = .05

@export_group("Head Movement Parametres")
var HeadMovement: bool  = false
var Jumping: bool = false
## Rotation in Degrees on Left Step
@export var Head_Bob_Left_Max : float = .1
## Rotation in Degrees on Right Step
@export var Head_Bob_Right_Max : float = -.1
## Peak Height of Head Bob
@export var Head_Bob_Height_Max : float = .005
## Duration of the Head Bob. Lower the speed the faster the movement. Also Controls the Strafe Rotation Duration.
@export var Head_Bob_Movement_Duration : float = .3
## The Camera Rotation on Strafe. Only Rotates on Z Axis
@export var Strafe_Rotation : float = .5

@export_group("Jump Juice Parametres")
## The Camera Shakes on Lading a Jump. 
@export var JumpIntensity: Vector4

@export_group("Procedule Animations")
@export var Sway_Target: Node3D
## The Maximum Sway on Horizontal Mouse Movement
@export var Max_Sway_x_degree: int = 15
## The Maximum Sway on Vertical Mouse Movement
@export var Max_Sway_y_degree: int = 15
## The Maximum Lag on Horizontal Movement
@export var Max_Sway_Strafe_Movement: float = .01
## The Maximum Left/Right Movement on Player Forward Movement
@export var Max_Sway_Walk_Movement: float =.005
## The Maximum Y Movement on Player Jump
@export var Max_Y_Jump_Movement: float = .01
## The Maximum Y Rotation on Player Jump
@export var Max_Y_Jump_Rotation: float = 2
#@export var Idle_Y_Movement: float = .01
var Starting_Y_Pos

signal camera_reset
signal start_shake

var tween
var BaseZoom: int

func _ready():
	Starting_Y_Pos = Sway_Target.position.y
	BaseZoom = MainCamera.get_fov()

func Shake_Camera(Spray: Vector3, Magnetude:Vector4, Rebound:Vector3i = Vector3i.ZERO):
	var x_rot = min(-Spray.y*Magnetude.y,weapon_spray_max_x)
	var y_rot = Spray.x*Magnetude.x
	var z_rot = min(abs(Spray.z*Magnetude.z),weapon_spray_max_z)

	var Shake_Rotation = Vector3(x_rot,y_rot,z_rot)*Magnetude.w

	tween  = get_tree().create_tween().tween_property(MainCamera,"rotation_degrees",Shake_Rotation,.1)
	tween.set_trans(Tween.TRANS_LINEAR)
	
	if Rebound.x:
		tween.finished.connect(X_Axis_BounceBack)
	if Rebound.y:
		tween.finished.connect(Y_Axis_BounceBack)
	if Rebound.z:
		tween.finished.connect(Z_Axis_BounceBack)

func Reset_Camera():
	camera_reset.emit(MainCamera.get_rotation().x,MainCamera.get_rotation().y)
	
func Camera_Position_Tween_To_Zero():
	tween = get_tree().create_tween().tween_property(MainCamera,"rotation_degrees:x",0.0,.2)
	tween = get_tree().create_tween().tween_property(MainCamera,"rotation_degrees:y",0.0,.2)

func Camera_Position_To_Zero():
	MainCamera.rotation.x = 0
	MainCamera.rotation.y = 0

func _on_weapons_manager_spray_rotation(Spray_Rotation, x_mag, y_mag, z_mag, Magnetude, count):
	if count == 1:
		start_shake.emit()

	var New_y = max(-Spray_Rotation.y,MainCamera.get_rotation_degrees().x)
	
	var Spray_Shake = Vector3(Spray_Rotation.x, -New_y, Spray_Rotation.x)
	var Spay_Magnetude = Vector4(x_mag,y_mag,z_mag,Magnetude)
	var Spray_Rebound = Vector3i(false,false,true)
		
	Shake_Camera(Spray_Shake, Spay_Magnetude,Spray_Rebound)

func _on_weapons_manager_reset_spray():
	Reset_Camera()

func Z_Axis_BounceBack():
	var z_rot = -MainCamera.get_rotation_degrees().z/2
	
	if is_zero_approx(z_rot):
		return

	var bounce_tween = get_tree().create_tween().tween_property(MainCamera,"rotation_degrees:z",z_rot,screen_shake_bounce_response)

	bounce_tween.set_trans(Tween.TRANS_LINEAR)
	bounce_tween.finished.connect(Z_Axis_BounceBack)
	
func Y_Axis_BounceBack():
	var y_rot = -MainCamera.get_rotation_degrees().y/2
	
	if is_zero_approx(y_rot):
		return

	var bounce_tween = get_tree().create_tween().tween_property(MainCamera,"rotation_degrees:y",y_rot,screen_shake_bounce_response)

	bounce_tween.set_trans(Tween.TRANS_LINEAR)
	bounce_tween.finished.connect(Y_Axis_BounceBack)

func X_Axis_BounceBack():
	var x_rot = -MainCamera.get_rotation_degrees().x/2
	
	if is_zero_approx(x_rot):
		return

	var bounce_tween = get_tree().create_tween().tween_property(MainCamera,"rotation_degrees:x",x_rot,screen_shake_bounce_response)

	bounce_tween.set_trans(Tween.TRANS_LINEAR)
	bounce_tween.finished.connect(X_Axis_BounceBack)


func ZoomCamera(amt:int = 0):
	var Zoom = BaseZoom-amt

	var zoom_tween = get_tree().create_tween().tween_property(MainCamera,"fov",Zoom,.1)
	zoom_tween.set_trans(Tween.TRANS_LINEAR)

func _on_weapons_manager_connect_weapon_to_camera(weapon: Weapon_Resource):
	weapon.Zoom.connect(ZoomCamera)

func shake_screen(Screen_Shake: Vector3, Magnetude: Vector4):
	Shake_Camera(Screen_Shake,Magnetude,Vector3i(true,true,true))

func Move_Head(move:bool):
	if HeadMovement != move:
		HeadMovement = move
		if HeadMovement == true:
			var headtween = get_tree().create_tween().tween_property(MainCamera, "rotation_degrees:z",Head_Bob_Right_Max,Head_Bob_Movement_Duration)
			var _y_sway = get_tree().create_tween().tween_property(Sway_Target, "position:y",Starting_Y_Pos,Head_Bob_Movement_Duration)	
			headtween.finished.connect(Left_Head_Movement)
		else:
			var Tweens = get_tree().get_processed_tweens()

			for t in Tweens:
				t.kill()
				
			get_tree().create_tween().tween_property(MainCamera, "rotation_degrees:z",0,Head_Bob_Movement_Duration)
			get_tree().create_tween().tween_property(MainCamera, "position:y",0,Head_Bob_Movement_Duration)
			get_tree().create_tween().tween_property(Sway_Target,"position:x",0,Head_Bob_Movement_Duration)
	
func Left_Head_Movement():
	var leftheadtween = get_tree().create_tween()
	var _leftheadheightween= get_tree().create_tween()
	var _left_head_Sway_tween = get_tree().create_tween()
	
	if HeadMovement == true:
		_left_head_Sway_tween.tween_property(Sway_Target,"position:x",-Max_Sway_Walk_Movement,Head_Bob_Movement_Duration)
		leftheadtween.tween_property(MainCamera, "rotation_degrees:z",Head_Bob_Left_Max,Head_Bob_Movement_Duration)
		_leftheadheightween.tween_property(MainCamera, "position:y",Head_Bob_Height_Max,Head_Bob_Movement_Duration)
		_left_head_Sway_tween.finished.connect(Right_Head_Movement)

func Right_Head_Movement():
	var right_head_tween = get_tree().create_tween()
	var _right_head_height_tween = get_tree().create_tween()
	var _right_head_Sway_tween = get_tree().create_tween()
	
	if HeadMovement == true:
		_right_head_Sway_tween.tween_property(Sway_Target,"position:x",Max_Sway_Walk_Movement,Head_Bob_Movement_Duration)
		right_head_tween.tween_property(MainCamera, "rotation_degrees:z",Head_Bob_Right_Max,Head_Bob_Movement_Duration)
		_right_head_height_tween.tween_property(MainCamera, "position:y",-Head_Bob_Height_Max,Head_Bob_Movement_Duration)
		_right_head_Sway_tween.finished.connect(Left_Head_Movement)

func StrafeHead(dir):
	get_tree().create_tween().tween_property(MainCamera, "rotation_degrees:z",Strafe_Rotation*-dir,Head_Bob_Movement_Duration)
	get_tree().create_tween().tween_property(MainCamera, "position:x",Head_Bob_Height_Max*-dir,Head_Bob_Movement_Duration)
	
	if !HeadMovement:
		get_tree().create_tween().tween_property(Sway_Target,"position:x",Max_Sway_Strafe_Movement*-dir,.4)
		get_tree().create_tween().tween_property(Sway_Target,"rotation:z",Max_Sway_Strafe_Movement*-dir,.4)

func Jump_Sway(Vel_y):
	if Jumping:
		var Y_tween = get_tree().create_tween().tween_property(Sway_Target, "position:y",Starting_Y_Pos+(Max_Y_Jump_Movement*-Vel_y),1)
		var _Y_Rot_Tween = get_tree().create_tween().tween_property(Sway_Target, "rotation_degrees:x",Max_Y_Jump_Rotation*-Vel_y,1)
		Y_tween.set_trans(Tween.TRANS_LINEAR)

func _on_player_forward_movement(dir):
	var inputy = bool(dir.z)

	Move_Head(inputy)
	Jump_Sway(dir.y)
	if !HeadMovement:
		StrafeHead(dir.x)
	
#	if !HeadMovement:
#		idle_sway_up()

func _on_player_character_jump_landed():
	Jumping = false
	shake_screen(Vector3(JumpIntensity.x,JumpIntensity.y,JumpIntensity.z),JumpIntensity)
	get_tree().create_tween().tween_property(Sway_Target, "position:y",Starting_Y_Pos,1)
	get_tree().create_tween().tween_property(Sway_Target, "rotation_degrees:x",0,1)
		
func _on_player_character_camera_rotated(Current_Rotation: Vector2):
	get_tree().create_tween().tween_property(Sway_Target,"rotation_degrees:y",Current_Rotation.x*Max_Sway_x_degree,.4)
	get_tree().create_tween().tween_property(Sway_Target,"rotation_degrees:x",Current_Rotation.y*Max_Sway_y_degree,.4)

func _on_player_character_jump_started():
	Jumping = true
