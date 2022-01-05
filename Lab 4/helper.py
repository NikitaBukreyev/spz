import keyboard	# pip3 install keyboard
import random
import time

lines = [	# Type anything you want
"004,109,207,103",
'226,026,249,237',
"004,040,032,033",
"174,208,189,250"
]

print('C - 1d array\nX - 2d array')

while True:
	try:
		if keyboard.is_pressed('x'):
			print("Ima typin' 2d array")
			keyboard.send("backspace")
			for i in lines:
				keyboard.write(i, exact=False, delay=0.05)
				time.sleep(0.05)
				keyboard.send("enter")
			print("Done!")
			break

		if keyboard.is_pressed('c'):
			print("Ima typin' 1d array")
			keyboard.send("backspace")
			for i in lines:
				keyboard.write(i, exact=False, delay=0.05)
				keyboard.write(",", exact=False, delay=0.05)
			keyboard.send("enter")
			print("Done!")
			break
	except:
		break