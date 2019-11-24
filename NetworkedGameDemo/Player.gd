extends Spatial

var position
var forward = Vector3(0, 0, -1) # GODOT is left hand oriented?
var up = Vector3(0, 1, 0) # Y is still up at least

var yaw = 0
var pitch = 0

var rotX = 0
var rotY = 0

var temp_y
var step = 3
var angle = 1

const UP = Vector3(0.0, 1.0, 0.0)

puppet func move(position):
	translation = position
	
puppet func rotate(rotX, rotY):
	rotate_x(rotX)
	rotate_y(rotY)	
	
master func ShutItDown():
	rpc("shutdown")
	
sync func shutdown():
	get_tree().quit()
	
func _process(delta):
	
	position = translation
	rotX = 0
	rotY = 0
		
	if (is_network_master()):
		
		if Input.is_key_pressed(KEY_UP):
			if (globals.Z_LOCK):
				temp_y = translation.y
				position += forward * step * delta
				position.y = temp_y
			else:
				position += forward * step * delta
				
		if Input.is_key_pressed(KEY_DOWN):
			if (globals.Z_LOCK):
				temp_y = translation.y
				position += forward * -1 * step * delta
				position.y = temp_y
			else:
				position += forward * -1 * step * delta	
		
		if Input.is_key_pressed(KEY_RIGHT):
			position += up.cross(forward) * -1 * step * delta # Again. Left handed GODOT. WHY!
			
		if Input.is_key_pressed(KEY_LEFT):
			position += up.cross(forward) *  step * delta	
		
		# We will put this in mouse eventually
		if Input.is_key_pressed(KEY_A):
			rotY = angle * delta
			yaw += angle * delta
			if (yaw >= 360):
				yaw-= 360
			if (yaw < 0):
				yaw += 360
				
			var rotation = Basis();
			rotation = rotation.rotated(UP, ((angle * PI) / 180))
			forward = -(rotation *  forward).normalized()
			up = (rotation * up).normalized()
		
		if Input.is_key_pressed(KEY_D):
			rotY = -angle * delta
			yaw -= angle * delta
			if (yaw >= 360):
				yaw-= 360
			if (yaw < 0):
				yaw += 360
				
			var rotation = Basis();
			rotation = rotation.rotated(UP, ((angle * PI) / 180))
			forward = -(rotation * forward).normalized()
			up = (rotation * up).normalized()
				
		
		if Input.is_key_pressed(KEY_Q):
			ShutItDown()
			
		rpc_unreliable("move", position)	
		rpc_unreliable("rotate", rotX, rotY)
				
	translation = position
	rotate(rotX, rotY)