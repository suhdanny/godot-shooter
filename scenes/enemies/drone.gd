extends CharacterBody2D

var direction = Vector2(1, 0)

func _process(_delta):
	velocity = direction * 100
	move_and_slide()
