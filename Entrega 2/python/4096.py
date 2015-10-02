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
    longitud = 17-len(N)
    Numero = '0'*longitud
    Numero+=N
    return Numero




lista = [
    "MOV A,B",
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

instrucciones = {}

label = {}
for i in range(len(lista)):
        instrucciones[lista[i]]=Rellena(sumBin(i))
        ##print(lista[i]+"="+str(i))
#print(instrucciones)


orden_labels =[]
l = []

def leer(Archivo,label):
    ar = open(Archivo,'r')
    linea = ar.readline()

    while linea:

        nombre = linea.split(':')
        Nombre = nombre[0].strip()
        orden_labels.append(Nombre)

        label[Nombre]=[]
        while linea:
            linea = ar.readline()

            w = linea.split('//')

            if( ':' not  in w[0]):
                label[Nombre].append(w[0].strip())
            else:
                break
    ar.close()

def contador(Linea):
    conta = 0
    for i in Linea:
        if i == ' ':
            conta+=1
        else:
            break
    return conta

def Leer(Archivo, label):
    Ar = open(Archivo,'r')
    Lineas = Ar.readlines()
    cont = 0
    cccc = -1
    primeras_lineas = []
    while cont < len(Lineas):
        nombre = Lineas[cont].strip()
        nombre = nombre.split(':')
        Nombre = nombre[0].strip()
        orden_labels.append(Nombre)
        label[Nombre]=[]

        while cont < len(Lineas):
            cont+=1
            if cont>=len(Lineas):
                break
            else:
                Linea_anterior = Lineas[cont-1].split(':')
                Linea_anterior = Linea_anterior[0].split('//')
                Linea_anterior = Linea_anterior[0].strip()
                w = Lineas[cont].split('//')

                if Linea_anterior in orden_labels:
                    primeras_lineas.append(contador(w[0]))
                    cccc+=1

                if(':' not  in w[0]):
                    cc = contador(w[0])

                    if cc == primeras_lineas[cccc]:
                        label[Nombre].append(w[0].strip())

                    else:
                        label["CODE"].append(w[0].strip())




                else:
                    break
    Ar.close()


def orden_instrucciones(diccionario,valor,cantidad):
    if len(l)< cantidad:
        if valor != '':

            l.append(valor)
            x = valor.split()
            if len(x)>=2:
                if x != [] and  x[1] in orden_labels:
                    for z in diccionario[x[1]]:
                        if z != '' :
                            orden_instrucciones(diccionario,z,cantidad)


def lista_instrucciones(diccionario,cantidad):
    for x in diccionario["CODE"]:
        orden_instrucciones(diccionario,x,cantidad)

def suma_instrucciones(diccionario, orden_labels):
    contador = 0
    for i in orden_labels:
        if i != "DATA":
            for x in diccionario[i]:
                if x != '':
                    contador+= 1
    return contador



Leer('Ejemplo5.txt',label)



print(label)
lista_instrucciones(label,suma_instrucciones(label,orden_labels))

print(l)


