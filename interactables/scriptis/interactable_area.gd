extends Area3D
class_name InteractableArea

@export_category("Object")
@export var parent: InteractableObject = null


func _on_body_entered(body):
	if body is Character:
		body.current_entity = parent
		
		if body.canInteract:
			parent.CanInteract(true, body)


func _on_body_exited(body):
	if body is Character:
		parent.CanInteract(false)
		body.current_entity = null
