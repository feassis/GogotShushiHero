extends BaseSlot


func _on_send_button_pressed():
	get_tree().call_group(
		"character_inventory",
		"AddItem",
		item
	)
	UpdateItem("decrease")
