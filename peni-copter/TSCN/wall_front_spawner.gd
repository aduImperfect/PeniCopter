extends Node2D

const WALL_SCENE = preload("res://TSCN/wallfront.tscn")

@export var moveFrontSpeed : float = 200.0

@export var animFrontDelay : float = 1.0
@export var delayFrontAccumulation : float = 0.0

@export var spawnFrontDelay : float = 5.0
@export var spawnFrontDelayAccumulation : float = 0.0

@export var wallFrontPosX : float = 1000
@export var wallFrontPosY : float = 160

@export var wallFrontLimit: int = 3

@export var wallFrontOffset : int = 50

@export var wallFrontNodes : Array[Node2D] = []
@export var wallFrontCount : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	delayFrontAccumulation = 0.0
	spawnFrontDelayAccumulation = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_remove_walls()
	_spawn_walls(_delta)

	delayFrontAccumulation += _delta
	if delayFrontAccumulation >= animFrontDelay:
		_animate_walls()
		delayFrontAccumulation = 0.0

	_walls_move(_delta)

func _spawn_walls(_delta : float) -> void:
	wallFrontPosY = 160
	spawnFrontDelayAccumulation += _delta
	if spawnFrontDelayAccumulation >= spawnFrontDelay:
		var multiSpawn : int = randi_range(1, wallFrontLimit)
		for k in multiSpawn:
			_wall_instance_setup(wallFrontPosY)
			wallFrontPosY += randf_range(150, 200)
		spawnFrontDelayAccumulation = 0.0
		spawnFrontDelay = randf_range(2.0, 5.0)

func _wall_instance_setup(_posY: float) -> void:
		var wall_instance = WALL_SCENE.instantiate()
		wall_instance.global_position.x = wallFrontPosX
		wall_instance.global_position.y = _posY

		add_child(wall_instance)
		wallFrontNodes.append(wall_instance)
		wallFrontCount += 1

func _remove_walls() -> void:
	if wallFrontNodes.size() == 0:
		return

	if wallFrontNodes[0].position.x <= -500.0:
		remove_child(wallFrontNodes[0])
		wallFrontNodes.remove_at(0)
		wallFrontCount -= 1

func _animate_walls() -> void:
	for wall in wallFrontNodes:
		var wallSpriteNode = wall.get_child(0) as Sprite2D
		if wallSpriteNode.frame < (wallSpriteNode.hframes - 1):
			wallSpriteNode.frame += 1
		else:
			wallSpriteNode.frame = 0

func _walls_move(_delta : float) -> void:
	for wallFrontChild in get_children():
		wallFrontChild.position.x -= moveFrontSpeed * _delta
