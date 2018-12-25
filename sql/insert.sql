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
(2, "Milorad", "Vucelic"),
(3, "Jovan", "Jovanovic"),
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
(4, "Zlatan", "Sehovic", 2000, 3000, "Srbija");
-- (1, "Marko", "Gobeljic", 1992, 10000, "Srbija"),
-- (1, "Marko", "Gobeljic", 1992, 10000, "Srbija"),
-- (1, "Marko", "Gobeljic", 1992, 10000, "Srbija"),
-- (1, "Marko", "Gobeljic", 1992, 10000, "Srbija"),
-- (1, "Marko", "Gobeljic", 1992, 10000, "Srbija"),
-- (1, "Marko", "Gobeljic", 1992, 10000, "Srbija"),

insert into Fudbaler(Osoblje_id_osoblja, pozicija, lateralnost) values
(1, "RB", "desnonog"),
(2, "GK", "desnonog"),
(3, "CB", "desnonog"),
(4, "LB", "desnonog");