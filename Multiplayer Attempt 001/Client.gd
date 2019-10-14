extends SceneTree

func _init():
	var socket = PacketPeerUDP.new()
	
	socket.set_dest_address("127.0.0.1", 4242)
	socket.put_packet("Your message here".to_ascii())
	
	print("Exiting Application")
	self.quit()