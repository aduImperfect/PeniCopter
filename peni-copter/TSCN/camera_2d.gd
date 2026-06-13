extends Camera2D

@export var playerNode : Node2D
@export var cameraLerpSpeed : float = 0.1

@export var startCamFollowPosX : float = 0.0
@export var startCamFollowPosY : float = 0.0
@export var finalCamFollowPosX : float = 0.0
@export var finalCamFollowPosY : float = 0.0

@export var camStartingPosX : float = 80.0
@export var camStartingPosY : float = 240.0

@export var camLerpT : float = 0.0
@export var closenessVal : float = 2.0

@export var followComplete : bool = true
@export var followInProgress : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = camStartingPosX
	position.y = camStartingPosY
	startCamFollowPosX = camStartingPosX
	startCamFollowPosY = camStartingPosY
	finalCamFollowPosX = camStartingPosX
	finalCamFollowPosY = camStartingPosY

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_follow_final_position_set()
	_follow_cam_action(_delta)

func _follow_physics(_delta : float, _startPos : float, _endPos : float) -> float:
	camLerpT += _delta * cameraLerpSpeed
	var lerpVal : float = _startPos * (1 - camLerpT) + _endPos * camLerpT
	return lerpVal

func _follow_completion_check(_valStart : float, _valEnd : float) -> bool:
	if abs(_valStart - _valEnd) <= closenessVal :
		return true
	return false

func _follow_cam_action(_delta: float) -> void:

	if followComplete == true:
		return
	
	position.x = _follow_physics(_delta, startCamFollowPosX, finalCamFollowPosX)
	position.y = _follow_physics(_delta, startCamFollowPosY, finalCamFollowPosY)

	if (_follow_completion_check(position.x, finalCamFollowPosX) == true) && (_follow_completion_check(position.y, finalCamFollowPosY) == true):
		followComplete = true
		followInProgress = false
		camLerpT = 0.0
	else:
		followComplete = false
		followInProgress = true

func _follow_final_position_set() -> void:
	if followComplete == false && followInProgress == false:
		return

	startCamFollowPosX = position.x
	startCamFollowPosY = position.y
	finalCamFollowPosX = playerNode.position.x
	finalCamFollowPosY = playerNode.position.y
	followComplete = false
	followInProgress = true
