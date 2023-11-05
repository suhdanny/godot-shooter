extends Area2D

var direction = Vector2.UP
var speed = 1000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	position += direction * speed * delta
