from cx_Freeze import setup, Executable


setup(
    name = "Compilador" ,
    version = "1" ,
    description = "Compilador" ,
    executables = [Executable("4096.py")]  ,
)

'''
Hay que instalar cx_freeze y ejecutar en terminal
	C:\Python34\python setup.py build
Donde
	C:\Python34\python -> directorio donde esta python
	setup.py -> script
'''