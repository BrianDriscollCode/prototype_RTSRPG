extends TextureProgress

func _ready():
	self.set_visible(false);
	
#func _physics_process(delta):
#	if self.value == 100:
#		print("GOGO")
#		self.value = 0;
#
func tweenActionProgress():
	self.set_visible(true);
	var tween = get_tree().create_tween();
	tween.tween_property(self, "value", 100, 3).set_trans(Tween.TRANS_LINEAR)
	
	

