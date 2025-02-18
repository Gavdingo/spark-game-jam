extends Node2D

@export var enemy_scene: PackedScene
@export var food_scene: PackedScene
@export var spawn_interval: float = 2.0
@export var food_interval: float = 0.4

@export var min_spawn_radius: float = 300.0  # Minimum distance from player
@export var max_spawn_radius: float = 2000.0  # Maximum distance from player

@onready var player = $Player

@export var t = 0
var timer
var food_timer

func _process(delta: float) -> void:
	t += delta
	get_tree().set_meta("t", t)
	timer.wait_time = min(spawn_interval, t**(-0.3))
	

func _ready() -> void:
	randomize()
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = spawn_interval
	timer.one_shot = false
	timer.timeout.connect(spawn_enemy)
	timer.start()
	
	food_timer = Timer.new()
	add_child(food_timer)
	food_timer.wait_time = food_interval
	food_timer.one_shot = false
	food_timer.timeout.connect(do_food_spawns)
	food_timer.start()
	
	for i in range(4):
		spawn_food(200, 500)

func do_food_spawns():
	spawn_food()
	spawn_food(1000, 6000)


func get_random_position_around_player(mn=min_spawn_radius, mx=max_spawn_radius) -> Vector2:
	# Generate random angle in radians
	var angle = randf() * TAU  # TAU is 2*PI
	# Generate random radius between min and max
	var radius = randf_range(mn, mx)
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
	enemy.global_position = get_random_position_around_player(500, 2000)
	add_child(enemy)

func spawn_food(mn=min_spawn_radius, mx=max_spawn_radius) -> void:
	print('spawning food')
	var food = food_scene.instantiate()
	food.global_position = get_random_position_around_player(mn, mx)
	add_child(food)
