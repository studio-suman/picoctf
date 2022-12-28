from pwn import *
#hexdump $esp+4

hid = '4a53475d414503545d025a0a5357450d05005d555410010e4155574b45504601'
key = '861836f13e3d627dfa375bdb8389214e'

print(xor(unhex(hid),key))

""" nc mercury.picoctf.net 35862
Enter Password: reverseengineericanbarelyforward
=========================================
This challenge is interrupted by psociety
What is the unhashed key?
goldfish
Flag is:  picoCTF{p1kap1ka_p1c05729981f} """