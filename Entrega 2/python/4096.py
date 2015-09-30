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

label = {}

intrucciones = {}
for i in range(len(lista)):
        intrucciones[lista[i]]=Rellena(sumBin(i+1))


def leer(Archivo,label):
    ar = open(Archivo,'r')  ## Abrir el archivo
    linea = ar.readline()   ## Leer la primera linea
    while linea:        ## Sale cuando la linea leida esta vacia
        nombre = linea.split(':')   ## Separamos el nombre del label
        label[nombre[0]] = []       ## Creamos una llave con el nombre del label y la clave es una lista para todas las instrucciones 
        while linea:    ## Nuevamente sale cuando la linea esta vacia
            linea = ar.readline()  ## Leemos la siguiente linea, que corresponden a las intrucciones dentro del label
            w = linea.split('//')  ## Separamos los comentarios
            if not ":" in w[0]:   ## Si la linea no contiene :, significa que no es un nuevo label, por lo tanto lo agregamos a la lista de instrucciones en el dic.
                label[nombre[0]].append(w[0].strip())  ## Lo agregamos al dic.
            else:
                break
            
    ar.close()## Cerramos el archivo
    





leer('Ejemplo1.txt',label)
