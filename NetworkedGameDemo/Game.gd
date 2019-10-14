extends Node2D

func _ready():
	
	var thisPlayer = preload("res://Player.tscn").instance()
	thisPlayer.set_name(str(get_tree().get_network_unique_id()))
	thisPlayer.set_network_master(get_tree().get_network_unique_id())
	add_child(thisPlayer)
	
	var otherPlayer = preload("res://Player.tscn").instance()
	otherPlayer.set_name(str(globals.otherPlayerId))
	otherPlayer.set_network_master(globals.otherPlayerId)
	add_child(otherPlayer)