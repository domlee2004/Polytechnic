import pyscrypt
import random
from math import pow
# input convert to hex convert to integer


# Hash
plaintextMessage = b"encryption"
hashed = pyscrypt.hash(password = plaintextMessage, 
                       salt = b"saltyasfish", 
                       N = 2048, 
                       r = 8, 
                       p = 1, 
                       dkLen = 32)
# Integer version of Scrypt output (hashed input)
print(str(hashed))
# Plaintext Message in integer version
print(int(plaintextMessage.hex(), 16))

# Write a file
#with pyscrypt.ScryptFile('filename.scrypt', b'password', 1024, 1, 1) as f:
#    f.write(b"Hello world")

# Read a file
#with pyscrypt.ScryptFile('filename.scrypt', b'password') as f:
#   data = f.read()
#    print(data)

#To fing gcd of two numbers
def gcd(a,b):
    if a<b:
        return gcd(b,a)
    elif a%b==0:
        return b
    else:
        return gcd(b,a%b)

#For key generation i.e. large random number
def gen_key(q):
    key= random.randint(pow(10,20),q)
    # Loop until value of key is coprime with q.
    while gcd(q,key)!=1:
        key=random.randint(pow(10,20),q)
    return key

def power(a,b,c):
    x=1
    y=a
    while b>0:
        if b%2==0:
            x=(x*y)%c;
        y=(y*y)%c
        b=int(b/2)
    return x%c

#For asymetric encryption
def encryption(msg,q,h,g):
    ct=[]
    k=gen_key(q)
    s=power(h,k,q)
    p=power(g,k,q)
    for i in range(0,len(msg)):
        ct.append(msg[i])
    print("g^k used= ",p)
    print("g^ak used= ",s)
    for i in range(0,len(ct)):
        ct[i]=s*ord(ct[i])
    return ct,p

#For decryption
def decryption(ct,p,key,q):
    pt=[]
    h=power(p,key,q)
    for i in range(0,len(ct)):
        pt.append(chr(int(ct[i]/h)))
    return pt

a=random.randint(2,10)
msg=input("Enter message.")
# q is rand no. from 10^20 to 10^50
q=random.randint(pow(10,20),pow(10,50))
# g is the random integer x
g=random.randint(2,q)
# To find key value that is coprime with q
key=gen_key(q)
h=power(g,key,q)
print("g used=",g)
print("g^a used=",h)
ct,p=encryption(msg,q,h,g)
print("Original Message=",msg)
print("Encrypted Maessage=",ct)

