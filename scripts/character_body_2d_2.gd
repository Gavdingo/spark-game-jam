#extends CharacterBody2D
#
#@export var speed = 200
#@export var gravity = 100
#@export var jump_force = 1500
#@onready var _animated_sprite = $AnimatedSprite2D
	#
#
#func _physics_process(delta: float) -> void:
	#var move_direction = Input.get_axis("ui_left", "ui_right")
	#velocity.x = move_direction * speed
	#var move_direction2 = Input.get_axis("ui_up","ui_down")
	#velocity.y = move_direction2*speed 	#for up down left right
	#
			#
	#if Input.is_action_pressed("ui_right"):
		#_animated_sprite.play("right")
	##else: 					#for running animation right
		##_animated_sprite.stop()	
		#
	#if Input.is_action_pressed("ui_left"):
		#_animated_sprite.play("left")			#for animation left
		#
	#if Input.is_action_pressed("ui_up"):
		#_animated_sprite.play("up") 		#animation up
		#
	#if Input.is_action_pressed("ui_down"):
		#_animated_sprite.play("down")		#animation down
	#
	#move_and_slide()
