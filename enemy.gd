extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0



func _physics_process(delta: float) -> void:
	var player_node = get_node("../Player")
	var player_position = player_node.position
	
	# Calculate direction vector
	var direction = (player_position - position).normalized()
	
	# Move using the direction vector
	position += direction * SPEED * delta

	if direction.x > 0:
		# Play right animation
		$AnimatedSprite2D.play("right")
	else:
		# Play left animation
		$AnimatedSprite2D.play("left")
