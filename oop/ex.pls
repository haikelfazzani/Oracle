insert into table(select athletes from equipe where numeq=6)
values (30, 'Pietrus', 'Micheal', tab_controle());

insert into table(select a.controles from equipe e, table(e.athletes) a
where e.numeq=6 and a.numdossard=30) 
values(15, 'Urinaire','23/01/2015','N');

delete from table(select a.controles from equipe e, table(athletes) a
where a.numdossard=30 and e.numeq=6);

update table(select a.controles from equipe e, table(athletes) a
where e.numeq=4 and a.numdossard=6) 
set resultat='N'
where datectrl='04/11/2015';


select * from equipe e1 where not exists(select * from equipe e2,table(athletes) a,
table(a.controles) c 
where e1.numeq=e2.numeq and c.resultat='P');

SELECT e.NumEq, e.CodePays, e.Sport
FROM Equipe e, TABLE(e.Athletes) a, TABLE(a.Controles)
GROUP BY e.NumEq, e.CodePays, e.Sport
HAVING COUNT(*) =
     (SELECT MAX(COUNT(*))
     FROM Equipe e1, TABLE(e1.Athletes) a1, TABLE(a1.Controles)
     GROUP BY e1.NumEq);