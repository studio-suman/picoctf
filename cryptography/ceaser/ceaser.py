import string

LOWERCASE_OFFSET = ord("a")
ALPHABET = string.ascii_lowercase[:24]

def b16_encode(plain):
	enc = ""
	for c in plain:
		binary = "{0:08b}".format(ord(c))
		enc += ALPHABET[int(binary[:4], 2)]
		enc += ALPHABET[int(binary[4:], 2)]
	return enc

def b16_decode(cipher):
	enc = ""
	for i in range(0, len(cipher), 2):
		binary = "{0:04b}".format(ALPHABET.index(cipher[i]))+"{0:04b}".format(ALPHABET.index(cipher[i+1]))
		enc += chr(int(binary, 2))
	return enc

def shift(c, k):
	t1 = ord(c) - LOWERCASE_OFFSET
	t2 = ord(k) - LOWERCASE_OFFSET
	return ALPHABET[(t1 + t2) % len(ALPHABET)]

flag = "redacted"
key = "redacted"
#assert all([k in ALPHABET for k in key])
#assert len(key) == 1

#b16 = b16_encode(flag)
#enc = ""
#for i, c in enumerate(b16):
#	enc += shift(c, key[i % len(key)])
#print(enc)


cipher = "dspttjohuifsvcjdpoabrkttds"

print(len(cipher))
for key in ALPHABET:
	dec= ""
	for c in cipher:
		dec += shift(c, key)
	b16 = b16_decode(dec)
	print("picoCTF{"+b16,key+"}")