extends BaseSlot

func _on_send_button_pressed():
	match  globals.current_container:
		"oven":
			get_tree().call_group("oven_container", "UpdateInteractable", "add", item)
		"fridge":
			get_tree().call_group("fridge_container", "UpdateInteractable", "add", item)
		"chopping":
			get_tree().call_group("cutting_container", "UpdateInteractable", "add", item)
		
	get_tree().call_group("character_inventory", "UpdateItem", item["item_name"], "decrease")
