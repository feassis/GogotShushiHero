extends MeshInstance3D

@export
var sofaOffset: Vector3 = Vector3(0, 0.25, 0.02)

var isAvailable: bool = true

func changeAvailableState(state: bool) -> void:
	isAvailable = state

func hasAvailableSlot(entity) -> void:
	if isAvailable:
		entity.updateState("walking", sofaOffset, global_position)
		changeAvailableState(false)
		return
	
	entity.updateState("seek_sofa")
