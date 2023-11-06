extends InterfaceContainer
class_name FrigdeContainer

@export_category("Variables")
@export var amount:int = 20

func _ready():
	InitializeFridge()
	
func InitializeFridge() -> void:
	var myKeys: Array = ingredients.ingredients_dict.keys()
	
	
	
	for i in amount:
		var randIndex: int = randi() % myKeys.size()
		var added:bool = false
		for child in interactableContainer.get_children():
			var item: Dictionary = child.GetItem()
			
			if item["item_name"] ==  ingredients.ingredients_dict[myKeys[randIndex]]["item_name"]:
				UpdateInteractable("update", ingredients.ingredients_dict[myKeys[randIndex]])
				added = true
				break
		
		if added:
			continue
		
		UpdateInteractable("add", ingredients.ingredients_dict[myKeys[randIndex]])

func ChangeCurrentContainer() -> void:
	globals.current_container = "fridge"
