extends InteractableObject
class_name ReciptSign

func interact() -> void:
	get_tree().call_group("recipes", "Display", self, true)
