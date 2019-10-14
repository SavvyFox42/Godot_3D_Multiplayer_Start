extends Node2D

func _ready():
	var network = NetworkedMultiplayerENet.new()
	network.create_client("127.0.0.1", 4242)
	get_tree().set_network_peer(network)
	network.connect("connection_failed", self, "on_connection_failed")
	get_tree().multiplayer.connect("network_peer_packet", self, "_on_packet_recieved")
	
func _on_connection_failed(error):
	$labelStatus.text = "Error Connecting to server" + error
	
func _on_packet_recieved(id, packet):
	$labelServerData.text = packet.get_string_from_ascii()