extends CharacterBody2D

@export var speed = 400
func _physics_process(delta: float) -> void:
	var move_direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = move_direction * speed
	var move_direction2 = Input.get_axis("ui_up","ui_down")
	velocity.y = move_direction2*speed
	move_and_slide()
	
