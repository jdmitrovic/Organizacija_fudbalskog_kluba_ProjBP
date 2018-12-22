use org_klub;
delimiter $$

-- Nije dopusteno dupliranje filijala, da klubovi uzajamno budu filijale, niti da klubovi budu
-- sami sebi filijala

drop trigger if exists bi_Filijala $$
create trigger bi_Filijala before insert on Filijala
for each row
begin
	if(exists(select * from Filijala f where f.Fudbalski_klub_id_kluba_senior = new.Fudbalski_klub_id_kluba_senior 
			  and f.Fudbalski_klub_id_kluba_senior = new.Fudbalski_klub_id_kluba_filijala))
	then
		SIGNAL SQLSTATE '45000' SET message_text = 'Greska: uneti dogovor vec postoji!';
	end if;
	
	if(exists(select * from Filijala f where f.Fudbalski_klub_id_kluba_senior = new.Fudbalski_klub_id_kluba_filijala
			  and f.Fudbalski_klub_id_kluba_filijala = new.Fudbalski_klub_id_kluba_senior))
	then
		SIGNAL SQLSTATE '45000' SET message_text = 'Greska: klubovi ne mogu biti uzajamno filijale!';
	end if;

	if(exists(select * from Filijala f where new.Fudbalski_klub_id_kluba_senior = new.Fudbalski_klub_id_kluba_filijala))
	then
		SIGNAL SQLSTATE '45000' SET message_text = 'Greska: klub ne moze biti sam sebi filijala!';
	end if;
end $$

drop trigger if exists bi_Nastupa $$
create trigger bi_Nastupa before update on Nastupa
for each row
begin
	if(exists(select * from Nastupa n where n.Tim_Fudbalski_klub_id_kluba = new.Tim_Fudbalski_klub_id_kluba
			  and n.broj_dresa = new.broj_dresa
			  and ((n.poslednja_godina is NULL and new.poslednja_godina is NULL) or n.poslednja_godina >= new.godina_debitovanja
			  		or new.poslednja_godina >= n.godina_debitovanja)))
	then
		SIGNAL SQLSTATE '45000' SET message_text = 'Greska: ne mogu dva igraca igrati sa istim brojem u istom klubu u isto vreme!';
	end if;

	if(new.poslednja_godina is NULL)
	then
		update Nastupa set poslednja_godina = new.godina_debitovanja where poslednja_godina is NULL;
	end if;
end $$

delimiter ;