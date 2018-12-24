DIR	= Organizacija_fudbalskog_kluba_ProjBP
CC = gcc
PROGS	= src/main.c src/db_functions.c
OUTPUT = org_fudbalskog_kluba
CFLAGS	= -g -Wall `mysql_config --cflags --libs`

.PHONY: all create trigger insert beauty dist progs

all: create trigger insert progs

progs:
	$(CC) -o $(OUTPUT) $(PROGS) $(CFLAGS)

create:
	mysql -u jovan < sql/create.sql

trigger:
	mysql -u jovan < sql/triggers.sql

insert:
	mysql -u jovan < sql/insert.sql
	
beauty:
	-indent $(PROGS)

clean:
	-rm -f *~ $(OUTPUT)
	
dist: beauty clean
	-tar -zcvf $(DIR).tar.gz $(DIR)