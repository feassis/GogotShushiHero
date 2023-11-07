extends HBoxContainer

var parent = null
var item: Dictionary = {}

@export_category("Objects")
@export var itemName: Label
@export var itemPrice:Label
@export var itemTexture:TextureRect



func AddItem(newItem: Dictionary) -> void:
	item = newItem
	itemPrice.text = "PRICE -$" + str(item["price"])
	itemName.text = "ITEM - " + item["item_name"].capitalize()
	itemTexture.texture = load(item["item_texture"])
	
func GetItem() -> Dictionary:
	return item


func _on_send_button_pressed():
	parent.UpdateListSlot(item)
