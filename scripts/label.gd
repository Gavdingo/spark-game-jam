extends Label

var label : Label

@export var score = 0

func _ready() -> void:
	label = get_node("../Label")


func _process(delta: float) -> void:
	label.text = "score: " + str(score)
