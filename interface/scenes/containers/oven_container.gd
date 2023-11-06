extends InterfaceContainer

func _on_cook_button_pressed():
	var ingredients: Dictionary = {}
	for child in interactableContainer.get_children():
		var item : Dictionary = (child as BaseSlot).GetAltItem()
		
		ingredients[item["item_name"]] ={
			"name": item["item_name"],
			"amount": item["item_amount"]
		}
		
	var myRecipes: Dictionary = {}
	for recipe in recipes.recipes_dict:
		for ingridient in recipes.recipes_dict[recipe]["ingredients"]:
			if not myRecipes.has(recipe):
				myRecipes[recipe] = {}

			myRecipes[recipe][ingridient] = {
				"name": ingridient,
				"amount": recipes.recipes_dict[recipe]["ingredients"][ingridient]["amount"]
			}
			
	for r in myRecipes:
		if myRecipes[r] == ingredients:
			for child in interactableContainer.get_children():
				var amount: int = (child as BaseSlot).GetAltItem()["item_amount"]
				for i in amount:
					UpdateInteractable("update", (child as BaseSlot).GetItem(), "decrease")
			interactable.changeState(true)
			globals.character.Cook(r)
			Close()
			return

func ChangeCurrentContainer() -> void:
	globals.current_container = "oven"
