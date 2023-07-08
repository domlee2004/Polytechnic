import pyscrypt

# Hash
hashed = pyscrypt.hash(password = b"p@$S", 
                       salt = b"aa1f2d3f4d23ac", 
                       N = 2048, 
                       r = 8, 
                       p = 1, 
                       dkLen = 32)
print(hashed.hex())
print(int(hashed.hex(), 16))

# Write a file
with pyscrypt.ScryptFile('filename.scrypt', b'password', 1024, 1, 1) as f:
    f.write(b"Hello world")

# Read a file
with pyscrypt.ScryptFile('filename.scrypt', b'password') as f:
    data = f.read()
    print(data)
