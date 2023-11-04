# Gims
## Godot InputMap Save
Allows easy saving and loading of InputMap in Godot 4.2.beta4

> [!WARNING]
> WORK IN PROGRESS

## Info
[![Version](https://img.shields.io/badge/0.1-Plugin_version-orange.svg)](https://github.com/Mateusz-Dera/Gims)
[![Version](https://img.shields.io/badge/4.2.beta4-Godot_version-blue.svg)](https://github.com/Mateusz-Dera/Gims)

## Instalation:
Download the latest version from the releases or clone repository. Move files to your main project folder.

## Translations:
Make sure that translations.csv imported correctly.

Go to Project → Project Settings → Localization and add all generated .translation files

|Supported languages|
|:---|
|English|
|Polish|

## Set saving settings:
|Type|GDScript code|Default value|
|:---|:---|:---|
|Save path|```set_path(<path>")```|```user://input_map.tres```|
|Ignore ui_|```set_ignore_ui(<bool>)```|```false```|
|Ignore editor_|```set_ignore_ui(<bool>)```|```true```|

## Get saving settings:
|Type|GDScript code|
|:---|:---|
|Save path|```get_path()```|
|Ignore ui_|```get_ignore_ui()```|
|Ignore editor_|```get_ignore_ui()```|

## Save & Load
|Type|GDScript code|
|:---|:---|
|Save|```input_map_save()```|
|Load|```input_map_load()```|

## Get list of mapped keys/buttons/axes
|Type|GDScript code|Device|Type|Array|
|:---|:---|:---|:---|:---|
|Save path|```get_input_action_mapped_keys(<action>,<device>,<type>,<array>)```|```true```|```true```|```true```|

#### Type and array are optional arguments: 

\<device> is responsible for displaying the controller number. 

\<type> is responsible for displaying the input type. 

\<array> whether the function should return an array or a string.


## Example of use:
### Save
```python
func _ready():
	var gims = Gims.new()
	gims.input_map_save()
	pass
```

```python
func _ready():
	func _ready():
	var gims = Gims.new()
	gims.set_path("user://my_input_custom_name.tres")
	gims.set_ignore_ui(true)
	gims.set_ignore_editor(true)
	gims.input_map_save()
	pass
```

### Load
```python
func _ready():
	var gims = Gims.new()
	gims.input_map_load()
	pass
```

```python
func _ready():
	func _ready():
	var gims = Gims.new()
	gims.set_path("user://my_input_custom_name.tres")
	gims.input_map_load()
	pass
```

### Get list of mapped keys/buttons/axes
```python
func _ready():
	var gims = Gims.new()
	print(gims.get_input_action_mapped_keys("ui_right"))
	pass
```
