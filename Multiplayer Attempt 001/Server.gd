extends SceneTree

func _init():
	
	var done = false
	var socket = PacketPeerUDP.new()
	
	if (socket.listen(4242, "127.0.0.1") != OK):
		print("An Error has occured listening on port 4242")
		done = true
	else:
		print("Listening on port 4242 on localhost")
		
	while (done != true):
		if (socket.get_available_packet_count() > 0):
			var data = socket.get_packet.get_string_from_ascii()
			if (data == "quit"):
				done = true
				
			else:
				print("Data Recieved: " + data)
	
	socket.close()
	print("Exiting application")
	self.quit()