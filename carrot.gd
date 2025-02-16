extends Node2D

var state="no carrot"
var player_in_area = false

#func _ready():
	#if state=="no apples"
	

func _process(delta):
	if state=="no carrot":
		$AnimatedSprite2D.play('no carrot')
	if state=="carrots":
		$AnimatedSprite2D.play("carrots")
		if player_in_area:
			state='no carrot'

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		player_in_area=true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		player_in_area=false
