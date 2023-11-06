extends Control
class_name InterfaceContainer

@export_category("Setup")
@export var characterSlot: PackedScene = preload("res://interface/scenes/slots/character_slot.tscn")
@export var interactableSlot: PackedScene = preload("res://interface/scenes/slots/interactable_slot.tscn")

@export_category("Objects")
@export var interactableContainer: VBoxContainer = null
@export var characterContainer: VBoxContainer = null

var interactable = null

func UpdateInteractable(
		type: String, 
		item: Dictionary, 
		updateType: String = "increase"
		) -> void:
		
		match type:
			"add":
				for children in interactableContainer.get_children():
					var oldItem: Dictionary = children.GetItem()
					if(oldItem["item_name"]) == item["item_name"]:
						UpdateInteractable("update", item)
						return
						
				var newSlot = interactableSlot.instantiate()
				interactableContainer.add_child(newSlot)
				newSlot.AddItem(item)
				
			"update":
				for children in interactableContainer.get_children():
					var oldItem: Dictionary = children.GetItem()
					if(oldItem["item_name"]) == item["item_name"]:
						children.UpdateItem(updateType)
						return
						
func UpdateCharacter(
		type: String, 
		item: Dictionary, 
		updateType: String = "increase"
		) -> void:
		
		match type:
			"add":
				var newSlot = characterSlot.instantiate()
				characterContainer.add_child(newSlot)
				newSlot.AddItem(item)
				
			"update":
				for children in characterContainer.get_children():
					var childrenItem: Dictionary = children.GetItem()
					if(childrenItem["item_name"]) == item["item_name"]:
						children.UpdateItem(updateType)
						return
				
func _process(delta):
	if get_tree().paused and not visible:
		return
	
	if Input.is_action_just_pressed("ui_cancel") and visible:
		interactable.changeState(true)
		Close()
	
func Close() -> void:
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func Display(target, visibility: bool) -> void:
	if visibility: 
		ChangeCurrentContainer()
	
	interactable = target
	visible = visibility
		
func ChangeCurrentContainer() -> void:
	pass
