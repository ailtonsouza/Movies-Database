# Movies Database
 
Este projeto foi criado para treinar e aprimorar o uso do SGBD SQL Server e da linguagem SQL.

A estrutura de banco criada persiste os filmes assistidos, associa os gêneros pertinentes e relaciona o filme com os profissionais que atuaram na produção, assim como indica os Oscars vencidos. 

## As seguintes tabelas compõem o banco de dados:

1. Movie – A tabela possui as informações referentes aos filmes assistidos.
2. Genre - A tabela possui os possíveis gêneros dos filmes.
3. MovieGenre – A tabela associa um filme a um gênero, através da persistência de um id de cada entidade.
5. OscarAward - A tabela associa um filme, um Profissional e uma categoria de Oscar, através da persistência dos respectivos ids de cada entidade, além de possuir campos próprios.
6. OscarCategory - A tabela possui as possíveis categorias de Oscar.
7. Professional - A tabela possui as informações referentes a profissionais da indústria cinematográfica.
8. Role – A tabela possui os possíveis papeis disponíveis para um ator em um filme.
9. ProfessionalMovie - A tabela associa um profissional a um filme e papel, através da persistência do id das respectivas entidades.

## O seguinte diagrama representa o banco de dados:x


![ERD with colored entities (UML notation) (1)](https://user-images.githubusercontent.com/8715196/141843218-0d409329-b446-497f-801a-ef427fa9c566.png)


## Regras de negócios do banco  de dados:

1. Cada registro IMDBId deverá ser associado a apenas um Profissional, assim a tabela Professional deve possuir apenas registro únicos para a coluna IMDBId.
2. Cada nome de um papel desempenhado um profissional deverá ser único, assim a tabela Role deve possuir apenas registro únicos para a coluna Name.
3. Cada nome de um gênero deve ser único, assim a tabela Genre deve possuir apenas registro únicos para a coluna Name.
4. Cada registro IMDBId deverá ser associado a apenas um Filme, assim a tabela Movie deve possuir apenas registro únicos para a coluna IMDBId.
5. Cada filme pode ser associado a várias categorias, porém não pode ser associado duas vezes a mesma categoria, assim a tabela MovieGenre deve possuir apenas registro únicos para a combinação de colunas Movie_Id e Genre_Id.
6. Cada nome de uma categoria de Oscar deve ser único, assim a tabela OscarCategory deve possuir apenas registros únicos para a coluna Name.
7. Cada OscarAward não pode ser concedido na mesma categoria mais de uma vez na mesma cerimônia, assim a tabela OscarAward deve possuir apenas registros únicos para a combinação de colunas Category_Id e CerimonyNumber.
8. Um OscarAward das categorias “Actor”, “ACTOR IN A LEADING ROLE”, “ACTOR IN A SUPPORTING ROLE” só pode ser concedido a profissionais que participaram da produção como “Actor”.
9. Um OscarAward das categorias “ACTRESS IN A LEADING ROLE” e “ACTRESS IN A SUPPORTING ROLE” só pode ser concedido a profissionais que participaram da produção como “Actress”.
10. Um OscarAward da categoria “DIRECTING” só pode ser concedido a profissionais que participaram da produção como “Director”.
11. Um OscarAward das categorias “Actor”, “ACTOR IN A LEADING ROLE”, “ACTOR IN A SUPPORTING ROLE”, “ACTRESS IN A LEADING ROLE” e “ACTRESS IN A SUPPORTING ROLE” e “DIRECTING” devem possuir um profissional associado.
12. Um OscarAward que não seja das categorias “Actor”, “ACTOR IN A LEADING ROLE”, “ACTOR IN A SUPPORTING ROLE”, “ACTRESS IN A LEADING ROLE” e “ACTRESS IN A SUPPORTING ROLE” e “DIRECTING” não devem possuir um profissional associado.

## Atendimento as regras de negócios definidas:

1. Atendimento a regra de negócio 1: A constraint “Unique_IMDB_Professional_Id” garante a singularidade de dados na coluna “IMDBId” na tabela Professional.
2. Atendimento a regra de negócio 2: A constraint “CONSTRAINT Unique_Role_Name UNIQUE (Name)” garante a singularidade de dados na coluna “Name” na tabela Role.
3. Atendimento a regra de negócio 3: A constraint “CONSTRAINT Unique_Genre_Name UNIQUE (Name)” garante a singularidade de dados na coluna “Name” na tabela Genre.
4. Atendimento a regra de negócio 4: A constraint “CONSTRAINT Unique_IMDB_Movie_Id UNIQUE (IMDBId)” garante a singularidade de dados na coluna “IMDBId” na tabela Movie.
5. Atendimento a regra de negócio 5: A constraint “CONSTRAINT Unique_Movie_Genre UNIQUE (Movie_Id,Genre_Id)” garante a singularidade de dados na concatenação das colunas “Movie_Id” e “Genre_Id” na tabela MovieGenre.
6. Atendimento a regra de negócio 6: A constraint “CONSTRAINT Unique_OscarCategory_Name UNIQUE (Name)” garante a singularidade de dados da coluna “Name” na tabela OscarCategory.
7. Atendimento a regra de negócio 7: A constraint “CONSTRAINT Unique_Category_CerimonyNumber UNIQUE (Category_Id,CerimonyNumber)” garante a singularidade de dados na concatenação das colunas  “Category_Id” e “CerimonyNumber” na tabela OscarAward.
8. Atendimento das regras de negócio 8, 9, 10, 11 e 12: A trigger “Checking_OscarAward” garante a inserção dos dados seguindo as regras de negócio definidas. 

## Dicionário de dados:

### Tabela Movie
|Atributo|Descrição|Tipo de dados|Tamanho|Restrições de domínio|
|----------------------|----------------------|----------------------|----------------------|----------------------|
|Id|Id do filme|Inteiro||PK, Identity (1,1)|
|IMDBId|Identificação no site IMDB|Texto|10|Unique, not null|
|PrimaryTitle|Título pelo qual o filme é mais conhecido|Texto|100|Not null|
|OriginalTitle|Título original do filme|Texto|100|Not null|
|ReleaseYear|Quatro dígitos referente ao ano de lançamento|Inteiro||Not null|
|Minutes|Número de minutos do filme|Inteiro||Not null|

### Tabela Genre
|Atributo|Descrição|Tipo de dados|Tamanho|Restrições de domínio|
|----------------------|----------------------|----------------------|----------------------|----------------------|
|Id|Id do gênero do filme|Inteiro||PK/Identity(1,1)|
|Name|Nome do gênero do filme|Texto|30|Unique/not null|

### Tabela MovieGenre
|Atributo|Descrição|Tipo de dados|Tamanho|Restrições de domínio|
|---|--- |--- |--- |--- |
|Movie_Id|Id do filme a ser associado ao gênero|Inteiro||FK, Unique with Genre_Id|
|Genre_Id|Id do gênero a ser associado ao filme|Inteiro||FK, Unique with Movie_Id|

### Tabela OscarAward
|Atributo|Descrição|Tipo de dados|Tamanho|Restrições de domínio|
|--- |--- |--- |--- |--- |
|Id|Id do OscarAward|Inteiro||PK,Identity(1,1)|
|Movie_Id|Id do filme que ganhou o OscarAward|Inteiro||FK,not null|
|Professional_Id|Id do profissional que recebeu o OscarAward quando aplicável|Inteiro||FK,nullable|
|IMDBEventId| Identificação do evento no site IMDB|Texto|25|not null|
|Category_Id|Categoria do OscarAward|Inteiro||FK,not null|
|CerimonyDate|Data da cerimônia do OscarAward|Data||not null|
|CerimonyNumber|Número da cerimônia do OscarAward|Inteiro||not null|
|MoviesReleasedIn|Quatro dígitos referente ao ano dos filmes que concorreram ao OscarAward.|Inteiro||not null|

### Tabela OscarCategory
|Atributo|Descrição|Tipo de dados|Tamanho|Restrições de domínio|
|--- |--- |--- |--- |--- |
|Id|Id da categoria do Oscar|Inteiro||PK,Identity(1,1)|
|Name|Nome do papel|Texto|150|Unique,not null|

### Tabela Professional
|Atributo|Descrição|Tipo de dados|Tamanho|Restrições de domínio|
|--- |--- |--- |--- |--- |
|Id|Id do profissional|Inteiro||PK,Identity(1,1)|
|IMDBId|Identificação no site IMDB|Texto|10|Unique,not null|
|PrimaryName|Nome pelo qual o profissional é mais conhecido|Texto|100|not null|
|BirthYear|Quatro dígitos referente ao ano de nascimento|Inteiro||not null|

### Tabela Role 
|Atributo|Descrição|Tipo de dados|Tamanho|Restrições de domínio|
|--- |--- |--- |--- |--- |
|Id|Id do papel|Inteiro||PK,Identity(1,1)|
|Name|Nome do papel|Texto|30|Unique,not null|

### Tabela ProfessionalMovie 
|Atributo|Descrição|Tipo de dados|Tamanho|Restrições de domínio|
|--- |--- |--- |--- |--- |
|Professional_Id|Id do profissional a ser associado ao filme|Inteiro||FK|
|Movie_Id|Id do filme a ser associado ao profissional|Inteiro||FK|
|Role_Id|Id do papel a ser associado ao filme e profissional|Inteiro||FK|
|CharacterName|Nome do personagem desempenhado, caso aplicável|Texto|100|nullable|

## Fonte de dados:

Os dados das tabelas relacionadas a filmes e profissionais foram adquiridos, com base nos arquivos disponibilizados no site IMDB ( https://www.imdb.com/ ) no link: https://www.imdb.com/interfaces/. Este link possui diversos arquivos para serem baixados, e foram relacionadas as tabelas criadas, conforme descrito abaixo:

|Arquivo IMDB|Tabela|
|---|---|
|name.basics.tsv.gz|Professional| 
|title.principals.tsv.gz|ProfessionalMovie|
|title.basics.tsv.gz|Movie| 
|title.basics.tsv.gz|Genre| 
|title.basics.tsv.gz|MovieGenre| 
|title.principals.tsv.gz|Role|

Os dados das tabelas OscarAward e OscarCategory foram adquiridos e relacionados aos filmes, através do site https://www.oscars.org/oscars/ceremonies, que possui o histórico de todas as cerimonias e filmes vencedores.
