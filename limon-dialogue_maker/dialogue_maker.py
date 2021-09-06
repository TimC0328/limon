import json
import keyboard
import time


currentLine = 0
lines = 0

inputTimer = 100

def print_line(line):
    if data["lines"][line]["name"] == "EXIT":
        print ("\nLine: " + str(line) + "\nExit Dialogue")
        return
    print("\nLine: " + str(line) + "\nName: " + data["lines"][line]["name"] + "\nAnimation: " + data["lines"][line]["animation"] + "\nText: " + data["lines"][line]["text"] + "\nBranch: " + str(data["lines"][line]["branch"]))




with open("test-branch.json") as file:
        data = json.load(file)

for line in data["lines"]:
    lines += 1

print("There are " + str(lines) + " lines of dialogue")

print_line(0)

while True:
    if keyboard.is_pressed('up') and currentLine < lines -1:
        currentLine += 1
        print_line(currentLine)
        time.sleep(0.5)
    if keyboard.is_pressed('down') and currentLine > 0:
        currentLine -= 1
        print_line(currentLine)
        time.sleep(0.5)
    
    if keyboard.is_pressed('escape'):
        break
