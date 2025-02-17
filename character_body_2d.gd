extends CharacterBody2D


const SPEED = 300.0

@export var health = 100


func _physics_process(delta: float) -> void:
	# Get the input direction for both axes and handle the movement/deceleration.
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	
	# Apply the movement direction for x and y.
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	var collision_count = get_slide_collision_count()
	for i in range(collision_count):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider.scene_file_path.contains("enemy"):
			health -= 0.2
		
	var health_bar = get_node("Node2D/HealthBar")
	health_bar.value = health
	
	if health <= 0:
		get_tree().quit()

	
