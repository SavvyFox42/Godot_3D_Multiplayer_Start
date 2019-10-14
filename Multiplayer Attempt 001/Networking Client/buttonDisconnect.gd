extends Button

func _on_buttonDisconnect_pressed():
	get_tree().set_network_peer(null)
