#include "db_header.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
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

	free(liga);

	if(mysql_query(s->connection, s->query) != 0)
		error_fatal("Greska u dohvatanju podataka iz tabele Fudbalski_klub!\n", mysql_error(s->connection));

	s->result = mysql_store_result(s->connection);
	if(s->result == NULL)
		error_fatal("mysql_store_result failed!\n", mysql_error(s->connection));

	if(mysql_num_rows(s->result) == 0) {
		printf("Ne postoje podaci o takvom klubu!\n");
		mysql_free_result(s->result);
		return;
	}

	s->column = mysql_fetch_field(s->result);
	printf("%-20s\t%s\n", s->column[0].name, s->column[1].name);

	while((s->row = mysql_fetch_row(s->result)) != 0)
		printf("%-20s\t%s\n", s->row[0], s->row[1]);

	mysql_free_result(s->result);
}

void sve_filijale(MySqlStruct* s)
{
	sprintf(s->query, "select f1.ime_kluba, f2.ime_kluba from Filijala f "
					  "join Fudbalski_klub f1 on f1.id_kluba = f.Fudbalski_klub_id_kluba_senior "
					  "join Fudbalski_klub f2 on f2.id_kluba = f.Fudbalski_klub_id_kluba_filijala");

	if(mysql_query(s->connection, s->query) != 0)
		error_fatal("Greska u dohvatanju iz tabele Filijala!\n", mysql_error(s->connection));

	s->result = mysql_store_result(s->connection);
	if(s->result == NULL)
		error_fatal("mysql_store_result failed!\n", mysql_error(s->connection));

	if(mysql_num_rows(s->result) == 0) {
		printf("Ne postoje podaci o filijalama!\n");
		mysql_free_result(s->result);
		return;
	}

	s->column = mysql_fetch_field(s->result);
	printf("%-20s\t%s\n", s->column[0].name, s->column[1].name);

	while((s->row = mysql_fetch_row(s->result)) != 0)
		printf("%-20s\t%s\n", s->row[0], s->row[1]);

	mysql_free_result(s->result);
}

void menjanje_lige(MySqlStruct* s)
{
	size_t bufsize = 128;
	char* klub = (char*)malloc(bufsize * sizeof(char));
	char* liga = (char*)malloc(bufsize * sizeof(char));
	
	if(liga == NULL || klub == NULL) {
		printf("Malloc failed\n");
		exit(EXIT_FAILURE);
	}

	printf("Unesite ime kluba:\n");
	getchar();
	size_t bytes_read = getline(&klub, &bufsize, stdin);
	klub[bytes_read-1] = '\0';

	printf("Unesite novu ligu u kojoj klub ucestvuje:\n");
	bytes_read = getline(&liga, &bufsize, stdin);
	liga[bytes_read-1] = '\0';

	printf("%s\n%s\n", klub, liga);

	sprintf(s->query, "update Fudbalski_klub "
					  "set liga = '%s' "
					  "where ime_kluba like '%s'", liga, klub);

	if(mysql_query(s->connection, s->query) != 0)
		error_fatal("Greska u azuriranju podataka u tabeli Fudbalski_klub!\n", mysql_error(s->connection));

	free(liga);
	free(klub);
}

void dodaj_fudbalera(MySqlStruct* s)
{
	int max_len = 64;
	char ime[max_len], prezime[max_len], nacionalnost[max_len], pozicija[max_len], lateralnost[max_len];
	int godina_rodjenja, plata;

	printf("Unesite ime i prezime fudbalera koga zelite da dodate u bazu:\n");
	scanf("%s%s", ime, prezime);

	printf("Unesite godinu rodjenja:\n");
	scanf("%d", &godina_rodjenja);

	printf("Unesite platu:\n");
	scanf("%d", &plata);

	printf("Unesite nacionalnost:\n");
	scanf("%s", nacionalnost);

	printf("Unesite lateralnost (desnonog ili levonog):\n");
	scanf("%s", lateralnost);

	printf("Unesite poziciju:\n");
	scanf("%s", pozicija);

	sprintf(s->query, "insert into Osoblje(ime, prezime, godina_rodjenja, plata, nacionalnost) "
					  "values ('%s', '%s', %d, %d, '%s')", ime, prezime, godina_rodjenja, plata, nacionalnost);

	if(mysql_query(s->connection, s->query) != 0)
		error_fatal("Greska u unosu u tabelu Osoblje!\n", mysql_error(s->connection));

	sprintf(s->query, "select last_insert_id()");

	if(mysql_query(s->connection, s->query) != 0)
		error_fatal("Greska u dohvatanju poslednjeg primarnog kljuca!\n", mysql_error(s->connection));

	s->result = mysql_use_result(s->connection);

	// if(mysql_num_rows(s->result) == 0) {
	// 	return;
	// }

	s->row = mysql_fetch_row(s->result);
	int id = atoi(s->row[0]);

	mysql_free_result(s->result);

	sprintf(s->query, "insert into Fudbaler(Osoblje_id_osoblja, pozicija, lateralnost) "
					  "values (%d, '%s', '%s')", id, pozicija, lateralnost);

	if(mysql_query(s->connection, s->query) != 0)
		error_fatal("Greska u unosu u tabelu Fudbaler!\n", mysql_error(s->connection));
}

void dodaj_sezonu_fudbalera(MySqlStruct *s)
{
	int max_len = 64;
	char ime[max_len], prezime[max_len], tim[max_len]; 
	int sezona, broj_nastupa, broj_dresa;

	printf("Unesite ime i prezime fudbalera:\n");
	scanf("%s%s", ime, prezime);

	sprintf(s->query, "select o.id_osoblja from Osoblje o "
					  "where o.ime like '%s' and o.prezime like '%s' "
					  "and exists(select * from Fudbaler f "
					  "where f.Osoblje_id_osoblja = o.id_osoblja)", ime, prezime);

	if(mysql_query(s->connection, s->query) != 0)
		error_fatal("Greska u dohvatanju iz tabele Osoblje!\n", mysql_error(s->connection));

	s->result = mysql_store_result(s->connection);
	if(s->result == NULL)
		error_fatal("Greska u mysql_store_result!\n", mysql_error(s->connection));
	int id;

	int num_row = mysql_num_rows(s->result);
	if(num_row == 0) {
		printf("Ne postoji fudbaler sa datim imenom i prezimenom u bazi!\n");
		return;
	}
	else if(num_row != 1) {
		printf("Unesite ID fudbalera za koga zelite da unesete podatke o nastupima:\n");
		scanf("%d", &id);
	}
	else {
		s->row = mysql_fetch_row(s->result);
		id = atoi(s->row[0]);
	}

	mysql_free_result(s->result);

	printf("Unesite klub za koji je fudbaler nastupao:\n");

	size_t bufsize = 128;
	char* klub = malloc(bufsize * sizeof(char));
	if (klub == NULL) {
		printf("Malloc failed\n");
		exit(EXIT_FAILURE);
	}

	getchar();
	size_t chars_read = getline(&klub, &bufsize, stdin);
	klub[chars_read - 1] = '\0';

	sprintf(s->query, "select f.id_kluba from Fudbalski_klub f where f.ime_kluba like '%s'", klub);

	if(mysql_query(s->connection, s->query) != 0)
		error_fatal("Greska u dohvatanju iz tabele Fudbalski_klub!\n", mysql_error(s->connection));

	s->result = mysql_store_result(s->connection);
	if(s->result == NULL)
		error_fatal("Greska u mysql_store_result!\n", mysql_error(s->connection));
	int id_kluba;

	num_row = mysql_num_rows(s->result);
	if(num_row == 0) {
		printf("Ne postoji klub sa datim imenom u bazi!\n");
		return;
	}
	else if(num_row != 1) {
		printf("Unesite ID kluba:\n");
		scanf("%d", &id_kluba);
	}
	else {
		s->row = mysql_fetch_row(s->result);
		id_kluba = atoi(s->row[0]);
	}

	mysql_free_result(s->result);
	free(klub);

	printf("Unesite tim(prvotimci, U18...) za koji je fudbaler nastupao:\n");
	scanf("%s", tim);

	printf("Unesite sezonu koju zelite da dodate:\n");
	scanf("%d", &sezona);

	printf("Unesite broj nastupa:\n");
	scanf("%d", &broj_nastupa);

	printf("Unesite broj dresa:\n");
	scanf("%d", &broj_dresa);

	sprintf(s->query, "insert into Nastupa "
					  "(Fudbaler_Osoblje_id_osoblja, Tim_vrsta_tima, Tim_Fudbalski_klub_id_kluba, "
					  "sezona, broj_dresa, broj_nastupa) values "
					  "(%d, '%s', %d, %d, %d, %d)", id, tim, id_kluba, sezona, broj_dresa, broj_nastupa);

	if(mysql_query(s->connection, s->query) != 0)
		error_fatal("Greska u dodavanju u tabelu Nastupa!\n", mysql_error(s->connection));
}

void svi_fudbaleri(MySqlStruct* s)
{
	printf("Unesite klub:\n");

	size_t bufsize = 128;
	char* klub = malloc(bufsize * sizeof(char));
	if (klub == NULL) {
		printf("Malloc failed\n");
		exit(EXIT_FAILURE);
	}

	getchar();
	size_t chars_read = getline(&klub, &bufsize, stdin);
	klub[chars_read - 1] = '\0';

	int sezona;
	printf("Unesite trazenu sezonu:\n");
	scanf("%d", &sezona);

	sprintf(s->query, "select n.broj_dresa, o.ime, o.prezime, n.Tim_vrsta_tima, f.pozicija, n.broj_nastupa "
					  "from Fudbalski_klub fk "
					  "join Nastupa n on fk.id_kluba = n.Tim_Fudbalski_klub_id_kluba and n.sezona = %d "
					  "join Fudbaler f on n.Fudbaler_Osoblje_id_osoblja = f.Osoblje_id_osoblja "
					  "join Osoblje o on f.Osoblje_id_osoblja = o.id_osoblja "
					  "where fk.ime_kluba like '%s' "
					  "order by n.broj_dresa asc", sezona, klub);

	if(mysql_query(s->connection, s->query) != 0)
		error_fatal("Greska u dohvatanju iz tabele Fudbalski_klub!\n", mysql_error(s->connection));

	s->result = mysql_store_result(s->connection);

	if(s->result == NULL)
		error_fatal("Greska u mysql_store_result!\n", mysql_error(s->connection));

	int num_row = mysql_num_rows(s->result);
	if(num_row == 0) {
		printf("Nema podataka o datom klubu u datoj sezoni!\n");
		return;
	}
	
	s->column = mysql_fetch_field(s->result);
	printf("%-10s\t%-20s\t%-20s\t%-20s\t%-10s\t%s\n", s->column[0].name,
									   s->column[1].name,
									   s->column[2].name,
									   s->column[3].name,
									   s->column[4].name,
									   s->column[5].name);

	while((s->row = mysql_fetch_row(s->result)) != 0)
		printf("%-10s\t%-20s\t%-20s\t%-20s\t%-10s\t%s\n", s->row[0], s->row[1], s->row[2], s->row[3], s->row[4], s->row[5]);

	mysql_free_result(s->result);
	free(klub);
}

void error_fatal (char *format, ...)
{
	va_list arguments;
	va_start (arguments, format);
	vfprintf (stderr, format, arguments);
	va_end (arguments);
	exit (EXIT_FAILURE);
}
