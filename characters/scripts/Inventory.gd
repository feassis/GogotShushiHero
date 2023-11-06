extends Node
class_name Inventory

var inventory: Dictionary =  {}
var inventoryAux: Dictionary =  {}

func AddItem(item: Dictionary) -> void:
	if inventoryAux.has(item["item_name"]):
		UpdateItem(item["item_name"], "increase")
		return
		
	inventory[item["item_name"]] = item
	inventoryAux[item["item_name"]] = inventory[item["item_name"]].duplicate(true)
	UpdateCharacterContainer(item, "add")

func UpdateCharacterContainer(item: Dictionary, type: String, updateType: String = "increase" ) -> void:
	get_tree().call_group("fridge_container", "UpdateCharacter", type, item, updateType)
	get_tree().call_group("oven_container", "UpdateCharacter", type, item, updateType)
	get_tree().call_group("cutting_container", "UpdateCharacter", type, item, updateType)
	
	
func UpdateItem(itemName: String, type: String) -> void:
	match type:
		"increase":
			inventoryAux[itemName]["item_amount"] += 1
			UpdateCharacterContainer(inventoryAux[itemName], "update")
		"decrease":
			inventoryAux[itemName]["item_amount"] -= 1
			UpdateCharacterContainer(inventoryAux[itemName], "update", "decrease")
			
			if inventoryAux[itemName]["item_amount"] == 0:
				RemoveItem(itemName)

func RemoveItem(itemName: String) -> void:
	inventory.erase(itemName)
	inventoryAux.erase(itemName)

func GetInventory() -> Dictionary:
	return inventory

func GetInventoryAux()-> Dictionary:
	return inventoryAux
