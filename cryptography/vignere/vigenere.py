# Python code to implement
# Vigenere Cipher

# This function generates the
# key in a cyclic manner until
# it's length isn't equal to
# the length of original text

encrypt='rgnoDVD{O0NU_WQ3_G1G3O3T3_A1AH3S_f85729e7}'
key2='CYLABCYLABCYLABCYLABCYLABCYLABCYLABCYLABCYLAB'

# Old code
def generateKey(string, key):
	key = list(key)
	if len(string) == len(key):
		return(key)
	else:
		for i in range(len(string) -
					len(key)):
			key.append(key[i % len(key)])
	return("" . join(key))
	
# This function returns the
# encrypted text generated
# with the help of the key
""" 
	def cipherText(string2, key):
	cipher_text = []
	string = str(string2).upper()
	print(string)
	for i in range(len(string)):
		x = (ord(string[i]) +
			ord(key[i])) % 26
		x += ord('A')
		cipher_text.append(chr(x))
	return("" . join(cipher_text))
	
# This function decrypts the
# encrypted text and returns
# the original text
def originalText(cipher_text2, key):
	orig_text = []
	cipher_text = str(cipher_text2).upper()
	print(cipher_text)
	for i in range(len(cipher_text)):
		x = (ord(cipher_text[i]) -
			ord(key[i]) + 26) % 26
		x += ord('A')
		orig_text.append(chr(x))
	return("" . join(orig_text)) """

def vigenere(x,key):
    lst_final = []
    code = list(x)
    j = 0
	
    for i,char in enumerate(code):
        if char.isalpha():
            code[i] = key[(i+j)%len(key)]
            if encrypt:
                lst_final.append((ord(x[i]) + ord(code[i]) - 65 * 2) % 26)
            else:
                lst_final.append((ord(x[i]) - ord(code[i])) % 26)
        else:
            lst_final.append(ord(char))
            j -=1

    for i,char in enumerate(code):
        if char.isalpha():
            lst_final[i] = chr(lst_final[i] + 65)
        else:
            lst_final[i] = chr(lst_final[i])
			
    return ''.join(lst_final)

# Driver code
if __name__ == "__main__":
	string = "rgnoDVD{O0NU_WQ3_G1G3O3T3_A1AH3S_f85729e7}"
	keyword = "CYLAB"
	encrypt = False
	#key = generateKey(string, keyword)
	#cipher_text = cipherText(string,key)
	#print("Ciphertext :", cipher_text)
	#print("Original/Decrypted Text :",originalText(encrypt, key2))
	print("Cipher Text :",string)
	print("Original/Decrypted Text2 :",
		vigenere(str(string).upper(), keyword))

# This code is contributed
# by Pratik Somwanshi
