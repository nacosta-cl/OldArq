from tkinter import *
from tkinter import filedialog
import random
root = Tk()


def sumBin(dec):
    if(dec[-1]=="d"):
        dec = int(dec[:-1])
    else:
        dec = int(dec)
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
    'NOP' : '0000000',
    'MOV B,A' : '0000001',
    'MOV A,Lit' : '0000010',
    'MOV B,Lit' : '0000011',
    'MOV A,(Dir)' : '0000100',
    'MOV B,(Dir)' : '0000101',
    'MOV (Dir),A' : '0000110',
    'MOV (Dir),B' : '0000111',
    'MOV A,(B)' : '0001000',
    'MOV B,(B)' : '0001001',
    'MOV (B),A' : '0001010',
    'ADD A,B' : '0001011',
    'ADD B,A' : '0001100',
    'ADD A,Lit' : '0001101',
    'ADD A,(Dir)' : '0001110',
    'ADD A,(B)' : '0001111',
    'ADD (Dir)' : '0010000',
    'SUB A,B' : '0010001',
    'SUB B,A' : '0010010',
    'SUB A,(Dir)' : '0010011',
    'SUB A,(B)' : '0010100',
    'SUB (Dir)' : '0010101',
    'AND A,B' : '0010110',
    'AND B,A' : '0010111',
    'AND A,Lit' : '0011000',
    'AND A,(Dir)' : '0011001',
    'AND A,(B)' : '0011010',
    'AND (Dir)' : '0011011',
    'OR A,B' : '0011100',
    'OR B,A' : '0011101',
    'OR A,Lit' : '0011110',
    'OR A,(Dir)' : '0011111',
    'OR A,(B)' : '0100000',
    'OR (Dir)' : '0100001',
    'NOT A' : '0100010',
    'NOT B,A' : '0100011',
    '0' : '0100100 ',
    '0' : '0100101 ',
    '0' : '0100110 ',
    '0' : '0100111 ',
    'XOR A,B' : '0101000',
    'XOR B,A' : '0101001',
    'XOR A,Lit' : '0101010',
    'XOR A,(Dir)' : '0101011',
    'XOR A,(B)' : '0101100',
    'XOR (Dir)' : '0101101',
    'SHL A' : '0101110',
    'SHL B,A' : '0101111',
    '0' : '0110000',
    '0' : '0110001',
    '0' : '0110010',
    'SHL (Dir),A' : '0110011',
    'SHR A' : '0110100',
    'SHR B,A' : '0110101',
    '0' : '0110110',
    '0' : '0110111',
    '0' : '0111000',
    'SHR (Dir),A' : '0111001',
    'INC (B)' : '0111010',
    'CMP A,B' : '0111011',
    'CMP A,Lit' : '0111100',
    'JMP Ins' : '0111101',
    '0' : '0111110',
    '0' : '0111111',
    'ADD B,Lit' : '1000000',
    'ADD B,(Dir)' : '1000001',
    'SUB A,Lit' : '1000010',
    'SUB B,Lit' : '1000011',
    'SUB B,(Dir)' : '1000100',
    'AND B,Lit' : '1000101',
    'RET' : '1000110',
    'OR B,Lit' : '1000111',
    'OR B,(Dir)' : '1001000',
    'XOR B,Lit' : '1001001',
    'XOR B,(Dir)' : '1001010',
    'INC (Dir)' : '1001011',
    'CMP A,(Dir)' : '1001100',
    'JEQ Ins' : '1001101',
    'JNE Ins' : '1001110',
    'JGT Ins' : '1001111',
    'JLT Ins' : '1010000',
    'JGE Ins' : '1010001',
    'JLE Ins' : '1010010',
    'JCR Ins' : '1010011',
    'NOT (Dir),A' : '1010100',
    'NOT (B),A' : '1010101',
    'AND B,(Dir)' : '1010110',
    '0' : '1010111',
    'ADD B,(B)' : '1011000',
    '0' : '1011001',
    'SUB B,(B)' : '1011010',
    'AND B,(B)' : '1011011',
    'OR B,(B)' : '1011100',
    'CALL Dir' : '1011101',
    'PUSH A' : '1011110',
    'PUSH B' : '1011111',
    'POP A' : '1100000',
    'POP B' : '1100001',
    'XOR B,(B)' : '1100010',
    'SHL (B),A' : '1100011',
    'SHR (B),A' : '1100100',
    '0' : '1100101',
    '0' : '1100110',
    'CMP A,(B)' : '1100111',
    'IN A,Lit' : '1101000',
    'IN B,Lit' : '1101001',
    'IN (B),Lit' : '1101010',
    'DEC SP' : '1101011',
    'INC SP' : '1101100',
    '0' : '1101101',
    'INC B' : '1101110',
    'OUT A,B' : '1101111',
    'OUT A,(B)' : '1110000',
    'OUT A,(Dir)' : '1110001',
    'OUT A,Lit' : '1110010',
    '0' : '1110011',
    '0' : '1110100',
    '0' : '1110101',
    '0' : '1110110',
    '0' : '1110111',
    '0' : '1111000',
    '0' : '1111001',
    '0' : '1111010',
    '0' : '1111011',
    '0' : '1111100',
    '0' : '1111101',
    'MOV A,B' : '1111110',
    '0' : '1111111'
}
#print(lista)
instrucciones = {}


label = {}
#labelVar = []
'''for i in range(len(lista)):
        instrucciones[lista[i]]=Rellena(sumBin(i))
        ##print(lista[i]+"="+str(i))
#print(instrucciones)'''


orden_labels =[]
l = []

'''def leer(Archivo,label):
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
    ar.close()'''


variables = {} #Diccionario de variables a direccion en ram
def variablesDataRAM(nombre):
    variables[nombre] = len(variables.keys())
    return len(variables.keys()) - 1

def variablesIns(var,valores):
    n = 0
    comandos = []
    for i in valores:
        #print(i)
        if(i[-1]!="b"):
            if(i[-1]!="h"):
                i = sumBin(str(i))
            else:
                i = hexaBin(i[:-1])
        else:
            i = i[:-1]
        dirram = variablesDataRAM(var+str(sumBin(str(n)))) #Agregamos el vector/variable al dict de direccion en ram
        comandos.append("MOV B,"+str(i)+"b")
        comandos.append("MOV ("+str(sumBin(str(dirram)))+"b),B")
        n += 1
    return comandos

'''def variablesIns(var):
    var = var.strip()
    [nombre,valor] = var.split(" ")
    variablesDataRAM(var)
    if(valor[-1]!="b"):
        if(valor[-1]!="h"):
            valor=sumBin(str(valor))
        else:
            valor = hexaBin(valor[:-1])
    else:
        valor = valor[:-1]
    return ["MOV A,"+str(valor)+"b","MOV ("+str(variables[nombre])+"),A"] #transforma data a instruciones
'''

def contador(Linea):
    conta = 0
    for i in Linea:
        if i == ' ':
            conta+=1
        else:
            break
    return conta


'''def Leer(Archivo, label):
    Ar = open(Archivo,'r',encoding="latin-1")
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
        #labelVar.append(Nombre+" 0") #Agregamos cada label como una var de valor 0

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
                if w[0]!= '\n':
                    if(':' not  in w[0]):
                        cc = contador(w[0])

                        if cc == primeras_lineas[cccc]:
                            #label[Nombre].append(w[0].strip())
                            l=w[0].strip()
                            ins = l.split(" ")[0]+" "+"".join(l.split(" ")[1:])
                            if(ins=="DEC A"):
                                ins = "SUB A,1"
                            if(ins=="INC A"):
                                ins = "ADD A,1"
                            label[Nombre].append(ins)
                        else:
                            label["CODE"].append(w[0].strip())
                    else:
                        break
    Ar.close()'''

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
            instrucciones2[nombre2] = diccionario[nombre2]
        else:
            instrucciones2["DATA"] = []

    for item in diccionario["DATA"]:
        ins = variablesIns(item[0],item[1])
        for instruccion in ins:
            instrucciones2["DATA"].append(instruccion)

    instrucciones2["DATA"].append("MOV B,0") #Limpia registro A despues de las variables

    '''for labelNombre in labelVar:
        for labelIns in variablesIns(labelNombre):
            instrucciones2["DATA"].append(labelIns)'''

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

    elif lista_inst[1][-1] =='h':
        return('instruccion')
    else:
        return("instruccion")

def insToType(valor):
    if not valor[0] == '(': #tipo XOR (var)
        return 0 #return('instruccion')
    elif not esint(valor[1]): #valor var
        if(not valor[-2] == 'h'):
            return 1 #return('variable')
        else:
            return 3 #return('hexa')
    else:
        if valor[-2] == 'b': #valor 10b
            return 2 #return('bin')
        elif valor[-2] == 'h': #valor 10h
            return 3 #return('hexa')
        else:
            return 4 #return('decimal') #valor 10

def tipoPalabra(valor):
    if not esint(valor[0]): #valor var
        if(not valor[-1] == 'h'):
            return 1 #return('variable')
        else:
            return 3 #return('hexa')
    else:
        if valor[-1] == 'b': #valor 10b
            return 2 #return('bin')
        elif valor[-1] == 'h': #valor 10h
            return 3 #return('hexa')
        else:
            return 4 #return('decimal') #valor 10
###cambie esto
def tipoVar(valor):
    if(valor[-1]=="b"):
        return 1 #es binario
    elif(valor[-1]=="h"):
        return 2 #es hexa
    elif(not esint(valor[0])):
        return 0 #es variable
    else:
        return 3 #es dec

def transformarBin(valor):
    if(tipoVar(valor)==1): #lit binario
        return valor[:-1] #lit en binario sin "b"
    elif(tipoVar(valor)==2): #lit hexa
        return hexaBin(valor[:-1]) #lit en bin transformado desde hexa
    elif(tipoVar(valor)==3): #lit en dec
        return sumBin(str(valor)) #lit en bin transformado desde

def ins_generica(ins):
    valor=" " #por si aparece 'NOP'
    izqcoma=" "
    dercoma=" "
    nombre,valor=ins.split(" ")
    nombre = nombre.strip()
    nombre = nombre.replace("\t","")
    valor = valor.strip()
    retorna = ""
    if(nombre!=""):
       # print(ins)
        if(valor.count(",")>0): #del tipo MOV x,y
            izqcoma,dercoma=valor.split(",") #lado izq y lado der de la coma
            if(instr_binario(valor)=="instruccion"): #tipo MOV A,Lit || MOV A,B
                if(tipoVar(izqcoma)!=0): #tipo MOV Lit,A
                    retorna = str(nombre)+" Lit,"+str(dercoma)
                    izqcoma = transformarBin(izqcoma)
                elif(tipoVar(dercoma)!=0): #tipo MOV A,Lit
                    retorna = str(nombre)+" "+str(izqcoma)+",Lit"
                    dercoma = transformarBin(dercoma)
                else:
                    if(izqcoma != "A" and izqcoma != "B"):
                        retorna = str(nombre)+" Lit,"+str(dercoma)
                        izqcoma = str(transformarBin(str(variables[str(izqcoma)+str(0)])))
                    elif(dercoma != "A" and dercoma != "B"):
                        retorna = str(nombre)+" "+str(izqcoma)+",Lit"
                        dercoma = str(transformarBin(str(variables[str(dercoma)+str(0)])))
                    else:
                        retorna = str(nombre)+" "+str(izqcoma)+","+str(dercoma)
            elif(instr_binario(valor)=="variable izq"): #tipo MOV (c),A
                try:
                    retorna = str(nombre)+" (Dir),"+str(dercoma)
                    izqcoma = "("+str(transformarBin(str(variables[izqcoma[1:-1]+"0"])))+")" #transforma var a lugar en ram (binario)
                except:
                    if(tipoPalabra(dercoma)!=1):
                        retorna = str(nombre)+" "+str(izqcoma)+",Lit"
                        if(esint(str(transformarBin(dercoma)[:-1]))):
                            dercoma = str(transformarBin(dercoma))
                        else:
                            dercoma = str(transformarBin(str(variables[dercoma[1:-1]+"0"])))
                    else:
                        retorna = str(nombre)+" "+str(izqcoma)+","+str(dercoma)
                        izqcoma = " "+str(izqcoma)
            elif(instr_binario(valor)=="variable der"): #tipo MOV A,(c)
                try:
                    retorna = str(nombre)+" "+str(izqcoma)+",(Dir)"
                    dercoma = "("+str(transformarBin(str(variables[dercoma[1:-1]+"0"])))+")" #transforma var a lugar en ram (binario)
                except: #tipo MOV A,(B)
                    retorna = str(nombre)+" "+str(izqcoma)+","+str(dercoma)
                    dercoma = " "+str(dercoma)
            elif(instr_binario(valor)=="bin izq" or instr_binario(valor)=="hexa izq" or instr_binario(valor)=="decimal izq"): #tipo MOV (6),A
                try:
                    retorna = str(nombre)+" (Dir),"+str(dercoma)
                    izqcoma = "("+str(transformarBin(izqcoma[1:-1]))+")"
                except:
                    retorna = str(nombre)+" "+str(izqcoma)+","+str(dercoma)
            elif(instr_binario(valor)=="bin der" or instr_binario(valor)=="hexa der" or instr_binario(valor)=="decimal der"): #tipo MOV A,(6)
                try:
                    retorna = str(nombre)+" "+str(izqcoma)+",(Dir)"
                    dercoma = "("+str(transformarBin(dercoma[1:-1]))+")"
                except:
                    retorna = str(nombre)+" "+str(izqcoma)+","+str(dercoma)
            '''print(valor)
            print(instr_binario(valor))
            print(izqcoma)
            print(dercoma)'''
        else: #del tipo JMP abc || DEC A
            dercoma = " "
            '''if(valor.count("(")>0): #del tipo ICL (Dir)
                retorna = str(nombre)+" (Dir)"
                if not esint(valor[1]): #tipo
                    izqcoma = valor
                else:
                    izqcoma = "("+transformarBin(valor[1:-1])+")"
            else:'''
            if(nombre=="NOP" or nombre=="RET"):
                retorna = str(nombre)
                izqcoma = " "
            elif(nombre=="CALL"):
                retorna = str(nombre)+" Dir"
                izqcoma = "("+str(transformarBin(str(countIns[valor])))+")"
                dercoma = str(valor)
            elif(nombre[0]!="J"): #Todos los que no comienzan con J
                #retorna = str(nombre)+" "+str(valor)
                if(insToType(valor)==0): #instruccion: tipo INC A
                    retorna = str(nombre)+" "+str(valor)
                    izqcoma = str(valor)
                elif(insToType(valor)==1): #variable: tipo INC (var)
                    if(str(valor) == "(B)" or str(valor) == "B"):
                        retorna = str(nombre)+" "+str(valor)
                        izqcoma = str(valor)
                    else:
                        retorna = str(nombre)+" (Dir)"
                        izqcoma = "("+str(transformarBin(str(variables[valor[1:-1]+"0"])))+")"
                        dercoma = str(valor)
                else:
                    #retorna = str(nombre)+" Lit"
                    retorna = str(nombre)+" (Dir)" #Deberia ser Lit, pero no existe, y en ejemplo 6 se cae
                    izqcoma = "("+str(transformarBin(str(valor[1:-1])))+")"
                    dercoma = str(valor)
            else: #JMP etc
                retorna = str(nombre)+" Ins"
                izqcoma = "("+str(transformarBin(str(countIns[valor])))+")"
                dercoma = valor
                #print(valor)

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
listaInsTxt = []
countIns = {}
def dataFinalBin(dict):
    opcode = 0
    literal = 0
    count = 0 #num de linea q estamos
    ###cambie esto!!! #no era lo mismo? pero bueno lo dejo asi
    for nombre in orden_labels:
        countIns[nombre] = count
        funcion = dict[nombre]
        for ins in funcion:
            count+=1


    for nombre in orden_labels:
        #print(nombre)
        #countIns[nombre] = count
        #print(countIns)
        funcion = dict[nombre] #data,code,end,etc
        for ins in funcion: #cada instruccion de cada funcion
            if(ins_generica(ins)):
                print(ins_generica(ins))
                insgen,izq,der=ins_generica(ins)
                if(esint(izq)):
                    literal=Rellena(str(izq),16)
                elif(esint(der)):
                    literal=Rellena(str(der),16)
                elif(izq[0]=="(" and izq != "(B)"): #direccion
                    literal=Rellena(str(izq[1:-1]),16)
                elif(der[0]=="(" and der != "(B)"): #direccion
                    literal=Rellena(str(der[1:-1]),16)
                else:
                    literal=Rellena("",16)
                opcode=Rellena(str(lista[insgen]),17)
                #print(lista)
                #print(str(lista[insgen]))
                #print(opcode)
                #print(var)
                print(str(opcode)+str(literal))
                listaInsBin.append(str(opcode)+str(literal))
                listaInsTxt.append(ins_generica(ins))
                #count += 1


def rellenaLista(lista,N):
    for i in range(len(lista), N):
        lista.append(Rellena("",33))

def outputTXT(file):
    l = {}
    f = open(file,'w+')

    ##Info
    f.write("-- Variable | Direccion (dec) | Direccion (bin)\n")
    for variable in variables:
        f.write("-- "+str(variable)+" | "+str(variables[variable])+" | "+str(sumBin(str(variables[variable])))+"\n")
    f.write("---\n")
    for linea in countIns:
        f.write("-- "+str(linea)+" | "+str(countIns[linea])+" | "+str(sumBin(str(countIns[linea])))+"\n")
        l[countIns[linea]] = str(linea)
    f.write("\n")
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
    for i in range(len(listaInsBin)):
        if((i+1) != len(listaInsBin)):
            f.write(str('\t"'+listaInsBin[i]+'",'))
        else: #sin coma al final
            f.write(str('\t"'+listaInsBin[i]+'"'))

        try:
            f.write(str(" -- "+str(i)+": "+listaInsTxt[i][0]+" | "+listaInsTxt[i][1]+" | "+listaInsTxt[i][2]))
            try:
                f.write(str("\t--> "+str(l[i])+"\n"))
            except:
                f.write("\n")
        except:
            f.write("\n")
    f.write(");\n")
    f.write("begin\n")
    f.write("\n")
    f.write("\tdataout <= memory(to_integer(unsigned(address)));\n")
    f.write("\n")
    f.write("end Behavioral;")

    f.close()

def Leer_Archivo(Archivo,label):
    archivo = open(Archivo,'r',encoding='latin-1')
    Linea= archivo.readline()
    Lineas = [] ## las Lineas que nos sirver
    Espacios_Label=[] ## espacios o tabulaciones de los Labels
    contador_label = -1 ## cuantos labels hay
    vector = []


    while Linea:
        temp = Linea.split('//')
        Linea = temp[0] # si la linea tiene comentarios no los pesacamos
        if Linea.strip():
            Lineas.append(Linea) ## agregamos las lineas que no son // y que no son espacion es blanco
        Linea = archivo.readline()

    for i in range(len(Lineas)):
        Linea_actual = Lineas[i]

        if Linea_actual.strip():
            #print(Linea_actual)
            if ':' in Linea_actual:
                Auxiliar = Linea_actual.split(':')
                Nombre_Label = Auxiliar[0].strip()#Nombre label
                label[Nombre_Label] = []
                orden_labels.append(Nombre_Label)
                contador_label+=1

                try:
                    if':' in Lineas[i+1]:
                        Espacios_Label.append(0)#si el label no tiene ninguna instruccion le ponemos 0
                except:
                    continue
            else:
                Linea_anterior = Lineas[i-1]# linea anterior a la liena en la que vamos
                Espacios_linea_actual = contador(Linea_actual) #espacios o tabulaciones de la linea actual
                Linea_actual = Linea_actual.strip()
                if(len(Linea_actual.split(" ")) >= 2):
                    Linea_actual = Linea_actual.split(" ")[0]+" "+" ".join(Linea_actual.split(" ")[1:])
                else:
                    Linea_actual = Linea_actual.split(" ")[0]+" "+"".join(Linea_actual.split(" ")[1:])
                Linea_actual = Linea_actual.replace('\r',' ') #Porsiacaso
                #Linea_actual = Linea_actual.replace(' ','\t')
                Linea_actual = Linea_actual.replace('\t',' ',1)
                Linea_actual = Linea_actual.replace('\t','') # la dejamos con un solo espacio MOV A,B

                if ':' in Linea_anterior:
                    Espacios_Label.append(Espacios_linea_actual)#Primera linea de cada label, agregamos sus espacios en blaco al comienzo
                if Espacios_linea_actual >= Espacios_Label[contador_label]: # si la linea en la que vamos tiene igual o mas espacios al comienzo que la linea anterior es porque
                    #pertenence al mismo label, sino es de CODE
                    LabelName = orden_labels[contador_label]
                    if LabelName == "DATA":
                        palabra = Linea_actual.split(" ")
                        palabra = [palabra[0], " ".join(palabra[1:])]
                        palabra[1] = palabra[1].strip()


                        if len(palabra[1]) > 0:
                            vector = []
                            vector.append(palabra[0])
                            vector.append([])

                            if palabra[1][0] == str("'") or palabra[1][0] == str('"'):
                                #print(palabra[1][0])
                                if len(palabra[1][1:-1])>1:
                                    auxiliar = []
                                    for i in palabra[1][1:-1]:
                                        #print(ord(i)) #ord transforma a ascii
                                        #auxiliar.append(i)
                                        auxiliar.append(sumBin(str(ord(i))+"d")+"b")
                                    auxiliar.append('0b')
                                    vector[1] = (auxiliar)
                                else:
                                    #vector[1].append(str(palabra[1][1:-1]))
                                    vector[1].append(sumBin(str(ord(palabra[1][1:-1]))+"d")+"b")
                            else:
                                vector[1].append(palabra[1])


                            label[LabelName].append(vector)
                            #print(LabelName)
                            #print(vector)

                        else:

                             vector[1].append(palabra[0])

                    else:

                        try: #Cambia los INC por ADD, DEC por SUB || TRY por si aparece "nop"
                            lSpit = Linea_actual.split(" ")
                            if(',' in lSpit[1]):
                                variable = lSpit[1].split(",", 1) #por si el char es ","
                                if((variable[1][0]=="'" and variable[1][-1]=="'") or (variable[1][0]=='"' and variable[1][-1]=='"')):
                                    #print(variable)
                                    aux = sumBin(str(ord(variable[1][1:-1]))+"d")+"b"
                                    #print(aux)
                                    cadena = str(lSpit[0]+" "+variable[0]+','+ str(aux))
                                    #print(cadena)
                                    Linea_actual = cadena
                            if(lSpit[0] == "INC"):
                                if(lSpit[1] == "A"):
                                    Linea_actual = "ADD "+lSpit[1]
                                    Linea_actual += ",1"
                            if(lSpit[0] == "DEC"):
                                if(lSpit[1] == "A"):
                                    Linea_actual = "SUB "+lSpit[1]
                                    Linea_actual += ",1"
                            if(lSpit[0] == "POP" or lSpit[0] == "RET"):
                                label[LabelName].append("INC SP") #Inventada
                            '''if(lSpit[0] == "PUSH"):
                                label[LabelName].append("PUSH "+lSpit[1])
                                Linea_actual = "DEC (SP),1" #Inventada'''
                        except:
                            continue #Hace nada

                        label[LabelName].append(Linea_actual)
                else:

                    r = random.randint(0,100000)
                    extra = str(r)
                    label[extra]=[]

                    try: #Cambia los INC por ADD, DEC por SUB || TRY por si aparece "nop"
                        lSpit = Linea_actual.split(" ")
                        if(',' in lSpit[1]):
                            variable = lSpit[1].split(",", 1) #por si el char es ","
                            if((variable[1][0]=="'" and variable[1][-1]=="'") or (variable[1][0]=='"' and variable[1][-1]=='"')):
                                #print(variable)
                                aux = sumBin(str(ord(variable[1][1:-1]))+"d")+"b"
                                #print(aux)
                                cadena = str(lSpit[0]+" "+variable[0]+','+ str(aux))
                                #print(cadena)
                                Linea_actual = cadena
                        if(lSpit[0] == "INC"):
                            if(lSpit[1] == "A"):
                                Linea_actual = "ADD "+lSpit[1]
                                Linea_actual += ",1"
                        if(lSpit[0] == "DEC"):
                            if(lSpit[1] == "A"):
                                Linea_actual = "SUB "+lSpit[1]
                                Linea_actual += ",1"
                        if(lSpit[0] == "POP" or lSpit[0] == "RET"):
                            label[extra].append("INC SP") #Inventada
                        '''if(lSpit[0] == "PUSH"):
                            label[extra].append("PUSH "+lSpit[1])
                            Linea_actual = "DEC (SP),1" #Inventada'''
                    except:
                        continue #Hace nada

                    label[extra].append(Linea_actual)
                    orden_labels.append(extra)
                    contador_label += 1
                    Espacios_Label.append(0)
    #print(label)
    archivo.close()

root.fileopenname = filedialog.askopenfilename(initialdir = "./",title = "Escoge input")
Leer_Archivo(root.fileopenname,label)
#Leer_Archivo('test.txt',label)



dataFinal(label) #Calcula los comandos en texto

dataFinalBin(instrucciones2) #transforma instrucciones a bin y agrega en lista listaInsBin

rellenaLista(listaInsBin,4096) #rellena la lista listaInsBin con 4096 elementos

root.filesavename = filedialog.asksaveasfilename(initialdir = "./", title = "Escoge output")
outputTXT(root.filesavename)
#outputTXT('output.txt')




#print(listaInsBin)
#print(variables)


lista_instrucciones(label,suma_instrucciones(label,orden_labels))

#print(l)

