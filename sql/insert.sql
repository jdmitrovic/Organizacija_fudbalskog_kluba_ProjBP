use org_klub;

insert into Stadion(id_stadiona, ime_stadiona, adresa, kapacitet) values
(1, "Rajko Mitic", "-", 51755),
(2, "Cair", "-", 18321),
(3, "Stadion Partizana", "-", 32710),
(4, "Stadion Cukarickog", "-", 4070),
(5, "Mladost", "-", 10331),
(6, "Mladost", "-", 10331),
(7, "Slana bara", "-", 1200),
(8, "Karadjordje", "-", 15000),
(17, "Topciderska zvezda", "-", 1000),
(18, "SC Partizan-Teleoptik", "-", 2000);
-- (9, "Stadion FK Radnik", "-", 3312),
-- (10, "Stadion FK Macva Sabac", "-", 5500),
-- (11, "Stadion FK Vozdovac", "-", 5200),
-- (12, "Gradski Stadion Subotica", "-", 13000),
-- (13, "Slavko Maletin Vava", "-", 5500),
-- (14, "Kralj Petar Prvi", "-", 6000),
-- (15, "Gradski Stadion Zemun", "-", 9600),
-- (16, "Yumco", "-", 1000);

insert into Predsednik(id_predsednika, ime, prezime) values
(1, "Svetozar", "Mijailovic"),
(2, "Jovan", "Jovanovic"),
(3, "Milorad", "Vucelic"),
(4, "Marko", "Boskovic"),
(5, "Ivan", "Popovic"),
(6, "Zoran", "Markovic"),
(7, "Milutin", "Radovanovic"),
(8, "Momcilo", "Atanasijevic"),
(17, "Slobodan", "Govedarica"),
(18, "Aleksandar", "Zivic");

insert into Fudbalski_klub(id_kluba, ime_kluba, godina_osnivanja, drzava, grad, Predsednik_id_predsednika, Stadion_id_stadiona, liga) values
(1, "Crvena Zvezda", 1945, "Srbija", "Beograd", 1, 1, "Jelen Superliga"),
(2, "Radnicki Nis", 1923, "Srbija", "Nis", 2, 2, "Jelen Superliga"),
(3, "Partizan", 1945, "Srbija", "Beograd", 3, 3, "Jelen Superliga"),
(4, "Cukaricki", 1926, "Srbija", "Beograd", 4, 4, "Jelen Superliga"),
(5, "Napredak", 1946, "Srbija", "Krusevac", 5, 5, "Jelen Superliga"),
(6, "Mladost", 1952, "Srbija", "Lucani", 6, 6, "Jelen Superliga"),
(7, "Proleter", 1951, "Srbija", "Novi Sad", 7, 7, "Jelen Superliga"),
(8, "Vojvodina", 1914, "Srbija", "Novi Sad", 8, 8, "Jelen Superliga"),
(17, "Graficar", 1922, "Srbija", "Beograd", 17, 17, "Srpska liga Beograd"),
(18, "Teleoptik", 1952, "Srbija", "Beograd", 18, 18, "Prva liga Srbije");
--(9, "Radnik Surdulica", 1926, "Srbija", "Surdulica", 9, 9, "Jelen Superliga"),
-- (10, "Macva", 1919, "Srbija", "Sabac", 10, 10, "Jelen Superliga"),
-- (11, "Vozdovac", 1914, "Srbija", "Beograd", 11, 11, "Jelen Superliga"),
-- (12, "Spartak Zdrepceva krv", 1945, "Srbija", "Subotica", 12, 12, "Jelen Superliga"),
-- (13, "OFK Backa", 1945, "Srbija", "Backa Palanka", 13, 13, "Jelen Superliga"),
-- (14, "Rad", 1958, "Srbija", "Beograd", 14, 14, "Jelen Superliga"),
-- (15, "Zemun", 1945, "Srbija", "Beograd", 15, 15, "Jelen Superliga"),
-- (16, "Dinamo", 1947, "Srbija", "Vranje", 16, 16, "Jelen Superliga");

insert into Filijala(Fudbalski_klub_id_kluba_senior, Fudbalski_klub_id_kluba_filijala) values
(1, 17),
(3, 18);

insert into Osoblje(id_osoblja, ime, prezime, godina_rodjenja, plata, nacionalnost) values
(1, "Marko", "Gobeljic", 1992, 10000, "Srbija"),
(2, "Milan", "Borjan", 1987, 13000, "Kanada"),
(3, "Svetozar", "Markovic", 2000, 4000, "Srbija"),
(4, "Zlatan", "Sehovic", 2000, 3000, "Srbija"),
(5, "Radovan", "Pankov", 1995, 2000, "Srbija"),
(6, "Ryota", "Noma", 1991, 2500, "Japan"),
(7, "Nemanja", "Stevanovic", 1992, 5000, "Srbija"),
(8, "Marko", "Docic", 1993, 7000, "Srbija"),
(9, "Aleksa", "Vukanovic", 1992, 10000, "Srbija"),
(10, "Ibrahima", "Ndiaye", 1994, 10000, "Senegal"),
(11, "Vladan", "Milojevic", 1977, 3500, "Srbija"),
(12, "Nenad", "Lalatovic", 1980, 3500, "Srbija"),
(13, "Zoran", "Mirkovic", 1975, 3500, "Srbija"),
(14, "Milorad", "Kosanovic", 1960, 3500, "Srbija"),
(15, "Simo", "Krunic", 1967, 3500, "Srbija");

insert into Fudbaler(Osoblje_id_osoblja, pozicija, lateralnost) values
(1, "RB", "desnonog"),
(2, "GK", "desnonog"),
(3, "CB", "desnonog"),
(4, "LB", "desnonog"),
(5, "CB", "desnonog"),
(6, "CAM", "levonog"),
(7, "GK", "desnonog"),
(8, "CDM", "desnonog"),
(9, "LW", "levonog"),
(10, "RW", "desnonog");

insert into Tim(Fudbalski_klub_id_kluba, vrsta_tima) values
(1, "prvotimci"),
(1, "rezerve"),
(1, "U18"),
(2, "prvotimci"),
(2, "rezerve"),
(2, "U18"),
(3, "prvotimci"),
(3, "rezerve"),
(3, "U18"),
(4, "prvotimci"),
(4, "rezerve"),
(4, "U18"),
(5, "prvotimci"),
(5, "rezerve"),
(5, "U18"),
(6, "prvotimci"),
(6, "rezerve"),
(6, "U18"),
(7, "prvotimci"),
(7, "rezerve"),
(7, "U18"),
(8, "prvotimci"),
(8, "rezerve"),
(8, "U18"),
(17, "prvotimci"),
(17, "rezerve"),
(17, "U18"),
(18, "prvotimci"),
(18, "rezerve"),
(18, "U18");

insert into Nastupa(Fudbaler_Osoblje_id_osoblja, Tim_vrsta_tima, Tim_Fudbalski_klub_id_kluba, sezona, broj_dresa, broj_nastupa) values
(1, "prvotimci", 1, 2018, 77, 50),
(2, "prvotimci", 1, 2018, 82, 55),
(3, "prvotimci", 3, 2018, 15, 20),
(5, "prvotimci", 2, 2018, 5, 55),
(6, "prvotimci", 2, 2018, 12, 20),
(7, "prvotimci", 4, 2018, 1, 50),
(8, "prvotimci", 4, 2018, 8, 55),
(10, "prvotimci", 5, 2018, 72, 20),
(4, "U18", 3, 2018, 17, 22),
(9, "prvotimci", 5, 2017, 17, 20),
(1, "prvotimci", 1, 2017, 77, 50),
(2, "prvotimci", 1, 2017, 82, 55);

insert into Menadzer(Osoblje_id_osoblja, kvalifikacije) values
(11, "Continental Pro"),
(12, "Continental Pro"),
(13, "Continental Pro"),
(14, "Continental Pro"),
(15, "Continental Pro");

insert into Trenira(Menadzer_Osoblje_id_osoblja, Tim_vrsta_tima, Tim_Fudbalski_klub_id_kluba, sezona) values
(11, "prvotimci", 1, 2018),
(12, "prvotimci", 2, 2018),
(13, "prvotimci", 3, 2018),
(14, "prvotimci", 1, 2018),
(15, "prvotimci", 4, 2018);