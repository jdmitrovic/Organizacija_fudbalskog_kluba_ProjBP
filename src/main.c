#include <stdio.h>
#include <stdlib.h>
#include <mysql/mysql.h>

typedef struct {
	MYSQL *connection;
	MYSQL_RES *result;
	MYSQL_ROW row;
	MYSQL_FIELD *column;
	char query[1024];
} MySqlStruct;

int main(int argc, char** argv)
{
	MySqlStruct s;
	s.connection = mysql_init(NULL);

	if (mysql_real_connect(s.connection, "localhost", "jovan", "", "org_klub", 0, NULL, 0) == NULL)
    	printf ("Konektovanje na bazu nije uspelo!\n");

    mysql_close(s.connection);
	exit(EXIT_SUCCESS);
}