#include "db_header.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void svi_klubovi(MySqlStruct* s)
{
	printf("Unesite ime lige\n");
	size_t bufsize = 128;
	char* liga = (char*)malloc(bufsize * sizeof(char));
	
	if (liga == NULL) {
		printf("Malloc failed\n");
		exit(EXIT_FAILURE);
	}

	getchar();
	size_t chars_read = getline(&liga, &bufsize, stdin);
	liga[chars_read - 1] = '\0';

	sprintf(s->query, 
	"select id_kluba, ime_kluba from Fudbalski_klub f where f.liga like '%s'", 
	liga);

	if(mysql_query(s->connection, s->query) != 0)
		exit(EXIT_FAILURE);

	s->result = mysql_use_result(s->connection);
	s->column = mysql_fetch_field(s->result);
	printf("%s\t%s\n", s->column[0].name, s->column[1].name);

	while((s->row = mysql_fetch_row(s->result)) != 0)
		printf("%s\t%s\n", s->row[0], s->row[1]);

	free(liga);
	mysql_free_result(s->result);
}

void sve_filijale(MySqlStruct* s)
{
	sprintf(s->query, "select f1.ime_kluba, f2.ime_kluba from Filijala f "
					  "join Fudbalski_klub f1 on f1.id_kluba = f.Fudbalski_klub_id_kluba_senior "
					  "join Fudbalski_klub f2 on f2.id_kluba = f.Fudbalski_klub_id_kluba_filijala");

	if(mysql_query(s->connection, s->query) != 0)
		exit(EXIT_FAILURE);

	s->result = mysql_use_result(s->connection);
	s->column = mysql_fetch_field(s->result);
	printf("%s\t%s\n", s->column[0].name, s->column[1].name);

	while((s->row = mysql_fetch_row(s->result)) != 0)
		printf("%s\t%s\n", s->row[0], s->row[1]);

	mysql_free_result(s->result);
}