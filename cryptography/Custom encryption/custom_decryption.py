from sympy import mod_inverse

# Dynamic XOR decryption function
def dynamic_xor_decrypt(cipher_text, text_key):
    decrypted_text = ""
    key_length = len(text_key)
    for i, char in enumerate(cipher_text):
        key_char = text_key[i % key_length]
        decrypted_char = chr(ord(char) ^ ord(key_char))
        decrypted_text += decrypted_char
    return decrypted_text

# Reverse the modular exponentiation to obtain the original ciphertext
def reverse_generator(g, x, p):
    return pow(g, x, p)

# Decrypt function to reverse the encryption process
def decrypt(cipher, key):
    decrypted_text = ""
    for num in cipher:
        decrypted_num = num // (key*311)  # Reversing the encryption operation
        decrypted_text += chr(decrypted_num)
    return decrypted_text

# Constants from the provided information
a = 90
b = 26
enc_flag = [61578, 109472, 437888, 6842, 0, 20526, 129998, 526834, 478940, 287364, 0, 567886, 143682, 34210, 465256, 0, 150524, 588412, 6842, 424204, 164208, 184734, 41052, 41052, 116314, 41052, 177892, 348942, 218944, 335258, 177892, 47894, 82104, 116314]
p = 97
g = 31

# Reverse modular exponentiation to obtain shared key
u = reverse_generator(g, a, p)
v = reverse_generator(g, b, p)
shared_key = reverse_generator(v, a, p)

# Decrypt intermediate ciphertext
intermediate_ciphertext = decrypt(enc_flag, shared_key)

# Reverse dynamic XOR encryption
flag = dynamic_xor_decrypt(intermediate_ciphertext, "trudeau")

print("Decoded Flag:", flag)

#}b5eebf94_d6tp0rc2d_motsuc{FTCocip
#picoCTF{b5eebf94_d6tp0rc2d_motsuc}