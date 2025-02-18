extends Label

var label : Label

@export var score = 0

func _ready() -> void:
	label = self


func _process(delta: float) -> void:
	label.text = "high score: " + str(get_tree().get_meta("score", 0))
