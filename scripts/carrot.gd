extends StaticBody2D

var player_node: Node2D

func _ready() -> void:
	player_node = get_node("/root/Node2D/Player")

func _process(delta: float) -> void:
	var distance = global_position.distance_to(player_node.global_position)

	if distance < 70:
		get_node("/root/Node2D/Player/Score/Label").score += 1
		player_node.happy_timeout = 30
		player_node.health = min(100, player_node.health + 5)
		queue_free()
