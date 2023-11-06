extends InteractableObject

func interact():
	pass




func _on_detection_area_body_entered(body):
	if body is Character:
		body.current_entity = self
		if body.canInteract:
			CanInteract(true, body)


func _on_detection_area_body_exited(body):
	if body is Character:
		body.freeze(false)
		CanInteract(false, null)
