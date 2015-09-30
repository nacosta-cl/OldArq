__author__ = 'Cristobal'


def sumBin(dec):
    b = ''
    if(dec==0):
        b = '0'
    while(dec!=0):
        if(dec%2==1):
            b='1'+b
            dec=(dec-1)/2
        else:
            b='0'+b
            dec=dec/2
    return b

def Rellena(N):
    longitud = 33-len(N)
    Numero = '0'*longitud
    Numero+=N
    return Numero




lista = [
    "MOV A,B ",
    'MOV B,A',
    'MOV A,Lit',
    'MOV B,Lit',
    'MOV A,(Dir)',
    'MOV B,(Dir)',
    'MOV (Dir),A',
    'MOV (Dir),B',

    'ADD A,B',
    'ADD B,A',
    'ADD A,Lit',
    'ADD B,Lit',
    'ADD A,(Dir)',
    'ADD B,(Dir)',
    'ADD (Dir)',

    'SUB A,B',
    'SUB B,A',
    'SUB A,Lit',
    'SUB B,Lit',
    'SUB A,(Dir)',
    'SUB B,(Dir)',
    'SUB (Dir)',

    'AND A,B',
    'AND B,A',
    'AND A, Lit',
    'AND B, Lit',
    'AND A,(Dir)',
    'AND B,(Dir)',
    'AND(Dir)',


    'OR A,B',
    'OR B,A',
    'OR A,Lit',
    'OR B,Lit',
    'OR A,(Dir)',
    'OR B,(Dir)',
    'OR (Dir)',

    'XOR A,B',
    'XOR B,A',
    'XOR A,Lit',
    'XOR B,Lit',
    'XOR A,(Dir)',
    'XOR B,(Dir)',
    'XOR (Dir)',

    'NOT A',
    'NOT B,A',
    'NOT (Dir),A',

    'SHL A',
    'SHL B,A',
    'SHL (Dir),A',

    'SHR A',
    'SHR B,A',
    'SHR (Dir),A',

    'INC A',
    'INC B',
    'INC (Dir)',

    'DEC A',

    'CMP A,B',
    'CMP A,Lit',
    'CMP A,(Dir)',

    'JMP Ins',
    'JEQ Ins',
    'JNE Ins',
    'JGT Ins',
    'JGE Ins',
    'JLT Ins',
    'JLE Ins',
    'JCR Ins',
    'NOP'
]

dict = {}
for i in range(len(lista)):
        dict[lista[i]]=Rellena(sumBin(i+1))
        ##print(lista[i]+"="+str(i))
##print(dict)


def leer(Archivo):
    ar = open(Archivo,'r')
    linea = ar.readline()
    lista = []
    while linea != "":
        x =linea.split('//')
        if(':' in x[0]):
            while True:
                linea = ar.readline()
                w = linea.split('//')
                


            if(':' not in )


        print(x)
        linea = ar.readline()
    ar.close()



leer('Ejemplo1.txt')