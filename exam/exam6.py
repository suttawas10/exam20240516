def simpleCipher(encrypted,k):
    listAlphabet = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
    listResult = []
    for x in encrypted:
        indexChar=listAlphabet.index(x)
        decryptIndex = indexChar - k
        decryptChar = listAlphabet[decryptIndex]
        listResult.append(decryptChar)

    result = ''.join(listResult)
    print(result)
    

encrypted = simpleCipher('VTAOG',2)

