extends Control
class_name gm

var dict = {
	"credicor"  = [0,0],
	"ecoline"= [0,0],
	"helion"= [0,0],
	"guilde miniere"= [0,0],
	"cinematiques"= [0,0],
	"inventrix"= [0,0],
	"phobolog"= [0,0],
	"tharsis"= [0,0],
	"thorgate"= [0,0],
	"unmi"= [0,0],
	"teractor"= [0,0],
	"saturn systems"= [0,0],
	"cheung shing mars"= [0,0],
	"point luna"= [0,0],
	"robinson industries"= [0,0],
	"valley trust"= [0,0],
	"vitor"  = [0,0]
}

var dictPrelude = {
	"credicor"  = [0,0],
	"ecoline"= [0,0],
	"helion"= [0,0],
	"guilde miniere"= [0,0],
	"cinematiques"= [0,0],
	"inventrix"= [0,0],
	"phobolog"= [0,0],
	"tharsis"= [0,0],
	"thorgate"= [0,0],
	"unmi"= [0,0],
	"teractor"= [0,0],
	"saturn systems"= [0,0],
	"cheung shing mars"= [0,0],
	"point luna"= [0,0],
	"robinson industries"= [0,0],
	"valley trust"= [0,0],
	"vitor"  = [0,0]
}
@onready var main_menu = $MainMenu
@onready var message_display = $AddGameMenu/MessageDisplay
@onready var corpo_text =$AddGameMenu/HBoxContainer/CorpoTextEdit
@onready var points_text = $AddGameMenu/HBoxContainer/PointsTextEdit2
@onready var options = $AddGameMenu/HBoxContainer/OptionButton
@onready var add_game_menu = $AddGameMenu
@onready var view_stats_menu = $ViewStatsMenu

var save_path = "user://data.save"
var save_path_p = "user://data_p.save"

func _ready():
	load_data()

func _on_add_button_pressed():
	var i=0
	for e in dict:
		if corpo_text.text == e:
			break
		elif i == dict.size()-1:
			display_message(Color.RED , "corporation name error")
			return
		i+=1
	if (points_text.text =="" or int(points_text.text)<0 or int(points_text.text)>120):
		display_message(Color.RED, "invalid points entry")
		return
	elif options.selected == -1 :
		display_message(Color.RED , "select prelude option")
		return
	elif options.selected == 0:
		edit_dict_and_save(dict,corpo_text.text,int(points_text.text))
	else:
		edit_dict_and_save(dictPrelude ,corpo_text.text,int(points_text.text))

func edit_dict_and_save(d , corp , p) :
	var arr = d.get(corp)
	arr[0] = snappedf((arr[0]*arr[1] + p)/(arr[1] +1),0.1)
	arr[1] += 1
	d = sorted_d(d)
	save_data(d)
	display_message(Color.GREEN , "Record added")
	reset_add_fields()

func sorted_d(d):
	var temp_d = {}
	var moys = []
	for e in d:
		moys.append(d[e]) 
	moys.sort()
	print(moys)
	for i in range(moys.size()-1,0,-1):
		for e in d:
			if d[e][0]==moys[i]:
				temp_d[e] = moys.pop_at(i)
	return temp_d

func reset_add_fields() :
	corpo_text.text =""
	points_text.text =""
	options.select(-1)


func save_data(d):
	if d == dict :
		var save_file = FileAccess.open(save_path,FileAccess.WRITE)
		save_file.store_var(d)
	else :
		var save_file = FileAccess.open(save_path_p,FileAccess.WRITE)
		save_file.store_var(d)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		dict = file.get_var()
	if FileAccess.file_exists(save_path_p):
		var file = FileAccess.open(save_path_p, FileAccess.READ)
		dictPrelude = file.get_var()


func display_message(color : Color , s : String):
	var tween = get_tree().create_tween()
	message_display.text = s
	message_display.add_theme_color_override("font_color",color)
	tween.tween_property(message_display,"text","",2)
	

func _on_add_game_button_pressed():
	main_menu.hide()
	add_game_menu.show()
	add_game_menu.move_to_front()	

func _on_back_button_pressed():
	add_game_menu.hide()
	main_menu.show()
	main_menu.move_to_front()


func _on_quit_button_pressed():
	get_tree().quit(0)


func _on_back_data_menu_button_pressed():
	view_stats_menu.hide()
	main_menu.show()
	main_menu.move_to_front()


func _on_view_stats_button_pressed():
	main_menu.hide()
	view_stats_menu.display_data()
	view_stats_menu.show()
	view_stats_menu.move_to_front()
	
