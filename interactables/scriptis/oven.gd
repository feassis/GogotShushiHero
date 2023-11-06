extends InteractableObject

class_name Oven
@export_category("Variables")
@export var onUsePosition : Node3D = null


func interact() -> void:
	characterRef.ChangePosition(onUsePosition.global_position, onUsePosition.global_rotation.y)
	get_tree().call_group("oven_container", "Display", self, true)
