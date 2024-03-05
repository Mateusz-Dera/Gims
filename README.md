# Gims
## Godot InputMap Save
Allows easy saving and loading of InputMap in Godot 4.2.1

## Info
[![Version](https://img.shields.io/badge/1.3-Plugin_version-orange.svg)](https://github.com/Mateusz-Dera/Gims)
[![Version](https://img.shields.io/badge/4.2.1-Godot_version-blue.svg)](https://github.com/Mateusz-Dera/Gims)

## Instalation:
Download latest version from releases or clone the repository. Move files to your main project folder.

## Translations:
Make sure that `translations.csv` imported correctly.

Go to Project → Project Settings → Localization and add all generated `.translation` files.

|Supported languages|
|:---|
|English|
|Polish|

## Set saving settings:
|Type|GDScript code|Default value|Additional informations|
|:---|:---|:---|:---|
|Save path|```set_path(<path>")```|```user://input_map.tres```||
|Ignore ui_|```set_ignore_ui(<bool>)```|```false```||
|Ignore editor_|```set_ignore_ui(<bool>)```|```true```||
|Limit of assigned keys/buttons/axes|```set_limit(<int>)```|```0```|less than or equal to 0 = unlimited|

## Get saving settings:
|Type|GDScript code|
|:---|:---|
|Save path|```get_path
|Ignore ui_|```get_ignore_ui()```|
|Ignore editor_|```get_ignore_ui()```|
|Limit|```get_limit()```|

## Save & Load
|Type|GDScript code|
|:---|:---|
|Save|```input_map_save()```|
|Load|```input_map_load()```|

## Get list of mapped keys/buttons/axes
|Type|GDScript code|Device|Type|Array|Physical|
|:---|:---|:---|:---|:---|:---|
|Save path|```get_input_action_mapped_keys(<action>,<device>,<type>,<array>)```|```true```|```true```|```true```|```true```|

#### Type and array are optional arguments: 
|Name|Description|
|:---|:---|
|```<device>```|Display the controller number.| 
|```<type>```|Display the input type.|
|```<array>```|Function should return an array instead of string.|
|```<physical>```|Display information if the key is physical.|

|Type|GDScript code|
|:---|:---|
|Index|```get_input_action_event_at(<action>,<index>)```|
|First|```get_input_action_first_event(<action>)```|
|Last|```get_input_action_last_event(<action>)```|

## Is any key/button/axis from A is in B
|Type|GDScript code|
|:---|:---|
|Is duplicated|```is_duplicated(<action_a>,<action_b>)```|

## Input types
|Type|GDScript code|Keyboard|Mouse|Gamepad|
|:---|:---|:---|:---|:---|
|Is valid|```is_valid_input_event(<event>,<keyboard>,<mouse>,<gamepad>)```|```true```|```true```|```true```|

## Remapping
|Type|GDScript code|
|:---|:---|
|Add|```add_to_input_action_mapped(<action>,<event>)```|
|Remove|```remove_from_input_action_mapped(<action>,<event>)```|
|Replace|```replace_one_in_input_action_mapped(<action>,<event>)```|

## Vibrate all joypads
|Type|GDScript code|Weak|Strong|Duration|
|:---|:---|:---|:---|:---|
|Is valid|```vibrate_all_joypads(<weak>,<strong>,<duration>)```|```float```|```float```|```0```|

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
	print(gims.get_input_action_mapped("ui_right"))
	pass
```

### Is any key/button/axis from A is in B
```python
func _ready():
	var gims = Gims.new()
	print(gims.is_duplicated("ui_right","ui_left"))
	pass
```

### Input types
```python
extends Node2D

var gims = Gims.new()

func _ready():
	pass

func _input(event):
	if gims.is_valid_input_event(event):
		print("Keyboard/Mouse/Joypad")
```

```python
extends Node2D

var gims = Gims.new()

func _ready():
	pass

func _input(event):
	if gims.is_valid_input_event(event,true,false,false):
		print("Only keyboard")
```
```python
extends Node2D

var gims = Gims.new()

func _ready():
	pass

func _input(event):
	if gims.is_valid_input_event(event,true,false,true):
		print("Only keyboard and joypad")
```

### Remapping
``` python
extends Node2D

var gims = Gims.new()

func _ready():
	print(gims.get_input_action_mapped("ui_right"))
	pass

func _input(event):
	if gims.is_valid_input_event(event):
		gims.add_to_input_action_mapped("ui_right",event)
		print(gims.get_input_action_mapped("ui_right"))
		print("Added")
```

``` python
extends Node2D

var gims = Gims.new()

func _ready():
	print(gims.get_input_action_mapped("ui_right"))
	pass

func _input(event):
	if gims.is_valid_input_event(event):
		gims.remove_from_input_action_mapped("ui_right",event)
		print(gims.get_input_action_mapped("ui_right"))
		print("Removed")
```

### Vibrate all joypads
``` python
extends Node2D

var gims = Gims.new()

func _ready():
	gims.vibrate_all_joypads(0.25, 0.25, 0.1)
	pass
```