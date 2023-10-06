extends InteractableObject

class_name Oven
@export_category("Variables")
@export var onUsePosition : Node3D = null


func interact() -> void:
	characterRef.ChangePosition(onUsePosition.global_position, onUsePosition.global_rotation.y)
	
