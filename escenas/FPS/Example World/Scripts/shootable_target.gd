extends CharacterBody3D

@onready var AnimPlayer = $AnimationPlayer
@onready var StartTimer = $Timer

var Hit: bool = false
var Health = 1
var WaitTime

# Called when the node enters the scene tree for the first time.
func _ready():
	AnimPlayer.play("rise_up")
	WaitTime = randf_range(1,2)

	StartTimer.set_wait_time(WaitTime)
	StartTimer.start()

func Hit_Successful(Damage, _Direction: Vector3 = Vector3.ZERO, _Position: Vector3 = Vector3.ZERO):
	if Hit == false:
		Health -= Damage
		if Health <= 0:
			AnimPlayer.pause()
			AnimPlayer.play("shot")
			Hit = true
		
func Rise_Up():
	if Hit == true:
		Health = 1
		AnimPlayer.play("rise_up")
		StartTimer.start()
		Hit = false

func Move():
	AnimPlayer.play("move",-1,randf_range(.1,2.5),true)


func _on_timer_timeout():
	Move()
