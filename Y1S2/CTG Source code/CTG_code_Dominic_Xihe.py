################ OVERVIEW   #################

################ ENCRYPTION #################       # IMPT: NOTE TRY PYCRYPTODOME ELGAMAL USING TAB TO VIEW METHODS #
                                                    # Improvement: Use Scrypt to generate 2 different keys to use for Salsa 20 so both password and password_scrypt will use different Nonce
# 1.  Alice wants to send Bob her password
# 2.  She first runs her password through scrypt to give her password_scrypt
# 2.5 She stores the value of the randomly generated salt
# 3.  She then uses the secret key to encrypt the password_scrypt and her password
# 3.5 She stores the values of both the Nonce generated
# 4.  She sends the nonce values and salt to Bob alongside all the encrypted values

################ DECRYPTION ##################

# 1. Bob uses his private key to decrypt the encrypted secret key to obtain the secret key
# 2. He then uses the secret key and the nonce Alice sent to decrypt both the encrypted password and password_scrypt
# 3. He then runs the password through the Scrypt algorithm using the given salt
# 4. He then compares the value he obtained with the value Alice has sent him

from Crypto.Protocol.KDF import scrypt
from Crypto.Random import get_random_bytes
import os
import elgamal
import Crypto.PublicKey.ElGamal as ElGamal
from Crypto.Cipher import Salsa20
from Crypto.Random import random
from Crypto import Random

#a = ElGamal.generate(1024, Random.new().read)  #private
#a_public_key = a.publickey()
# Generation of ElGamal keys (public,private)
Alice_key_pair = elgamal.generate_keys()
Alice_public_key =  Alice_key_pair.get("publicKey")
Alice_private_key = Alice_key_pair.get("privateKey")

Bob_key_pair = elgamal.generate_keys()
Bob_public_key =  Bob_key_pair.get("publicKey")
Bob_private_key = Bob_key_pair.get("privateKey")

sender_name = "Alice"
receiver_name = "Bob"
password = "I am listening to Moonlight Sonanta 1st Movement currently"
password_bytes = password.encode()

# Encryption

salt = get_random_bytes(32)                                             # Generating salt                                                       
rmb_salt = salt                                                         # Storing salt
password_scrypt = scrypt(password, rmb_salt, 32, N=2**14, r=8, p=1)     # Generating password_scrypt

secret_key_bytes = b'033188161881133d'                                                
cipher = Salsa20.new(secret_key_bytes)                                  # Generating Salsa 20 secret key 

ciphertext_scrypt = cipher.encrypt(password_scrypt)                     # Encrypting password_scrypt with Salsa 20 secret key
nonce_ciphertext_scrypt = cipher.nonce                                  # Storing Nonce

ciphertext_plain = cipher.encrypt(password_bytes)                       # Encrypting password with Salsa 20 secret key
#nonce_ciphertext_plain = cipher.nonce                                  # nonce values are the same

secret_key_string = secret_key_bytes.decode()
encrypt_secret_key = elgamal.encrypt(Bob_public_key, secret_key_string) # Encrypting the secret key with Bob's public key

# Decryption

secret_key_string = elgamal.decrypt(Bob_private_key, encrypt_secret_key)# Decrypting encrypted secret key using Bob's private key
secret_key_bytes = secret_key_string.encode()

decrypter = Salsa20.Salsa20Cipher(secret_key_bytes, nonce_ciphertext_scrypt) # Decrypting both encrypted password and password_scrypt
d_ciphertext_scrypt = decrypter.decrypt(ciphertext_scrypt)
d_ciphertext_plain = decrypter.decrypt(ciphertext_plain)
d_ciphertext_plain = d_ciphertext_plain.decode()
result = scrypt(d_ciphertext_plain, rmb_salt, 32, N=2**14, r=8, p=1)

print("Original message: " + password)
print("\n")
print(b"Hashed message: " + password_scrypt)
print("\n")
print(b"Encrypted message: " + ciphertext_plain)
print("\n")
print(b"Encrypted hash: " + ciphertext_scrypt)
print("\n")
print("Secret key: " + secret_key_string)
print("\n")
print(b"Nonce: " + nonce_ciphertext_scrypt)
print("\n")
print(b"Salt, parameters: " + rmb_salt + b"32, 2^14, r=8, p=1")
print("\n")
print(b"Encrypted secret key: " + encrypt_secret_key.encode())
print("\n")
print(b"Decrypted hash: " + d_ciphertext_scrypt)
print("\n")
print("Decrypted message: " + d_ciphertext_plain)
print("\n")
print(b"Value of Bob's hashed scrypt: " + result)


