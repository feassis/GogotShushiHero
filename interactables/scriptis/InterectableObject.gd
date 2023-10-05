extends Node3D
class_name InteractableObject

var caninteract:bool = false
var characterRef: Character = null

@export_category("Objects")
@export var feedback: MeshInstance3D = null

func CanInteract(state: bool, body:Character = null) -> void:
	feedback.visible = state
	characterRef = body
	caninteract = state
	
func _physics_process(delta):
	if characterRef == null:
		return
	
	if caninteract and Input.is_action_just_pressed("interact"):
		changeState(false)
		interact()
		
	
func interact() -> void:
	pass

func changeState(state:bool) -> void:
	if characterRef != null:
		characterRef.freeze(not state)
		
		if characterRef.canInteract:
			caninteract = state
			feedback.visible = state

