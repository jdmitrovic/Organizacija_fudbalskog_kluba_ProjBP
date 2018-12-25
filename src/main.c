#include <stdio.h>
#include <stdlib.h>
#include "db_header.h"

int main(int argc, char** argv)
{
	MySqlStruct s;
	s.connection = mysql_init(NULL);

	if (mysql_real_connect(s.connection, "localhost", "jovan", "", "org_klub", 0, NULL, 0) == NULL)
		printf ("Konektovanje na bazu nije uspelo!\n");


	int running_status = 1;
	while(running_status) {
		printf("%s\n%s\n%s\n%s\n%s\n%s\n%s\n", 
			"Izaberite opciju:",
			"1. Ispisi sve klubove u datoj ligi",
			"2. Ispisi sve filijalne odnose",
			"3. Promovisi/relegiraj klub",
			"4. Dodaj novog fudbalera u bazu",
			"5. Dodaj novu sezonu fudbalera",
			"0. Izadji iz programa" 
		);

		int opcija;
		scanf("%d", &opcija);

		switch(opcija) {
			case 1:
				svi_klubovi(&s);
				break;
			case 2:
				sve_filijale(&s);	
				break;
			case 3:
				menjanje_lige(&s);
				break;
			case 4:
				dodaj_fudbalera(&s);
				break;
			case 5:
				// dodaj_sezonu_fudbalera(&s);
				break;
			case 0:
				running_status = 0;
				break;
			default:
				printf("Pogresna opcija\n");
				break;
		}

		printf("\n");
	}

	mysql_close(s.connection);
	exit(EXIT_SUCCESS);
}