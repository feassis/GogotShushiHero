extends Control

@export_category("Prefabs")
@export var listSlot: PackedScene = null
@export var truckSlot: PackedScene = null

var price: int = 0
var interactable = null

@export_category("Variables")
@export var amount: int = 10

@export_category("Objects")
@export var truckContainer: VBoxContainer = null
@export var listContainer: VBoxContainer = null
@export var priceLabel: Label = null

func _ready():
	RefilTruck()
	
func RefilTruck():
	var i: int = 0
	var myKeys: Array = ingredients.ingredients_dict.keys()
	
	while i < amount:
		var children: Array = []
		var randIndex: int = randi() % myKeys.size()
		for child in truckContainer.get_children():
			children.append(child.GetItem()["item_name"])
		
		if children.has(ingredients.ingredients_dict[myKeys[randIndex]]["item_name"]):
			continue
		
		UpdateInteractable("add", ingredients.ingredients_dict[myKeys[randIndex]])
		i += 1
		
func UpdateInteractable(type: String, item: Dictionary, updateType: String = "increase"):
	match type:
		"add":
			var newSlot = truckSlot.instantiate()
			truckContainer.add_child(newSlot)
			newSlot.AddItem(item)
			newSlot.parent = self

func UpdateListSlot(item: Dictionary):
	UpdatePrice("increase", item["price"])
	for child in listContainer.get_children():
		if child.GetItem()["item_name"] == item["item_name"]:
			child.UpdateItem("increase")
			return
		
	var newSlot = listSlot.instantiate()
	listContainer.add_child(newSlot)
	newSlot.AddItem(item)
	newSlot.parent = self
	
func UpdatePrice(type: String, value: int):
	match type:
		"increase":
			price += value
		"decrease":
			price -= value
			
	priceLabel.text = "Total - $" + str(price)


func _on_buy_button_pressed():
	if globals.character == null:
		return
	
	if globals.character.gold >= price:
		globals.character.UpdateGold(price, "decrease")
		
		for child in listContainer.get_children():
			var item: Dictionary = child.GetNewInstance()
			for i in item["item_amount"]:
				get_tree().call_group("character_inventory", "AddItem", item)
				child.UpdateItem("decrease")
		price = 0
		UpdatePrice("increase", 0)


func  _process(delta):
	if interactable != null and visible:
		if interactable.characterRef == null:
			Close()
	if get_tree().paused and not visible:
		return
		
	if Input.is_action_just_pressed("ui_cancel") and visible:
		interactable.ChangeState(true)
		Close()
			
func Close():
	Clean()
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func Clean():
	for child in truckContainer.get_children():
		child.queue_free()
	
	for child in listContainer.get_children():
		child.queue_free()
	
	price = 0
	RefilTruck()
	UpdatePrice("increase", 0)
	
func Display(target, visibility:bool):
	interactable = target
	visible = visibility
