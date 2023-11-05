extends CharacterBody2D

var can_laser = true
var can_grenade = true
var speed = 500

signal laser(pos, direction)
signal grenade(pos, direction)

func _process(_delta):
	# Player movement
	var direction = Input.get_vector("left", "right", "up", "down");
	velocity = direction * speed
	move_and_slide()
	
	# Player rotation
	look_at(get_global_mouse_position())
	
	var player_direction = get_player_direction()
	if Input.is_action_pressed("primary action") and can_laser:
		# Get all laser markers
		var laser_markers = $LaserStartPositions.get_children()
		var selected_marker = laser_markers[randi() % laser_markers.size()]
		laser.emit(selected_marker.global_position, player_direction)
		
		can_laser = false
		$LaserReloadTimer.start() # 0.5s
	
	if Input.is_action_pressed("secondary action") and can_grenade:
		var pos = $LaserStartPositions.get_children()[1].global_position
		grenade.emit(pos, player_direction)
		can_grenade = false
		$GrenadeReloadTimer.start() # 1.0s

func get_player_direction():
	return (get_global_mouse_position() - position).normalized()

func _on_laser_reload_timer_timeout():
	can_laser = true

func _on_grenade_reload_timer_timeout():
	can_grenade = true


