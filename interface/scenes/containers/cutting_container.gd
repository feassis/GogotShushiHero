extends InterfaceContainer

func _on_cutting_button_pressed():
	var preperedIngredients: Dictionary ={}
	for child in interactableContainer.get_children():
		var item: Dictionary = (child as BaseSlot).GetAltItem()
		
		if not item.has("prepared_ingredient"):
			preperedIngredients["null"] = 1
			return
			
		var preperedIngredient: Dictionary = item["prepared_ingredient"]
	
		for ingredient in preperedIngredient:
			if not preperedIngredients.has(ingredient):
				preperedIngredients[ingredient] = {
					"item_amount": 1 * item["item_amount"],
					"item_name": ingredient,
					"item_texture": preperedIngredient[ingredient]["item_texture"]
				}
			
				continue
				
			preperedIngredients[ingredient]["item_amount"] += 1 * item["item_amount"]
		
	if preperedIngredients.size() == 1:
		var items: Array = []
		for child in interactableContainer.get_children():
			for amount in (child as BaseSlot).GetAltItem()["item_amount"]:
				items.append((child as BaseSlot).GetItem()["item_name"])
				UpdateInteractable("update", (child as BaseSlot).GetAltItem(), "decrease")
		
		var ingredient: String = preperedIngredients.keys()[0]
		globals.character.Chop(ingredient, preperedIngredients[ingredient]["item_amount"])
		interactable.Chop(items)
		interactable.changeState(true)
		Close()

func ChangeCurrentContainer() -> void:
	globals.current_container = "chopping"
