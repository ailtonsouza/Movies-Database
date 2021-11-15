-- A query exibe quais foram os Oscars vencidos por determinado filme, exibindo o título do filme, o ano da cerimônia, o número da cerimônia, o nome da categoria e o nome do profissional que recebeu o Oscar. Caso a categoria não faça jus a um ganhador, a coluna “PrimaryName” é exibida com o resultado null.
declare @idDofilme as int = 37
select M.originalTitle, OA.CerimonyDate, OA.CerimonyNumber, OC.Name, P.primaryName 
from OscarAward as OA
left join OscarCategory as OC
on OA.Category_Id = OC.id
left join Movie as M
on M.Id = OA.Movie_Id
left join Professional as P
on P.Id = OA.Professional_Id
where Movie_Id = @idDofilme

select * from OscarAward

--- Exibe a lista de filmes que ganhou a menos um Oscar entre o intervalo de anos contidos entre um ano de início e um ano de fim.
declare @anoInicio as int = 1900
declare @anoFim as int = 2017
select Distinct M.Id, M.imdbId, M.originalTitle, M.primaryTitle, M.ReleaseYear, M.Minutes  
from Movie as M
right join OscarAward as OA
on OA.Movie_Id = M.Id
where M.ReleaseYear >= @anoInicio and M.ReleaseYear <= @anoFim
order by M.ReleaseYear

--- Exibe da lista de filmes assistidos por ano, quantos filmes assistidos ganharam ao menos um Oscar em cada ano dentro do range
declare @anoInicio as int = 1950
declare @anoFim as int = 2020
select M.ReleaseYear as Year, Count(Distinct M.Id ) as NumeroDeVencedores
from Movie as M
right join OscarAward as OA
on OA.Movie_Id = M.Id
where M.ReleaseYear >= @anoInicio and M.ReleaseYear <= @anoFim
group by M.ReleaseYear
order by Year DESC

-- Exibe os 3 filmes que dentre os assistidos ganharam mas Oscar
select top(3) M.Id, M.originalTitle, count(*) as NumeroOcorrencias
from OscarAward as OA 
join MOVIE as M
on M.Id = OA.Movie_Id
group by M.Id, M.originalTitle
order by NumeroOcorrencias desc

-- Exibe os 3 filmes e quantidade de estatuetas que dentre os filmes assistidos, mais vezes foram vencedores do Oscar.
declare @numeroOscarVencidos as int = 3
select M.Id, M.originalTitle, count(*) as NumeroOcorrencias
from OscarAward as OA 
left join MOVIE as M
on M.Id = OA.Movie_Id
group by M.Id, M.originalTitle
having count(*) > @numeroOscarVencidos
order by NumeroOcorrencias desc

--Mostra os atores que participaram de filmes que ganharam ao menos um Oscar e mostra qual foi o papel desempenhado nos filmes.
select P.id, P.primaryName, Count(Distinct M.Id) as NumeroOscar, left(PR.ProfessionalRole, len(PR.ProfessionalRole)-1) as Roles
from Professional as P
left join ProfessionalMovie as PM
on P.id = PM.Professional_Id
left join Movie as M
on M.id = PM.Movie_Id
right join OscarAward as OA
on OA.Movie_Id = M.id
left join (
		select * 
		from (
		--
		select	id ,
		(
		select R.Name + ','
		from Professional as P
		left join ProfessionalMovie as PM
		on P.id = PM.Professional_Id
		left join Movie as M
		on M.id = PM.Movie_Id
		right join OscarAward as OA
		on OA.Movie_Id = M.id
		left join Role as R
		on R.Id = PM.Role_Id
		where P.id = PF.id
		group by P.Id,P.primaryName,M.Id,PM.Role_Id,M.originalTitle, R.Name
		for XML PATH ('')
		) as ProfessionalRole
		from [dbo].[Professional] as PF
		--
		) as ActorRole) as PR
on PR.Id = p.Id
group by P.Id,P.primaryName,PR.ProfessionalRole
order by NumeroOscar desc

--Exibe o percentual de filme assistidos que tiveram seu lançamento em determinado ano. 
select Distinct ReleaseYear,
convert(varchar(4),(convert(decimal(5,2),count(Movie.Id) over(partition by  ReleaseYear)*1.00/count(*) over()*100))) + '%'  as PercentageOfMoviesReleasedInTheYear
from Movie 

--Exibe o total de filme assistido por categoria. (Um filme pode ter mais de uma categoria)
select G.Name, Count(*) as TotalWatched from Genre as G
left join MovieGenre as MG
on G.Id = MG.Genre_Id
group by G.Name
order by TotalWatched DESC
