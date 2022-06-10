import hashlib
import sys
from cryptography.fernet import Fernet
import base64

username_trial = b"PRITCHARD"
key_part_static1_trial = "picoCTF{1n_7h3_|<3y_of_"
key_part_static2_trial = "}"

print(key_part_static1_trial+hashlib.sha256(username_trial).hexdigest()[4]+hashlib.sha256(username_trial).hexdigest()[5]+
hashlib.sha256(username_trial).hexdigest()[3]+hashlib.sha256(username_trial).hexdigest()[6]+hashlib.sha256(username_trial).hexdigest()[2]+
hashlib.sha256(username_trial).hexdigest()[7]+hashlib.sha256(username_trial).hexdigest()[1]+hashlib.sha256(username_trial).hexdigest()[8]
+key_part_static2_trial)