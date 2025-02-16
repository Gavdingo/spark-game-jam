extends StaticBody2D

var other_node: Node2D

func _ready() -> void:
	other_node = get_node("/root/Node2D/Player")

func _process(delta: float) -> void:
	var distance = global_position.distance_to(other_node.global_position)

	if distance < 50:
		get_node("/root/Node2D/Player/Score/Label").score += 1
		queue_free()
