extends Resource
class_name Task


var name = "Base Task"
@export var default_properties: Array[TaskProperty] = []
var block: PackedScene = preload("res://Tasks/Blocks/NewBlockFunction.tscn")

#region Children
var canHaveChildren: bool = false
@export var children: Array[Task] = []
#endregion

var properties: Array[TaskProperty] = []

# States
enum {
	FRESH,
	RUNNING,
	FAILED,
	SUCCEEDED,
	CANCELLED
}

var control = null
var tree = null
# var guard = null
var status = FRESH
	
# Final methods
func running():
	status = RUNNING
	if control != null:
		control.child_running()

func success():
	status = SUCCEEDED
	if control != null:
		control.child_success()

func fail():
	status = FAILED
	if control != null:
		control.child_fail()

func cancel():
	if status == RUNNING:
		status = CANCELLED
		# Cancel child tasks
		for child in children:
			child.cancel()

# Abstract methods
func run():
	# Process the task and call running(), success(), or fail()
	pass

func child_success():
	success()

func child_fail():
	fail()

func child_running():
	running()

# Non-final non-abstact methods
func start():
	status = FRESH
	for child in children:
		child.control = self
		child.tree = self.tree
		child.start()

func reset():
	cancel()
	status = FRESH

#region Block
func get_block():
	var _block: BaseBlock = block.instantiate()
	_block.set_task(self)
	return _block
	
#endregion Block
