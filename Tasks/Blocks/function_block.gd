@tool
extends BaseBlock
class_name BlockFunction


func add_child_block():
	print("Can't add children to function blocks")

func set_task(task: Task):
	_task = task
	%Name.text = _task.name
