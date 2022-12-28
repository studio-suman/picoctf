#!/usr/bin/env python3
import sys
from pwn import xor
from random import randint

#--------Data--------#

c = bytes.fromhex("57657535570c1e1c612b3468106a18492140662d2f5967442a2960684d28017931617b1f3637")

#--------XOR--------#

random_strs = [
    b'my encryption method',
    b'is absolutely impenetrable',
    b'and you will never',
    b'ever',
    b'break it'
]

while True:
    for random_str in random_strs:
        for m in range(randint(0, pow(2, 0))):
            c = xor(c, random_str)

    flag_prefix = b"picoCTF{"
    key = xor(c[:len(flag_prefix)], flag_prefix)
    # if key.decode().isprintable():
    #     print(key)
    #     sys.exit()

    key = b'Africa!'
    flag = xor(c, key)
    if flag.startswith(b"picoCTF{"):
        print(flag.decode())
        sys.exit()