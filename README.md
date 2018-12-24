# Organizacija Fudbalskog Kluba

Jednostavna baza koja opisuje organizaciju fudbalskog kluba.

Jovan Dmitrović 1094/2018

## Opis

Fudbalski klub je jedinstveno određen ID-em. Pored toga, u opisu kluba stoje i ime kluba, godina osnivanja, država i grad u kojem se nalaze, kao i liga u kojoj klub učestvuje. Pored toga, u sklopu kluba se čuvaju i informacije o stadionu koji klub koristi, kao i o predsedniku kluba. Stadion je jedinstveno određen identifikacionim brojem, a čuvaju se informacije o imenu stadiona, adresi i kapacitetu. Klub nastupa na tačno jednom stadionu, ali na stadionu može igrati više klubova. Predsednik kluba ima svoj ID, a njegovo ime i prezime se takodje čuvaju u tabeli.

Fudbalski klubovi mogu imati filijale - druge fudbalske klubove koji ne nastupaju u istoj ligi kao i njihov matični klub.

Svaki klub ima više timova koji nastupaju za taj klub - A tim, U18, Rezervni tim, i sl. Oni su jedinstveno određeni klubom i vrstom tima. Timovi imaju fudbalere koji za njega nastupaju, kao i menadzera koji trenira taj tim.

Osoblje je jedistveno određeno svojim identifikacionim brojem, ali se čuvaju informacije o imenu, prezimenu, godini rođenja, plati i nacionalnosti. Postoje dve podvrste osoblja: fudbaleri i menadzeri.

Fudbaleri se odlikuju svojom pozicijom i lateralnošću (odnosno, ovaj atribut se koristi za navođenje dominantne noge). Za menadžere se navode i njihove kvalifikacije.

Fudbaleri nastupaju za jedan fudbalski klub u jednoj sezoni i nosi jedistven broj dresa u tom klubu za tu sezonu.

## Uslovi

* Nezavisni entiteti - Fudbalski_Klub, Stadion, Predsednik, Osoblje
* Odnos specijalizacija-generalizacija - Osoblje -> Fudbaler, Menadžer
* Rekurzivni odnos - Filijala
* Agregirani entiteti - Nastupa, Trenira

## Okidači

* bi_Filijala - pre inserta u tabelu *Filijala*, proverava se da li su uneta dva različita kluba (iz različitih liga), koja već nisu u tabeli. Takođe, klubovima je onemogućeno da budu uzajamne filijale.
* bu_Fudbalski_klub - pre update-a u tabeli *Fudbalski_klub*, proveravamo da li se menja liga kluba, i brisemo filijalne odnose gde dva kluba nastupaju u istoj ligi.
* bi_Nastupa - pre inserta u tabelu *Nastupa*, proverava se da li postoji drugi igrač koji nastupa za isti klub u istoj sezoni sa istim brojem. Tada menjamo broj dresa igrača čije podatke dodajemo u tabelu na prvi slobodan broj.
* bi_Trenira - pre inserta u tabelu *Trenira*, onemogućujemo da jedan trener trenira više klubova u isto vreme.