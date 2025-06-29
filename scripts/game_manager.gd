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
