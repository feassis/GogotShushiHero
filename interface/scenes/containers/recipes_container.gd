extends ColorRect

@export var recipeSlot: PackedScene = null

var signRef = null

@export_category("Objects")
@export var recipeBox: VBoxContainer = null

func _ready():
	for recipe in recipes.recipes_dict.keys():
		var recipeSlotInstance = recipeSlot.instantiate()
		PopulateSlot(recipe, recipeSlotInstance)
		recipeBox.add_child(recipeSlotInstance)
		
func PopulateSlot(recipe: String, slot: VBoxContainer):
	var vContainter: VBoxContainer = slot.get_node("VContainer")
	vContainter.get_node("HContainer/Container/ItemTexture").texture = load(
		recipes.recipes_dict[recipe]["item_texture"]
	)
	
	vContainter.get_node("HContainer/Container/Label").text = recipe.capitalize()
	
	var ingredientDict: Dictionary = recipes.recipes_dict[recipe]["ingredients"]
	var ingredientKeys: Array =  ingredientDict.keys()
	
	var ingredientContainer: HBoxContainer = vContainter.get_node("VContainer/HContainer/Container")
	
	for i in ingredientDict.size():
		var ingredientSlot: VBoxContainer = ingredientContainer.get_child(i)
		var ingredientTexture: TextureRect = ingredientSlot.get_node("VContainer/HContainer/TextureRect")
		var ingredientName: Label = ingredientSlot.get_node("VContainer/HContainer/VContainer/Ingredient")
		var ingredientAmount: Label = ingredientSlot.get_node("VContainer/HContainer/VContainer/Amount")
		
		ingredientSlot.show()
		ingredientTexture.texture = load(
		ingredientDict[ingredientKeys[i]]["item_texture"]
		)
		ingredientName.text = ingredientKeys[i]
		ingredientAmount.text = str(ingredientDict[ingredientKeys[i]]["amount"]) + "x"

func _process(delta):
	if get_tree().paused and not visible:
		return
		
	if Input.is_action_just_pressed("ui_cancel") and visible:
		visible = false
		get_tree().paused = false
		signRef.changeState(true)
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		

func  Display(target, visibility:bool):
	signRef = target
	visible = visibility
