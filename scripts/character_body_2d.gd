extends CharacterBody2D

const NORMAL_SPEED = 350.0
const SPRINT_SPEED = 700.0

@export var health = 100
@export var happy_timeout = 0
@onready var animated_sprite = $AnimatedSprite2D

var local_t = 0
var boost_full_t = 0

func _process(delta: float) -> void:
	local_t += delta
	happy_timeout -= 1

func _physics_process(delta: float) -> void:
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	var current_speed = NORMAL_SPEED

	var boost_bar = get_node("Node2D/BoostBar")

	if Input.is_key_pressed(KEY_B) and boost_bar.value > 100:
		current_speed = SPRINT_SPEED
		$CollisionShape2D.disabled = true  # ghost
		boost_bar.value -= 100
	else:
		$CollisionShape2D.disabled = false
		boost_bar.value += 30
		
	if boost_bar.value == 10000:
		boost_full_t += 1 * delta
	else:
		boost_full_t = 0
	
	if boost_full_t >= 10:
		$Label2.visible = true
	else: 
		$Label2.visible = false

	
	var movement = Vector2(direction_x, direction_y)
	if movement.length() > 0:
		movement = movement.normalized()
		
	if movement.x > 0:
		animated_sprite.play('right')
	elif movement.x < 0:
		animated_sprite.play('left')
	elif movement.y < 0:
		animated_sprite.play('up')
	elif movement.y > 0:
		animated_sprite.play('down')
		
	if happy_timeout > 0:
		animated_sprite.play('happy')
	
	
	velocity = movement * current_speed
	move_and_slide()
	
	health = min(100, health + 2 * delta)  # health regen
	
	var collision_count = get_slide_collision_count()
	for i in range(collision_count):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.scene_file_path.contains("enemy"):
			health -= 20 * delta
			animated_sprite.play('sad')
	
	var health_bar = get_node("Node2D/HealthBar")
	health_bar.value = health
	
	if health <= 0 or Input.is_key_pressed(KEY_Q):
		get_tree().set_meta("score", max(get_node('Score/Label').score, get_tree().get_meta("score", 0)))
		get_tree().change_scene_to_file("res://scenes/Menu.tscn")
