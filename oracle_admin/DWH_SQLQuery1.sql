Create database MedicalDWH
Go
Use MedicalDWH
Go


Use MedicalDWH
Create table Maladie
(IdMaladie int primary key identity, TypeMaladie varchar(100), NomMaladie varchar(100))
Go


Use MedicalDWH
Create table Temps
(IdDate int primary key identity, CatMois varchar(100), Annee varchar(100))
Go

Use MedicalDWH
Create table Region
(IdRegion int primary key identity, Ville varchar(100), Commune varchar(100))
Go


Use MedicalDWH
Create table Patient
(IdPatient int primary key identity, Sexe varchar(100), CatAge int)
Go


Use MedicalDWH
Create table Direction 
(IdDirection int primary key identity, NomDirection varchar(100), Service varchar(100))
Go


Use MedicalDWH
Create Table Mesuree
(IdMesure bigint primary key identity, IdMaladie int , IdDate int, IdRegion int,
IdPatient int, IdDirection int, Nbmalade int)
Go


Use MedicalDWH
ALTER TABLE Mesuree ADD CONSTRAINT IdMaladie FOREIGN KEY(IdMaladie) REFERENCES Maladie(IdMaladie) ;
ALTER TABLE Mesuree ADD CONSTRAINT IdDate FOREIGN KEY (IdDate) REFERENCES Temps(IdDate) ;
AlTER TABLE Mesuree ADD CONSTRAINT IdRegion FOREIGN KEY (IdRegion) REFERENCES Region(IdRegion) ;
AlTER TABLE Mesuree ADD CONSTRAINT IdPatient FOREIGN KEY (IdPatient) REFERENCES Patient(IdPatient) ;
AlTER TABLE Mesuree ADD CONSTRAINT IdDirection FOREIGN KEY (IdDirection) REFERENCES Direction(IdDirection) ;
Go
