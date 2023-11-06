extends Control
class_name  BaseSlot

var item: Dictionary = {}
var newInstance : Dictionary ={}

@export_category("Objects")
@export var itemName: Label = null
@export var itemAmount: Label = null
@export var itemTexture: TextureRect = null

func AddItem(newItem: Dictionary) -> void:
	item = newItem
	
	item["item_amount"] = 1
	newInstance = item.duplicate(true)
	
	UpdateItemAmount()
	itemName.text = "ITEM - " + item["item_name"].capitalize()
	itemTexture.texture = load(item["item_texture"])
		

func UpdateItem(type: String) -> void:
	match type:
		"increase":
			newInstance["item_amount"] += 1
			UpdateItemAmount()
		
		"decrease":
			newInstance["item_amount"] -= 1
			
			if newInstance["item_amount"]  == 0:
				RemoveItem()
				return
				
			UpdateItemAmount()

func RemoveItem() -> void:
	queue_free()

func UpdateItemAmount() -> void:
		itemAmount.text = "AMOUNT - " + str(newInstance["item_amount"]) + "x"

func GetItem() -> Dictionary:
	return item

func  GetAltItem() ->  Dictionary:
	return newInstance
