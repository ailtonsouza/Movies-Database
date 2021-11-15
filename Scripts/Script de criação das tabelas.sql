
use MOVIES

CREATE TABLE Professional (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
IMDBId VARCHAR(10) NOT NULL,
PrimaryName VARCHAR(100) NOT NULL,
BirthYear SMALLINT,
CONSTRAINT Unique_IMDB_Professional_Id UNIQUE (IMDBId),
)

CREATE TABLE Role (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Name VARCHAR(30) NOT NULL
CONSTRAINT Unique_Role_Name UNIQUE (Name),
)

CREATE TABLE Genre (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Name VARCHAR(30) NOT NULL,
CONSTRAINT Unique_Genre_Name UNIQUE (Name),
)

CREATE TABLE Movie (
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
IMDBId varchar(10) NOT NULL,
PrimaryTitle varchar(100) NOT NULL,
OriginalTitle varchar(100) NOT NULL,
ReleaseYear SMALLINT NOT NULL,
Minutes SMALLINT NOT NULL,
CONSTRAINT Unique_IMDB_Movie_Id UNIQUE (IMDBId),
)


CREATE TABLE MovieGenre (
Movie_Id int not null,
Genre_Id int not null,
FOREIGN KEY (Movie_Id) REFERENCES Movie(Id),
FOREIGN KEY (Genre_Id) REFERENCES Genre(Id),
CONSTRAINT Unique_Movie_Genre UNIQUE (Movie_Id,Genre_Id),
)

CREATE TABLE ProfessionalMovie (
Professional_Id INT NOT NULL,
Movie_Id INT NOT NULL,
Role_Id INT NOT NULL,
CharacterName varchar(100),
FOREIGN KEY (Professional_Id) REFERENCES Professional(Id),
FOREIGN KEY (Movie_Id) REFERENCES Movie(id),
FOREIGN KEY (Role_Id) REFERENCES Role(id)
)

CREATE TABLE OscarCategory(
Id INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
Name VARCHAR(150) NOT NULL,
CONSTRAINT Unique_OscarCategory_Name UNIQUE (Name),
)

CREATE TABLE OscarAward(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Movie_Id INT NOT NULL,
Professional_Id INT,
IMDBEventId varchar(25) NOT NULL,
Category_Id INT NOT NULL,
CerimonyDate DATE NOT NULL,
CerimonyNumber SMALLINT NOT NULL,
MoviesReleasedIn SMALLINT NOT NULL,
FOREIGN KEY (Movie_Id) REFERENCES Movie(Id),
FOREIGN KEY (Professional_Id) REFERENCES Professional(Id),
FOREIGN KEY (Category_Id) REFERENCES OscarCategory(Id),
CONSTRAINT Unique_Category_CerimonyNumber UNIQUE (Category_Id,CerimonyNumber),
)




