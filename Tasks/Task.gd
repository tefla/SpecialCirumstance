extends Resource
class_name Task


@export var name = "Base Task"
@export var properties: Array[TaskProperty] = []

#region Children
@export var canHaveChildren: bool = false
@export var children: Array[Task] = []
#endregion


func _exec():
	pass


func _debug(depth = 0):
	print("=> %s Name: %s" % [" ".repeat(depth), name])
	for child in children:
		child._debug(depth+1)
