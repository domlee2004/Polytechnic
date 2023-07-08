import math
# Cyclic shift left
def rotate(l,n):
   return l[n:] + l[:n]
def leftRotate(arr, d, n):
    for i in range(d):
        leftRotatebyOne(arr, n)

def leftRotatebyOne(arr, n):
    temp = arr[0]
    for i in range(n-1):
        arr[i] = arr[i+1]
    arr[n-1] = temp
   
#Cyclic shit right

   
# Word size 16 bits / 4 Bytes
def RC5(w, r, b, K = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'):
   #Getting hex values of P and
   t = 2 * r + 2
   if w == 16:
      P = 'b7e1'
      P = int(P, 16)
      #P = hex(P)
      Q = '9e37'
      Q = int(Q, 16)
      #Q = hex(Q)

   elif w == 32:
      P = 'b7e15163'
      P = int(P, 16)
     #P = hex(P)
      Q = '9e3779b9'
      Q = int(Q, 16)
     #Q = hex(Q)

   elif w == 64:
      P = 'b7e151628aed2a6b'
      P = int(P, 16)
      #P = hex(P)
      Q = '9e3779b97f4a7c15'
      Q = int(Q, 16)
      #Q = hex(Q)
   K = list(K)
   u = int(len(K)/8)
   c = int(max(len(K), 1)/u)
   L = []
   for i in range(c):
      if i%2==0:
         L.append(1)
      else:
         L.append(0)
   for i in range(b-1, 0, -1):
      leftRotate(L, 8, len(L))
      L[math.floor(i/u)] = L[math.floor(i/u)] + int(K[i])
   print(L)
   S = []
   for i in range(0,t,1):
      S.append(0)
   S[0] = P
   for i in range(1, t-1):
      S[i] = S[i-1] + Q
   i, j, X, Y = 0,0,0,0
   iterations = 3 * max(t,c)
   print(S)
   for i in range(0,iterations,1):
      #X = S[i] = (S[i] + (X + Y)) << 3
      S[i] += X + Y
      X = S[i] = leftRotate(S, 3, len(S))
      #Y = L[j] = (L[j] + (X + Y)) << (X + Y)
      L[j] = L[j] + X + Y
      Y = L[j] = leftRotate(L, (X+Y), len(L))
      i = (i + 1) % t
      j = (j + 1) % c
   
      
   
   
   
      







