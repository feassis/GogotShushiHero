extends InteractableObject


var itemRef: MeshInstance3D = null
@export var ingredients: Node3D = null

@export_category("Variables")
@export var onUsePosition : Node3D = null

func interact() -> void:
	characterRef.ChangePosition(onUsePosition.global_position, onUsePosition.global_rotation.y)


func chop(items: Array) -> void:
	itemRef = ingredients.get_node(items[randi() % items.size()].to_pascal_case())
	itemRef.show()
	
	await get_tree().create_timer(5.834).timeout
	itemRef.hide()
