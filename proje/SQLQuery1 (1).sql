CREATE TABLE Renk(
renkId INT NOT NULL PRIMARY KEY IDENTITY(0,1),
renkIsmi NVARCHAR(25) NOT NULL
)

CREATE TABLE UrunMusteriCinsi(
cinsId INT NOT NULL PRIMARY KEY IDENTITY(0,1),
cinsIsmi NVARCHAR(6) NOT NULL,
)

CREATE TABLE MiktarBirimi(
birimId INT NOT NULL PRIMARY KEY IDENTITY(0,1),
birimIsmi NVARCHAR(6) NOT NULL
)

CREATE TABLE Marka(
markaId INT NOT NULL PRIMARY KEY IDENTITY(0,1),
markaIsmi NVARCHAR(30) NOT NULL,
)

CREATE TABLE Odeme(
odemeId INT NOT NULL PRIMARY KEY IDENTITY(0,1),
odemeTuruIsmi NVARCHAR(10) NOT NULL
)
ALTER TABLE Odeme
DROP COLUMN odemeTuruIsmi --odemeTuruIsmi sütununu siler

ALTER TABLE Odeme
ADD odemeTuruIsmi NVARCHAR(30) 


CREATE TABLE Kategori(
kategoriId INT NOT NULL PRIMARY KEY IDENTITY(0,1),
kategoriIsmi NVARCHAR(50) NOT NULL,
kategoriAciklamasi NVARCHAR(400)
)
ALTER TABLE Kategori
DROP COLUMN kategoriAciklamasi --kategoriAciklamasi sütununu komple kaldýrýr



CREATE TABLE KargoTipi(
kargoTipiId INT NOT NULL PRIMARY KEY IDENTITY(0,1),
tipIsmi INT NOT NULL
)

ALTER TABLE KargoTipi
ALTER COLUMN tipIsmi NVARCHAR(30); --tipIsmi sütununun veri tipini NVARCHAR(30) olarak deðiþtirdik


CREATE TABLE Musteri(
musteriId INT NOT NULL PRIMARY KEY IDENTITY(0,1),
musteriIsmi NVARCHAR(40) NOT NULL ,
musteriSoyismi NVARCHAR(50) NOT NULL,
musteriTel NVARCHAR(10),
musteriSifre NVARCHAR(4) NOT NULL
)


ALTER TABLE Musteri
ADD UNIQUE(musteriTel) --musteriIsmi'nin UNIQUE kýsýtýný kaldýrýr


CREATE TABLE MusteriAdres(
kayýtNo INT NOT NULL PRIMARY KEY IDENTITY(0,1),
musteriId INT NOT NULL,
mahalle NVARCHAR(20) NOT NULL,
cadde NVARCHAR(20) NOT NULL,
sokak NVARCHAR(20) NOT NULL,
binaNo NVARCHAR(5) NOT NULL,
daireNo INT NOT NULL,
ilce NVARCHAR(20) NOT NULL,
il NVARCHAR(15) NOT NULL
)

ALTER TABLE MusteriAdres
ADD FOREIGN KEY (musteriId) REFERENCES Musteri (musteriId) --musteriId foreign key özelliði ver


CREATE TABLE Urun(
urunId INT NOT NULL PRIMARY KEY IDENTITY(0,1),
urunIsmi NVARCHAR(75) NOT NULL,
urunFiyati money NOT NULL,
urunDetayi NVARCHAR(4000),
urunGorseli NVARCHAR(255) NOT NULL,
markaId INT NOT NULL,
urunStok INT NOT NULL,
renkId INT ,
cinsId INT ,
urunMiktari INT ,
birimId INT 
)

ALTER TABLE Urun
ADD UNIQUE(urunGorseli)

ALTER TABLE Urun
ADD FOREIGN KEY (markaId) REFERENCES Marka (markaId)
ALTER TABLE Urun
ADD FOREIGN KEY (renkId) REFERENCES Renk (renkId)
ALTER TABLE Urun
ADD FOREIGN KEY (cinsId) REFERENCES UrunMusteriCinsi (cinsId)
ALTER TABLE Urun
ADD FOREIGN KEY (birimId) REFERENCES MiktarBirimi (birimId)


CREATE TABLE UrunKategorisi(
say INT NOT NULL PRIMARY KEY IDENTITY(0,1),
kategoriId INT NOT NULL ,
urunId INT NOT NULL 
)

ALTER TABLE UrunKategorisi
ADD FOREIGN KEY (kategoriId) REFERENCES Kategori (kategoriId)
ALTER TABLE UrunKategorisi
ADD FOREIGN KEY (urunId) REFERENCES Urun (urunId)


CREATE TABLE Kargo(
kargoId INT NOT NULL PRIMARY KEY,
musteriId INT NOT NULL,
urunId INT NOT NULL,
odemeId INT NOT NULL,
kargoTipiId INT NOT NULL
)

ALTER TABLE Kargo
ADD FOREIGN KEY (musteriId) REFERENCES Musteri (musteriId)
ALTER TABLE Kargo
ADD FOREIGN KEY (urunId) REFERENCES Urun (urunId)
ALTER TABLE Kargo
ADD FOREIGN KEY (odemeId) REFERENCES Odeme (odemeId)
ALTER TABLE Kargo
ADD FOREIGN KEY (kargoTipiId) REFERENCES KargoTipi (kargoTipiId)






