extends Node2D
@export var wallCollectionNode : Node2D
@export var wallFrontCollectionNode : Node2D
@export var playerNode : Node2D
@export var scoreNode : TextEdit

@export var deltaPos : float = 50
@export var deltaFrontPos : float = 25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_player_to_wall()
	_player_to_wall_front()

func _player_to_wall() -> void:

	var xWallLower : bool = false
	var xWallUpper : bool = false
	var yWallLower : bool = false
	var yWallUpper : bool = false

	for i in wallCollectionNode.wallNodes.size():
		if (playerNode.position.x >= (wallCollectionNode.wallNodes[i].position.x - deltaPos)):
			xWallLower = true
		else:
			xWallLower = false

		if (playerNode.position.x <= (wallCollectionNode.wallNodes[i].position.x + deltaPos)):
			xWallUpper = true
		else:
			xWallUpper = false

		if (playerNode.position.y >= (wallCollectionNode.wallNodes[i].position.y - deltaPos)):
			yWallLower = true
		else:
			yWallLower = false

		if (playerNode.position.y <= (wallCollectionNode.wallNodes[i].position.y + deltaPos)):
			yWallUpper = true
		else:
			yWallUpper = false

		if xWallLower == true && xWallUpper == true && yWallLower == true && yWallUpper == true:
			playerNode._player_reset()
			wallCollectionNode._walls_reset()
			scoreNode._score_reset()
			break

func _player_to_wall_front() -> void:

	var xWallLower : bool = false
	var xWallUpper : bool = false
	var yWallLower : bool = false
	var yWallUpper : bool = false

	for i in wallFrontCollectionNode.wallFrontNodes.size():
		if (playerNode.position.x >= (wallFrontCollectionNode.wallFrontNodes[i].position.x - deltaFrontPos)):
			xWallLower = true
		else:
			xWallLower = false

		if (playerNode.position.x <= (wallFrontCollectionNode.wallFrontNodes[i].position.x + deltaFrontPos)):
			xWallUpper = true
		else:
			xWallUpper = false

		if (playerNode.position.y >= (wallFrontCollectionNode.wallFrontNodes[i].position.y - deltaFrontPos)):
			yWallLower = true
		else:
			yWallLower = false

		if (playerNode.position.y <= (wallFrontCollectionNode.wallFrontNodes[i].position.y + deltaFrontPos)):
			yWallUpper = true
		else:
			yWallUpper = false

		if xWallLower == true && xWallUpper == true && yWallLower == true && yWallUpper == true:
			playerNode._player_reset()
			wallFrontCollectionNode._walls_front_reset()
			scoreNode._score_reset()
			break
