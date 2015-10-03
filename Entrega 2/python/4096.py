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

def hexaBin(hexa):
    numero =''
    diccionario = {
        '0':'0000',
        '1':'0001',
        '2':'0010',
        '3':'0011',
        '4':'0100',
        '5':'0101',
        '6':'0110',
        '7':'0111',
        '8':'1000',
        '9':'1001',
        'A':'1010',
        'B':'1011',
        'C':'1100',
        'D':'1101',
        'E':'1110',
        'F':'1111',
    }

    for i in hexa:
        numero+=diccionario[i]

    return numero

def Rellena(N,hasta):
    longitud = hasta-len(N)
    Numero = '0'*longitud
    Numero+=N
    return Numero


lista = {
    'MOV A,B' : '0000000',
    'MOV B,A' : '0000001',
    'MOV A,Lit' : '0000010',
    'MOV B,Lit' : '0000011',
    'MOV A,(Dir)' : '0000100',
    'MOV B,(Dir)' : '0000101',
    'MOV (Dir),A' : '0000110',
    'MOV (Dir),B' : '0000111',

    'ADD A,B' : '0001011',
    'ADD B,A' : '0001100',
    'ADD A,Lit' : '0001101',
    #'ADD B,Lit' : '0000000', ****
    'ADD A,(Dir)' : '0001110',
    #'ADD B,(Dir)' : '0000000', ****
    'ADD (Dir)' : '0010000',

    'SUB A,B' : '0010001',
    'SUB B,A' : '0010010',
    #'SUB A,Lit' : '000000',
    #'SUB B,Lit' : '000000',
    'SUB A,(Dir)' : '0010011',
    #'SUB B,(Dir)' : '000000',
    'SUB (Dir)' : '0010101',

    'AND A,B' : '0010110',
    'AND B,A' : '0010111',
    'AND A, Lit' : '0011000',
    #'AND B, Lit' : '0011001',
    'AND A,(Dir)' : '0011001',
    #'AND B,(Dir)' : '0011011',
    'AND(Dir)' : '0011011',


    'OR A,B' : '0011100',
    'OR B,A' : '0011101',
    'OR A,Lit' : '0011110',
    #'OR B,Lit' : '0000000',
    'OR A,(Dir)' : '0011111',
    #'OR B,(Dir)' : '0000000',
    'OR (Dir)' : '0100001',

    'NOT A' : '0100010',
    'NOT B,A' : '0100011',
    #'NOT (Dir),A' : '0000000',

    'XOR A,B' : '0101000',
    'XOR B,A' : '0101001',
    'XOR A,Lit' : '0101010',
    #'XOR B,Lit' : '0000000',
    'XOR A,(Dir)' : '0101011',
    #'XOR B,(Dir)' : '0000000',
    'XOR (Dir)' : '0101101',

    'SHL A' : '0101110',
    'SHL B,A' : '0101111',
    'SHL (Dir),A' : '0110011',

    'SHR A' : '0110100',
    'SHR B,A' : '0110101',
    'SHR (Dir),A' : '0111001',

    #'INC A' : '0000000',
    'INC B' : '0111010',
    #'INC (Dir)' : '0000000',

    #'DEC A' : '0000000',

    'CMP A,B' : '0111011',
    'CMP A,Lit' : '0111100',
    #'CMP A,(Dir)' : '0000000',

    'JMP Ins' : '0111101',
    'JEQ Ins' : '0111110',
    'JNE Ins' : '0111111',
    'JGT Ins' : '1000000',
    'JGE Ins' : '1000001',
    'JLT Ins' : '1000010',
    'JLE Ins' : '1000011',
    'JCR Ins' : '1000100'
    #'NOP' : '000000'
}
print(lista)
instrucciones = {}


label = {}
'''for i in range(len(lista)):
        instrucciones[lista[i]]=Rellena(sumBin(i))
        ##print(lista[i]+"="+str(i))
#print(instrucciones)'''


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


variables = {} #Diccionario de variables a direccion en ram
def variablesDataRAM(var):
    var = var.strip()
    [nombre,valor] = var.split(" ")
    variables[nombre] = len(variables.keys())+1
    return variables

def variablesIns(var):
    var = var.strip()
    [nombre,valor] = var.split(" ")
    variablesDataRAM(var)
    if(valor[-1]!="b"):
        if(valor[-1]!="h"):
            valor=sumBin(int(valor))
        else:
            valor = hexaBin(valor[:-1])
    else:
        valor = valor[:-1]
    return ["MOV A,"+str(valor),"MOV "+str(variables[nombre])+",A"]



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
                        #label[Nombre].append(w[0].strip())
                        l=w[0].strip()
                        label[Nombre].append(l.split(" ")[0]+" "+"".join(l.split(" ")[1:]))
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


instrucciones2 = {} #Dict con data con instrucciones
def dataFinal(diccionario):
    for nombre2 in diccionario:
        if(nombre2 != "DATA"):
            instrucciones2[nombre2] = label[nombre2]
        else:
            instrucciones2["DATA"] = []

    for nombre in diccionario["DATA"]:
        for ins in variablesIns(nombre):
            instrucciones2["DATA"].append(ins)


def instr_binario(inst):
    inst = inst.split(" ")[1]
    lista_inst = inst.split(',')
    if lista_inst[0][0] == '(':
        print('es direccion')
    if lista_inst[1][0] == '(':
        if not esint(lista_inst[1][1]):
            print('es variable')
        else:
            if lista_inst[1][-2] == 'b':
                print('es variable binario')
            elif lista_inst[1][-2] == 'h':
                print('es variable hexa')
            else:
                print('es decimal')


Leer('Ejemplo5.txt',label)

dataFinal(label)
print (instrucciones2)


#print(label)
lista_instrucciones(label,suma_instrucciones(label,orden_labels))

#print(l)


