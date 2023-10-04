extends ColorRect
class_name  SettingdContainer

var worldEnviroment: WorldEnvironment = null
@export_category("Objects")
@export var fpsContainer: ColorRect =null

func _ready() ->void:
	worldEnviroment = get_tree().get_nodes_in_group("environment")[0]
	for button in get_tree().get_nodes_in_group("options_button"):
		if button is CheckBox:
			button.pressed.connect(onButtonPressed.bind(button))
			
		if button is OptionButton:
			button.item_selected.connect(onButtonSelected.bind(button))

func _process(delta) -> void:
	if(Input.is_action_just_pressed("ui_cancel")):
		visible = not visible
		get_tree().paused = not get_tree().paused
		if visible: 
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE 
			return
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
func onButtonPressed(buttonPressed: CheckBox) -> void:
	var parent = buttonPressed.get_parent().get_parent()
	var textProperty: String = parent.name.to_snake_case()
	
	match textProperty:
		"use_taa":
			get_viewport().use_taa = buttonPressed.button_pressed
		"display_fps":
			fpsContainer.visible = buttonPressed.button_pressed
		"ssr_enabled":
			worldEnviroment.environment.ssr_enabled = buttonPressed.button_pressed
		"ssao_enabled":
			worldEnviroment.environment.ssao_enabled = buttonPressed.button_pressed
		"ssil_enabled":
			worldEnviroment.environment.ssil_enabled = buttonPressed.button_pressed
		"sfdgi_enabled":
			worldEnviroment.environment.sdfgi_enabled = buttonPressed.button_pressed
	buttonPressed.release_focus()

func onButtonSelected(buttonIndex: int, buttonSelected: OptionButton) -> void:
	var parent = buttonSelected.get_parent().get_parent()
	var textProperty: String = parent.name.to_snake_case()
	match textProperty:
		"msaa_3d":
			updateMSAA3D(buttonIndex)
			
		"screen_space_aa":
			updateScreenSpaceAA(buttonIndex)
			
	buttonSelected.release_focus()
	
func updateMSAA3D(index: int) -> void:
	var viewport: Viewport = get_viewport()
	
	match index:
		0:
			viewport.msaa_3d = viewport.MSAA_DISABLED
		1: 
			viewport.msaa_3d = viewport.MSAA_2X
		2:
			viewport.msaa_3d = viewport.MSAA_4X
		3: 
			viewport.msaa_3d = viewport.MSAA_8X

func updateScreenSpaceAA(index: int) -> void:
	var viewport: Viewport = get_viewport()
	
	match index:
		0:
			viewport.screen_space_aa = viewport.SCREEN_SPACE_AA_DISABLED
		1: 
			viewport.screen_space_aa = viewport.SCREEN_SPACE_AA_FXAA
