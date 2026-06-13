extends Node2D

const WALL_SCENE = preload("res://TSCN/wall.tscn")

@export var moveSpeed : float = 200.0

@export var animDelay : float = 1.0
@export var delayAccumulation : float = 0.0

@export var spawnDelay : float = 0.0
@export var spawnDelayAccumulation : float = 0.0

@export var wallPosX : float = 0
@export var wallPosY : float = 40

@export var wallLimit: int = 30

@export var wallOffset : int = 50

@export var wallNodes : Array[Node2D] = []
@export var wallCount : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wallPosX = 0
	wallPosY = 40
	delayAccumulation = 0.0
	spawnDelayAccumulation = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_spawn_walls_initial()
	
	_remove_walls()
	_spawn_walls()

	delayAccumulation += _delta
	if delayAccumulation >= animDelay:
		_animate_walls()
		delayAccumulation = 0.0

	_walls_move(_delta)

func _spawn_walls_initial() -> void:

	if wallCount <= (2 * wallLimit):
		_wall_instance_setup(wallPosY)
		_wall_instance_setup(650 - wallPosY)
		wallPosX += wallOffset

func _spawn_walls() -> void:
	if wallNodes[wallNodes.size() - 2].position.x >= 300.0:
		_wall_instance_setup(wallPosY)
		_wall_instance_setup(650 - wallPosY)
		wallPosX += wallOffset

func _wall_instance_setup(_posY: float) -> void:
		var wall_instance = WALL_SCENE.instantiate()
		wall_instance.global_position.x = wallPosX
		wall_instance.global_position.y = _posY

		add_child(wall_instance)
		wallNodes.append(wall_instance)
		wallCount += 1

func _remove_walls() -> void:
	if wallNodes.size() == 0:
		return

	if wallNodes[0].position.x <= -500.0:
		remove_child(wallNodes[0])
		remove_child(wallNodes[1])
		wallNodes.remove_at(0)
		wallNodes.remove_at(0)
		wallCount -= 2

func _animate_walls() -> void:
	for wall in wallNodes:
		var wallSpriteNode = wall.get_child(0) as Sprite2D
		if wallSpriteNode.frame < (wallSpriteNode.hframes - 1):
			wallSpriteNode.frame += 1
		else:
			wallSpriteNode.frame = 0

func _walls_move(_delta : float) -> void:
	for wallChild in get_children():
		wallChild.position.x -= moveSpeed * _delta

func _walls_reset() -> void:
	wallPosX = 0
	wallPosY = 40
	delayAccumulation = 0.0
	spawnDelayAccumulation = 0.0

	wallCount = 0

	for k in get_children():
		remove_child(k)

	wallNodes.clear()
