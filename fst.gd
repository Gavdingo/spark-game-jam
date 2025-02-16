extends Node2D

@export var enemy_scene: PackedScene
@export var food_scene: PackedScene

@export var spawn_interval: float = 1.0

@onready var player = $Player

func _ready() -> void:
	randomize()
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = spawn_interval
	timer.one_shot = false
	timer.timeout.connect(spawn_enemy)
	timer.timeout.connect(spawn_food)

	timer.start()

func spawn_enemy() -> void:
	print('spawning an enemy')
	var enemy = enemy_scene.instantiate()
	var viewport_size = get_viewport_rect().size
	enemy.global_position = Vector2(randf_range(0, viewport_size.x), randf_range(0, viewport_size.y))
	add_child(enemy)

func spawn_food() -> void:
	print('spawning an food')
	var food = food_scene.instantiate()
	var viewport_size = get_viewport_rect().size
	food.global_position = Vector2(randf_range(0, viewport_size.x), randf_range(0, viewport_size.y))
	add_child(food)
