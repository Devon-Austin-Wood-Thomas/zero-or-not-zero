#!/usr/bin/env python3

from math import *
import sys

try:
    input = raw_input
except NameError:
    pass


print("Let's play the game!")
while True:
	try:
		x = input("Zero or Not Zero: ")
		if not x:
			print("It's not hard, you just have to know how to do it.")
			continue
		if x.lower() == "zero":
			print("That one is ZERO.")
			continue
		try:
			if eval(x) == 0:
				print("That one is ZERO.")
			else:
				print("That one is NOTZERO.")
		except (NameError, SyntaxError):
			print("That one is NOTZERO.")
	except KeyboardInterrupt:
		print("")
		print("Doesthatmakesense.")
		break

