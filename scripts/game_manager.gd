extends Node

var score = 0
var score_last_level = 0
var label_score: Label

func add_point():
	score += 1
	if label_score:
		label_score.text = str(score).pad_zeros(2) 
	print(str("score is " , score))

func end_level():
	score_last_level = score

func init_level():
	score = score_last_level
	
func fade_in_music(music):
	var tween = create_tween()
	music.volume_db = -80 
	tween.tween_property(music, "volume_db", 0, 1.0)

func fade_out_music(music):
	var tween = create_tween()
	tween.tween_property(music, "volume_db", -80, 1.0)
