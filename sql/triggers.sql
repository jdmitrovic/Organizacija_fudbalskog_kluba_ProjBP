use org_klub;
delimiter $$

-- Nije dopusteno dupliranje filijala, da klubovi uzajamno budu filijale, 
-- da klub ima filijalu u istoj ligi, niti da klubovi budu sami sebi filijala

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

	if(exists(
		select * from Fudbalski_klub f1 
		where f1.id_kluba = new.Fudbalski_klub_id_kluba_filijala
	  	and exists(
	  		select * from Fudbalski_klub f2 
	  		where f2.id_kluba = new.Fudbalski_klub_id_kluba_senior
			and f2.liga like f1.liga)
	  	)
	)
	then
		SIGNAL SQLSTATE '45000' SET message_text = 'Greska: klub ne moze imati filijalu u istoj ligi!';
	end if;

	if(exists(select * from Filijala f where new.Fudbalski_klub_id_kluba_senior = new.Fudbalski_klub_id_kluba_filijala))
	then
		SIGNAL SQLSTATE '45000' SET message_text = 'Greska: klub ne moze biti sam sebi filijala!';
	end if;
end $$

-- Brisu se sve filijalne veze u istoj ligi
-- prilikom plasiranja ili relegiranja u novu ligu

drop trigger if exists bu_Fudbalski_klub $$
create trigger bu_Fudbalski_klub before update on Fudbalski_klub
for each row
begin
	if(old.liga not like new.liga)
	then
		delete from Filijala
		where (Filijala.Fudbalski_klub_id_kluba_filijala = new.id_kluba
		and exists(
			select * from Fudbalski_klub fklub 
			where fklub.id_kluba = Filijala.Fudbalski_klub_id_kluba_senior
			and fklub.liga = new.liga
		))
		or (Filijala.Fudbalski_klub_id_kluba_senior = new.id_kluba
		and exists(
			select * from Fudbalski_klub fklub 
			where fklub.id_kluba = Filijala.Fudbalski_klub_id_kluba_filijala
			and fklub.liga = new.liga
		));
	end if;
end $$

drop trigger if exists bi_Nastupa $$
create trigger bi_Nastupa before insert on Nastupa
for each row
begin
	if(exists(
		select * from Nastupa n 
		where n.Fudbaler_Osoblje_id_osoblja = new.Fudbaler_Osoblje_id_osoblja
		and n.sezona = new.sezona)
	)
	then
		SIGNAL SQLSTATE '45000' SET message_text = 'Greska: jedan igrac ne moze igrati na dva mesta u istoj sezoni!';
	end if;

	if(exists(select * from Nastupa n 
			  where n.Tim_Fudbalski_klub_id_kluba = new.Tim_Fudbalski_klub_id_kluba
			  and n.broj_dresa = new.broj_dresa
			  and n.sezona = new.sezona
			  and n.Tim_vrsta_tima like new.Tim_vrsta_tima)
	)
	then
		set new.broj_dresa = (
			select n1.broj_dresa + 1 
			from Nastupa n1
			where n1.sezona = new.sezona
			and n1.Tim_Fudbalski_klub_id_kluba = new.Tim_Fudbalski_klub_id_kluba
			and n1.Tim_vrsta_tima like new.Tim_vrsta_tima
			and not exists(
				select * from Nastupa n2 
				where n2.broj_dresa = n1.broj_dresa + 1 
				and n1.Tim_Fudbalski_klub_id_kluba = n2.Tim_Fudbalski_klub_id_kluba
				and n1.sezona = n2.sezona
				and n1.Tim_vrsta_tima = n2.Tim_vrsta_tima
			)
			order by n1.broj_dresa
			limit 1
		);

		if(new.broj_dresa = 0 or new.broj_dresa > 99)
		then
			SIGNAL SQLSTATE '45000' SET message_text = 'Greska: igrac ima maksimalno broj 99!';
		end if;
	end if;
end $$

drop trigger if exists bi_Trenira $$
create trigger bi_Trenira before update on Trenira
for each row
begin
	if(
		exists(
			select * from Trenira t 
			where t.Menadzer_Osoblje_id_osoblja = new.Menadzer_Osoblje_id_osoblja
			and t.sezona = new.sezona
		)
	)
	then
		SIGNAL SQLSTATE '45000' SET message_text = 'Greska: ne moze isti menadzer trenirati dva kluba u isto vreme!';
	end if;
end $$

delimiter ;