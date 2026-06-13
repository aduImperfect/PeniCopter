extends TextEdit

@export var scoreCount : float = 0.0

@export var countDelay : float = 1.0
@export var countDelayAccumulation : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	countDelayAccumulation = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	countDelayAccumulation += _delta
	if countDelayAccumulation >= countDelay:
		scoreCount += 0.1
		countDelayAccumulation = 0.0

	text = str(scoreCount)

func _score_reset() -> void:
	countDelayAccumulation = 0.0
	scoreCount = 0.0
