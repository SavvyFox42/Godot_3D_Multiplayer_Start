extends Button

func _on_buttonSendData_pressed():
	print("Sending data to client")
	var textToSend = get_parent().get_node("textToSend").text
	get_tree().multiplayer.send_bytes(textToSend.to_ascii())