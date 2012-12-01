PROJECT=ryujin_js
SRC=$(wildcard ./lib/*.coffee)
OBJDIR=./lib
CFLAG:=-bc

all :$(PROJECT)

$(PROJECT) :
	coffee $(CFLAG) $(SRC)