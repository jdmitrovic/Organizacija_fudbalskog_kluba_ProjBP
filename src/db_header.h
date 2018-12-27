#ifndef DBHEADER_H
#define DBHEADER_H

#include <mysql/mysql.h>

#define MAX_QUERY_LENGTH 1024

typedef struct {
	MYSQL *connection;
	MYSQL_RES *result;
	MYSQL_ROW row;
	MYSQL_FIELD *column;
	char query[MAX_QUERY_LENGTH];
} MySqlStruct;

void svi_klubovi(MySqlStruct* s);
void sve_filijale(MySqlStruct* s);
void menjanje_lige(MySqlStruct* s);
void dodaj_fudbalera(MySqlStruct* s);
void dodaj_sezonu_fudbalera(MySqlStruct* s);
void svi_fudbaleri(MySqlStruct* s);

void error_fatal(char *format, ...);

#endif