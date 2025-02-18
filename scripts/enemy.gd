extends Node2D

var SPEED = 150
var RANDOM_STRENGTH = 100
const NOISE_SCALE = 1
const LIFETIME = 20.0 
var noise = FastNoiseLite.new()
var time = 0.0
var lifetime_timer = 0.0
var velocity = Vector2.ZERO
const ACCELERATION = 500
@onready var sprite = $AnimatedSprite2D

var t

func _ready():
	t = get_tree().get_meta("t", 0)
	SPEED = 150 + t
	RANDOM_STRENGTH = 100 + t
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.seed = randi() 

func _physics_process(delta: float) -> void:
	lifetime_timer += delta
	if lifetime_timer >= LIFETIME:
		queue_free()  # Despawn the enemy
		return
		
	if lifetime_timer >= LIFETIME - 2:
		var alpha = 1.0 - (lifetime_timer - (LIFETIME - 2)) / 2
		sprite.modulate.a = max(0, alpha)
		return
		
	var player_node = get_node("../Player")
	var player_position = player_node.position
	
	# Update time for noise
	time += delta
	
	# Calculate base direction vector towards player
	var direction = (player_position - position).normalized()
	
	# Generate random offset using noise
	var noise_x = noise.get_noise_2d(time * NOISE_SCALE, position.x * 0.1)
	var noise_y = noise.get_noise_2d(time * NOISE_SCALE, position.y * 0.1)
	var random_offset = Vector2(noise_x, noise_y) * RANDOM_STRENGTH
	
	# Calculate desired velocity
	var distance_to_player = position.distance_to(player_position)
	var random_factor = clamp(distance_to_player / 200.0, 0.0, 1.0)
	var desired_velocity = direction * SPEED + random_offset * random_factor
	
	# Smoothly interpolate current velocity towards desired velocity
	velocity = velocity.move_toward(desired_velocity, ACCELERATION * delta)
	
	# Apply movement using velocity
	position += velocity * delta
	
	# Update animation
	if velocity.x > 0:
		$AnimatedSprite2D.play("right")
	else:
		$AnimatedSprite2D.play("left")
