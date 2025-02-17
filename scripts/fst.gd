extends Node2D

@export var enemy_scene: PackedScene
@export var food_scene: PackedScene
@export var spawn_interval: float = 1.0
@export var min_spawn_radius: float = 300.0  # Minimum distance from player
@export var max_spawn_radius: float = 1000.0  # Maximum distance from player

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

func get_random_position_around_player() -> Vector2:
	# Generate random angle in radians
	var angle = randf() * TAU  # TAU is 2*PI
	# Generate random radius between min and max
	var radius = randf_range(min_spawn_radius, max_spawn_radius)
	# Convert polar coordinates to Cartesian coordinates
	var spawn_position = Vector2(
		cos(angle) * radius,
		sin(angle) * radius
	)
	# Add player's position to offset the spawn point
	return player.global_position + spawn_position

func spawn_enemy() -> void:
	print('spawning an enemy')
	var enemy = enemy_scene.instantiate()
	enemy.global_position = get_random_position_around_player()
	add_child(enemy)

func spawn_food() -> void:
	print('spawning food')
	var food = food_scene.instantiate()
	food.global_position = get_random_position_around_player()
	add_child(food)
