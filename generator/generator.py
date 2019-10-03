import random


diceware_filename = 'words.txt'

with open(diceware_filename, 'r') as f:
    lines = f.read().split('\n')

words = {}
for line in lines:
    if line == '':
        continue
    k, v = line.split('\t')
    words[k] = v

def generate():
    p = ''
    for i in range(5):
        p += str(random.randrange(1, 7))
    return p

while True:
    a = input('Press any key to generate another word, or q to quit: ')
    if a == 'q':
        break
    print ('Word: %s' % words[generate()])
print('Goodbye!!!')
