from tkinter import *
from tkinter import filedialog
root = Tk()



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
    N=N.strip()
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
    'ADD B,Lit' : '1111111', ##temporal
    'ADD A,(Dir)' : '0001110',
    'ADD B,(Dir)' : '1111111', ##temporal
    'ADD (Dir)' : '0010000',

    'SUB A,B' : '0010001',
    'SUB B,A' : '0010010',
    'SUB A,Lit' : '1111111', ##temporal
    'SUB B,Lit' : '1111111', ##temporal
    'SUB A,(Dir)' : '0010011',
    'SUB B,(Dir)' : '1111111', ##temporal
    'SUB (Dir)' : '0010101',

    'AND A,B' : '0010110',
    'AND B,A' : '0010111',
    'AND A, Lit' : '0011000',
    'AND B, Lit' : '1111111', ##temporal
    'AND A,(Dir)' : '0011001',
    'AND B,(Dir)' : '1111111', ##temporal
    'AND(Dir)' : '0011011',


    'OR A,B' : '0011100',
    'OR B,A' : '0011101',
    'OR A,Lit' : '0011110',
    'OR B,Lit' : '1111111', ##temporal
    'OR A,(Dir)' : '0011111',
    'OR B,(Dir)' : '1111111', ##temporal
    'OR (Dir)' : '0100001',

    'NOT A' : '0100010',
    'NOT B,A' : '0100011',
    'NOT (Dir),A' : '1111111', ##temporal

    'XOR A,B' : '0101000',
    'XOR B,A' : '0101001',
    'XOR A,Lit' : '0101010',
    'XOR B,Lit' : '1111111', ##temporal
    'XOR A,(Dir)' : '0101011',
    'XOR B,(Dir)' : '1111111', ##temporal
    'XOR (Dir)' : '0101101',

    'SHL A' : '0101110',
    'SHL B,A' : '0101111',
    'SHL (Dir),A' : '0110011',

    'SHR A' : '0110100',
    'SHR B,A' : '0110101',
    'SHR (Dir),A' : '0111001',

    'INC A' : '1111111', ##temporal
    'INC B' : '0111010',
    'INC (Dir)' : '1111111', ##temporal

    'DEC A' : '1111111', ##temporal

    'CMP A,B' : '0111011',
    'CMP A,Lit' : '0111100',
    'CMP A,(Dir)' : '1111111', ##temporal

    'JMP Ins' : '0111101',
    'JEQ Ins' : '0111110',
    'JNE Ins' : '0111111',
    'JGT Ins' : '1000000',
    'JGE Ins' : '1000001',
    'JLT Ins' : '1000010',
    'JLE Ins' : '1000011',
    'JCR Ins' : '1000100',
    'NOP' : '1111111' ##temporal
}
#print(lista)
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
    return ["MOV A,"+str(valor),"MOV ("+str(variables[nombre])+"),A"] #transforma data a instruciones



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

def esint(num):
    try:
        int(num)
        return True
    except:
        return False

def instr_binario(inst):
    #inst = inst.split(" ")[1]
    lista_inst = inst.split(',')
    if lista_inst[0][0] == '(': #tipo mov (a),A
        #print('es direccion')
        if not esint(lista_inst[0][1]): #tipo mov (c),A
                if(not lista_inst[0][-2] == 'h'):
                    return('variable izq')
                else:
                    return('hexa izq')
        else:
            if lista_inst[0][-2] == 'b': #tipo mov (10b),A
                return('bin izq')
            elif lista_inst[0][-2] == 'h': #tipo mov (10h),A
                return('hexa izq')
            else:
                return('decimal izq') #tipo mov (10),A
    elif lista_inst[1][0] == '(': #Analogo al anterior
        if not esint(lista_inst[1][1]):
            if(not lista_inst[1][-2] == 'h'):
                return('variable der')
            else:
                return('hexa der')
        else:
            if lista_inst[1][-2] == 'b':
                return('bin der')
            elif lista_inst[1][-2] == 'h':
                return('hexa der')
            else:
                return('decimal der')
    else:
        return("instruccion")


def tipoVar(valor):
    if(not esint(valor[0])):
        return 0 #es variable
    elif(valor[-1]=="b"):
        return 1 #es binario
    elif(valor[-1]=="h"):
        return 2 #es hexa
    else:
        return 3 #es dec

def transformarBin(valor):
    if(tipoVar(valor)==1): #lit binario
        return valor[:-1] #lit en binario sin "b"
    elif(tipoVar(valor)==2): #lit hexa
        return hexaBin(valor[:-1]) #lit en bin transformado desde hexa
    elif(tipoVar(valor)==3): #lit en dec
        return sumBin(int(valor)) #lit en bin transformado desde

def ins_generica(ins):
    valor="" #por si aparece 'NOP'
    izqcoma=""
    dercoma=""
    nombre,valor=ins.split(" ")
    retorna = ""
    if(nombre!=""):
        if(valor.count(",")>0): #del tipo MOV x,y
            izqcoma,dercoma=valor.split(",") #lado izq y lado der de la coma
            if(instr_binario(valor)=="instruccion"): #tipo MOV A,Lit || MOV A,B
                if(tipoVar(izqcoma)!=0): #tipo MOV Lit,A
                    retorna = str(nombre)+" Lit,"+str(dercoma)
                    izqcoma=transformarBin(izqcoma)
                elif(tipoVar(dercoma)!=0): #tipo MOV A,Lit
                    retorna = str(nombre)+" "+str(izqcoma)+",Lit"
                    dercoma=transformarBin(dercoma)
                else:
                    retorna = str(nombre)+" "+str(izqcoma)+","+str(dercoma)
            elif(instr_binario(valor)=="variable izq"): #tipo MOV (c),A
                retorna = str(nombre)+" (Dir),"+str(dercoma)
                izqcoma = "("+str(transformarBin(str(variables[izqcoma[1:-1]])))+")" #transforma var a lugar en ram (binario)
            elif(instr_binario(valor)=="variable der"): #tipo MOV A,(c)
                retorna = str(nombre)+" "+str(izqcoma)+",(Dir)"
                dercoma = "("+str(transformarBin(str(variables[dercoma[1:-1]])))+")" #transforma var a lugar en ram (binario)
            elif(instr_binario(valor)=="bin izq" or instr_binario(valor)=="hexa izq" or instr_binario(valor)=="decimal izq"): #tipo MOV (6),A
                retorna = str(nombre)+" (Dir),"+str(dercoma)
                izqcoma = "("+str(transformarBin(izqcoma[1:-1]))+")"
            elif(instr_binario(valor)=="bin der" or instr_binario(valor)=="hexa der" or instr_binario(valor)=="decimal der"): #tipo MOV A,(6)
                retorna = str(nombre)+" "+str(izqcoma)+",(Dir)"
                dercoma = "("+str(transformarBin(dercoma[1:-1]))+")"
            '''print(valor)
            print(instr_binario(valor))
            print(izqcoma)
            print(dercoma)'''
        else: #del tipo JMP abc || DEC A
            dercoma = " "
            if(valor.count("(")>0): #del tipo ICL (Dir)
                retorna = str(nombre)+" (Dir)"
                if not esint(valor[1]): #tipo
                    izqcoma = valor
                else:
                    izqcoma = "("+transformarBin(valor[1:-1])+")"
            else:
                if(nombre[0]!="J"): #Todos los que no comienzan con J
                    retorna = str(nombre)+" "+str(valor)
                    izqcoma = valor
                else: #JMP etc
                    retorna = str(nombre)+" Ins"
                    izqcoma = valor
        return [retorna,izqcoma,dercoma]
    else:
        return False
    '''print(izqcoma)
    print(dercoma)
    print(retorna)
    print()
    #print(nombre)
    #print(valor)'''

listaInsBin = []
def dataFinalBin(dict):
    opcode=0
    literal=0
    for nombre in orden_labels:
        funcion = dict[nombre] #data,code,end,etc
        for ins in funcion: #cada instruccion de cada funcion
            if(ins_generica(ins)):
                print(ins_generica(ins))
                insgen,izq,der=ins_generica(ins)
                if(izq[0]=="("): #direccion
                    literal=Rellena(str(izq[1:-1]),16)
                elif(der[0]=="("): #direccion
                    literal=Rellena(str(der[1:-1]),16)
                elif(esint(izq)):
                    literal=Rellena(str(izq),16)
                elif(esint(der)):
                    literal=Rellena(str(der),16)
                else:
                    literal=Rellena("",16)
                opcode=Rellena(str(lista[insgen]),17)
                #print(str(lista[insgen]))
                #print(opcode)
                #print(var)
                print(str(opcode)+str(literal))
                listaInsBin.append(str(opcode)+str(literal))

def rellenaLista(lista,N):
    for i in range(len(lista), N):
        lista.append(Rellena("",33))


def outputTXT(file):
    f = open(file,'w+')
    count = 0

    ##Info q vale pico
    f.write("library IEEE;\n")
    f.write("use IEEE.STD_LOGIC_1164.ALL;\n")
    f.write("use IEEE.STD_LOGIC_UNSIGNED.ALL;\n")
    f.write("USE IEEE.NUMERIC_STD.ALL;\n")
    f.write("\n")
    f.write("entity ROM is\n")
    f.write("\tPort (\n")
    f.write("\t\taddress   : in  std_logic_vector(11 downto 0);\n")
    f.write("\t\tdataout   : out std_logic_vector(32 downto 0)\n")
    f.write("\t\t);\n")
    f.write("end ROM;\n")
    f.write("\n")
    f.write("architecture Behavioral of ROM is\n")
    f.write("\n")
    f.write("type memory_array is array (0 to ((2 ** 12) - 1) ) of std_logic_vector (32 downto 0);\n")
    f.write("\n")
    f.write("signal memory : memory_array:= (\n")
    for i in listaInsBin:
        count+=1
        if(count != len(listaInsBin)):
            f.write(str('\t"'+i+'",\n'))
        else:
            f.write(str('\t"'+i+'"\n'))
    f.write(");\n")
    f.write("begin\n")
    f.write("\n")
    f.write("\tdataout <= memory(to_integer(unsigned(address)));\n")
    f.write("\n")
    f.write("end Behavioral;")

    f.close()

root.fileopenname = filedialog.askopenfilename(initialdir = "./",title = "Escoge input")
Leer(root.fileopenname,label)

dataFinal(label) #Calcula los comandos en texto

dataFinalBin(instrucciones2) #transforma instrucciones a bin y agrega en lista listaInsBin

rellenaLista(listaInsBin,4096) #rellena la lista listaInsBin con 4096 elementos

root.filesavename = filedialog.asksaveasfilename(initialdir = "./", title = "Escoge output")
outputTXT(root.filesavename)
#IMPORTATE: LISTA CON 4096 ES LA LISTA listaInsBin


#print(instrucciones2)

#print(listaInsBin)
#print(variables)

#print(label)
lista_instrucciones(label,suma_instrucciones(label,orden_labels))

#print(l)


