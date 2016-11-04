import sys

print("Let's play the game!")
while True:
	try:
		x = str(input("Zero or Not Zero: "))
		if eval(x) == 0:
			print("That one is ZERO.")
		else:
			print("That one is NOTZERO.")
	except KeyboardInterrupt:
		print("")
		print("Doesthatmakesense.")
		sys.exit()
