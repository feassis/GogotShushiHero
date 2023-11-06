extends InteractableObject

func interact() -> void:
	get_tree().call_group("fridge_container", "Display", self, true)
