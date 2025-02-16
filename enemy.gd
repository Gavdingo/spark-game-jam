extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0



func _physics_process(delta: float) -> void:
	var player_node = get_node("../Player")
	var player_position = player_node.position
	
	position = position.move_toward(player_position, SPEED * delta)
	#move_and_collide(player_position)
