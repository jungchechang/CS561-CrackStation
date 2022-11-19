import json
import hashlib

def sha1_encrypt(password):
    sha1 = hashlib.sha1(password.encode('utf-8'))
    result = sha1.hexdigest()
    return result
def sha256_encrypt(password):
    sha256 = hashlib.sha256(password.encode('utf-8'))
    result = sha256.hexdigest()
    return result

def create_table():

    my_dict = {}

    for x in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789?!":
        my_dict[sha1_encrypt(x)]=x
        my_dict[sha256_encrypt(x)]=x
        for y in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789?!":
            my_dict[sha1_encrypt(x+y)]=x+y
            my_dict[sha256_encrypt(x+y)]=x+y
            for z in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789?!":
                my_dict[sha1_encrypt(x+y+z)]=x+y+z
                my_dict[sha256_encrypt(x+y+z)]=x+y+z
        
    with open("data.json","w") as f:
        json.dump(my_dict,f)
