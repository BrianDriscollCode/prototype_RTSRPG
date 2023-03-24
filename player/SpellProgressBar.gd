extends TextureProgress


func _ready():
	self.set_visible(false);
	
func tweenActionProgress():
	self.set_visible(true);
	var tween = get_tree().create_tween();
	tween.tween_property(self, "value", 100, 3).set_trans(Tween.TRANS_LINEAR)

