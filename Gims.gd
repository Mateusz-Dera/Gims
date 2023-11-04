# Copyright 2023 Mateusz Dera

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class_name Gims

var gims_path := "user://input_map.tres"
var gims_ignore_ui_ = false
var gims_ignore_editor_ = true

func set_path(path: String = "user://input_map.tres") -> void:
	gims_path = path

func get_path() -> String:
	return gims_path

func set_ignore_ui(ignore: bool = false) -> void:
	gims_ignore_ui_ = ignore

func get_ignore_ui() -> bool:
	return gims_ignore_ui_

func set_ignore_editor(ignore: bool = true) -> void:
	gims_ignore_editor_ = ignore

func get_ignore_editor() -> bool:
	return gims_ignore_editor_

func input_map_exceptions(action) -> bool:
	return !((action.begins_with("editor_") and gims_ignore_editor_) or (action.begins_with("ui_") and gims_ignore_ui_))

func input_map_save() -> void:
	var actions := InputMap.get_actions()
	var resource := GimsResource.new()
	
	for a in actions:
		if input_map_exceptions(a):
			resource.controls[a] = InputMap.action_get_events(a)
	
	var e := ResourceSaver.save(resource, gims_path)
	if e != OK:
		push_error("Saving error: ", error_string(e))
	else:
		print_debug("InputMap saved correctly")

func input_map_load() -> void:
	print_debug("Checking if a save file exists")
	if not ResourceLoader.exists(gims_path, &"GimsResource"):
		push_error("InputMap file not found: ", gims_path)
		push_warning("Default InputMap will be loaded")
		return

	print_debug("Checking if the save file is valid")
	var resource: GimsResource = ResourceLoader.load(gims_path, &"GimsResource")
	if not is_instance_valid(resource):
		push_error("The loaded InputMap file is corrupt or its type is invalid")
		return

	print_debug("Clear default InputMap")
	for action in InputMap.get_actions():
		for event in InputMap.action_get_events(action):
			InputMap.action_erase_event(action, event)
	
	print_debug("Overwrite default InputMap")
	for action in resource.controls.keys():
		for event in resource.controls[action]:
			InputMap.action_add_event(action, event)
			
	print_debug("InputMap loaded correctly")
	
func get_input_action_mapped_keys(action: String = "", device: bool = true, type: bool = true, array: bool = true):	
	var inputs = []
	
	if action != "":
		for input in InputMap.action_get_events(action):
			var split = str(input).split(":")
			var val = null
			var d = null
			var t = null
			var translation = null
			# todo
			if split[0] == "InputEventKey":
				translation = input.as_text()
				var id = "KEY_GISP_KEY_%s" % [translation.to_upper()]
				if tr(id) != id:
					translation = tr(id)
			# translated
			elif split[0] == "InputEventJoypadButton":
				t = tr("KEY_GISP_BUTTON")
				translation = input.button_index
				if int(input.button_index) <= 20:
					translation = tr("KEY_GISP_BUTTON_%s" % input.button_index)
			# translated
			elif split[0] == "InputEventJoypadMotion":
				t = tr("KEY_GISP_JOYPAD")
				var axis = split[1].split(",")[0].split("=")[1]
				var value = "MINUS"
				if float(split[1].split(",")[1].split("=")[1]) > 0:
					value = "PLUS"
				translation = tr("KEY_GISP_AXIS_%s_%s" % [axis,value])
			# translated
			elif split[0] == "InputEventMouseButton":
				t = tr("KEY_GISP_MOUSE")
				translation = tr("%s%s" % ["KEY_GISP_", input.as_text().to_upper().replace(" ", "_")])
			d = input.device
			
			if t != null and translation != null:
				if type == false: t = ""
				if device == false or d == -1: 
					d = ""
				else:
					d = " %s" % str(d)
				if d or t:
					val = "%s%s: %s" % [t, d, translation]
				else:
					val = translation
				inputs += [val]
			
	if inputs == []:
		inputs = [tr("KEY_GISP_EMPTY")]
		
	if array == false:
		var final = ""
		for i in inputs:
			if final != "":
				final += ", "
			final += i
		return final
			
	return inputs
