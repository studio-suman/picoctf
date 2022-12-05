with open ('message.txt') as filep:
    contents = filep.read()

flag = []
for i in range(0, len(contents),3):
    chunk = contents[i : i + 3]
    a , b , c = chunk
    flag.append(c + a + b)
flag = "".join(flag).split()[-1]
print(flag)