
import string


s = "cvpbPGS{abg_gbb_onq_bs_n_ceboyrz}"

def rot(s, n=13):
    '''Encode string s with ROT-n, i.e., by shifting all letters n positions.
    When n is not supplied, ROT-13 encoding is assumed.
    '''
    upper = string.ascii_uppercase
    lower = string.ascii_lowercase
    upper_start = ord(upper[0])
    lower_start = ord(lower[0])
    out = ''
    for letter in s:
        if letter in upper:
            out += chr(upper_start + (ord(letter) - upper_start + n) % 26)
        elif letter in lower:
            out += chr(lower_start + (ord(letter) - lower_start + n) % 26)
        else:
            out += letter
    return(out)

def invrot(s, n=13):
    '''Decode a string s encoded with ROT-n-encoding
    When n is not supplied, ROT-13 is assumed.
    '''
    return(rot(s, -n))

if __name__ == "__main__":
    print(invrot(s))

