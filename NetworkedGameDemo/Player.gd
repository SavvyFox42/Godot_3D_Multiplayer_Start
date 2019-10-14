extends Node2D

slave func setPosition(pos):
	position = pos
	
master func ShutItDown():
	rpc("shutdown")
	
sync func shutdown():
	get_tree().quit()
	
func _process(delta):
	var moveByX = 0
	var moveByY = 0
	
	if (is_network_master()):
		if Input.is_key_pressed(KEY_LEFT):
			moveByX = -5
		if Input.is_key_pressed(KEY_RIGHT):
			moveByX = +5
		if Input.is_key_pressed(KEY_UP):
			moveByY = -5
		if Input.is_key_pressed(KEY_DOWN):
			moveByY = +5
		if Input.is_key_pressed(KEY_Q):
			ShutItDown()
			
		rpc_unreliable("setPosition", Vector2(position.x - moveByX, position.y - moveByY))	
				
	translate(Vector2(moveByX, moveByY))