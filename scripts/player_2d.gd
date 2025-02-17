extends CharacterBody2D

@export var speed = 100
@export var gravity = 100
@export var jump_force = 1500

func _physics_process(delta: float) -> void:
	var move_direction = Input.get_axis("ui_left", "ui_right")
	#var direction = Input.get_axis(CharacterBody2D, float)
	velocity.x = move_direction * speed
	#var move_direction2 = Input.get_axis("ui_up","ui_down")
	#velocity.y = move_direction2*speed #for up down left right
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_force #for regular movement
		
	if not is_on_floor(): #for regular movement
		velocity.y+=gravity
		if velocity.y>1000:
			velocity.y=1000
		
	move_and_slide()
