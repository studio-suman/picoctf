import string

result = int(hex(11546359515),16) & 0xffffffff
print(f'{result:08x}')