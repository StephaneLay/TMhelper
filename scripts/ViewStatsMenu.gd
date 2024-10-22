extends Control
@onready var gm = $".." as gm
@onready var normalc = $NormalScrollContainer/NormalContainer/Corps
@onready var normalp = $NormalScrollContainer/NormalContainer/Points
@onready var preludec = $PreludeScrollContainer/PreludeContainer/Corps
@onready var preludep = $PreludeScrollContainer/PreludeContainer/Points
var gradient = Gradient.new() 

func _ready():
	gradient.set_color(0,Color.RED)
	gradient.set_color(1,Color.GREEN)

func display_data() :
	print(gm.dictPrelude.size())
	var i = 0
	for e in gm.dict:
		write_data(normalc,normalp,i,e,gm.dict[e][0])
		i+=1
	i=0
	for e in gm.dictPrelude:
		write_data(preludec,preludep,i,e,gm.dictPrelude[e][0])
		i+=1

func write_data(contC,contP,i,c,p):
	contC.get_child(i).text = c
	if p==0:
		contP.get_child(i).add_theme_font_size_override("font_size",32)
		contP.get_child(i).text = "N/A"
	else:
		var f = clampf((p-50)/30,0,1)
		contP.get_child(i).add_theme_color_override("font_color",gradient.sample(f))
		contP.get_child(i).add_theme_font_size_override("font_size",32)
		contP.get_child(i).text = str(p)
	

