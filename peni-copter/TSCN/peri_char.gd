extends Sprite2D

@export var periAnimDelay : float = 0.2
@export var periDelayAccumulation : float = 0.0

@export var startPosX : float = 80.0
@export var startPosY : float = 240.0

@export var dropSpeed : float = 200.0
@export var pushUpSpeed : float = 350.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	periDelayAccumulation = 0.0
	position.x = startPosX
	position.y = startPosY

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	periDelayAccumulation += _delta
	if periDelayAccumulation >= periAnimDelay:
		_animate_char()
		periDelayAccumulation = 0.0
	_drop_char(_delta)
	_input_char(_delta)

func _animate_char() -> void:
	if frame < (hframes - 1):
		frame += 1
	else:
		frame = 0

func _drop_char(_delta : float) -> void:
	position.y += dropSpeed * _delta

func _input_char(_delta : float) -> void:
	if Input.is_action_pressed("ui_up"):
		position.y -= pushUpSpeed * _delta

func _player_reset() -> void:
	periDelayAccumulation = 0.0
	position.x = startPosX
	position.y = startPosY
