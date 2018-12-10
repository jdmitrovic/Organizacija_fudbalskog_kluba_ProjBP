# Organizacija Fudbalskog Kluba

Jednostavna baza koja opisuje organizaciju fudbalskog kluba.

Jovan Dmitrović 1094/2018

## Opis

Fudbalski klub je jedinstveno određen ID-em. Pored toga, u opisu kluba stoje i ime kluba, godina osnivanja, država i grad u kojem se nalaze, kao i liga u kojoj klub učestvuje. Pored toga, u sklopu kluba se čuvaju i informacije o stadionu koji klub koristi, kao i o predsedniku kluba. Stadion je jedinstveno određen identifikacionim brojem, a čuvaju se informacije o imenu stadiona, adresi i kapacitetu. Klub nastupa na tačno jednom stadionu, ali na stadionu može igrati više klubova. Predsednik kluba ima svoj ID, a njegovo ime i prezime se takodje čuvaju u tabeli.

Fudbalski klubovi mogu imati filijale - druge fudbalske klubove koji ne nastupaju u istoj ligi kao i njihov matični klub. Svaki klub može imati više filijala, ali svaki klub može imati maksimalno jedan matični klub.

Svaki klub ima više timova koji nastupaju za taj klub - A tim, U18, Rezervni tim, i sl. Oni su jedinstveno određeni klubom i vrstom tima. Timovi imaju fudbalere koji za njega nastupaju, kao i menadzera koji trenira taj tim.

Osoblje je jedistveno određeno svojim identifikacionim brojem, ali se čuvaju informacije o imenu, prezimenu, godini rođenja, plati i nacionalnosti. Postoje dve podvrste osoblja: fudbaleri i menadzeri.

Fudbaleri se odlikuju svojom pozicijom, brojem dresa i lateralnošću (odnosno, ovaj atribut se koristi za navođenje dominantne noge). Za menadžere se navode i njihove kvalifikacije.

## Uslovi

* Nezavisni entiteti - Fudbalski_Klub, Stadion, Predsednik, Osoblje
* Odnos specijalizacija-generalizacija - Osoblje -> Fudbaler, Menadžer
* Rekurzivni odnos - Filijala
* Agregirani entiteti - Nastupa, Trenira
