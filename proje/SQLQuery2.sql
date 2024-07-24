
--musteriId=1 olan müþterinin kargolarýný sýralar
SELECT * FROM Kargo
WHERE musteriId =1
ORDER BY kargoId DESC; 

--Her müþterinin kaç ürün sipariþi olduðunu sayar
SELECT musteriId, COUNT(*) AS UrunSayisi
FROM Kargo
GROUP BY musteriId;

--Urun tablosundaki belirli markaya bakarak o markaya ait ürünleri renk ve stok sayýsý ile gösterir
SELECT urunId, urunIsmi, renkIsmi, urunStok
FROM Urun
JOIN Renk ON Urun.renkId = Renk.renkId
WHERE markaId = 0;

--Ürün tablosundaki en pahalý ürünü getiriyor
SELECT * FROM Urun WHERE urunFiyati IN(SELECT MAX(urunFiyati) FROM Urun)

--Kargonun tüm bilgilerini o kargonun ait olduðu müþterinin isim ve soyisimini getirir
SELECT Kargo.*, Musteri.musteriIsmi, Musteri.musteriSoyismi
FROM Kargo
JOIN Musteri ON Kargo.musteriId = Musteri.musteriId;

--Burada müþterileri harcamalarýna göre sýnýflandýrarak  1000tl üzerinde alýþveriþ yapaný buluruz
SELECT Musteri.musteriId, Musteri.musteriIsmi, SUM(Urun.urunFiyati) AS ToplamHarcama
FROM Musteri
JOIN Kargo ON Musteri.musteriId = Kargo.musteriId
JOIN Urun ON Kargo.urunId = Urun.urunId
GROUP BY Musteri.musteriId, Musteri.musteriIsmi
HAVING SUM(Urun.urunFiyati) > 1000;


--Her katergoride kaç ürün var?
SELECT Kategori.kategoriIsmi, COUNT(UrunKategorisi.urunId) AS ToplamUrun
FROM Kategori
LEFT JOIN UrunKategorisi ON Kategori.kategoriId = UrunKategorisi.kategoriId
GROUP BY Kategori.kategoriIsmi;

--Bir müþterinin, müþteri bilgilerini ve ait olduðu adres bilgilerini verir
SELECT Musteri.*, MusteriAdres.*
FROM Musteri
JOIN MusteriAdres ON Musteri.musteriId = MusteriAdres.musteriId;

--Her bi ürünün tüm bilgilerini ürünün ait olduðu kategori ismini her bi ürünün kategori bilgileri verir
SELECT Urun.*, Kategori.kategoriIsmi
FROM Urun
JOIN UrunKategorisi ON Urun.urunId = UrunKategorisi.urunId
JOIN Kategori ON UrunKategorisi.kategoriId = Kategori.kategoriId;

--Her bi kargonun tüm bilgilerini o kargonun ait olduðu kargo tipi ismi bilgilerini verir
SELECT Kargo.*, KargoTipi.tipIsmi
FROM Kargo
JOIN KargoTipi ON Kargo.kargotipiId = KargoTipi.kargotipiId;

--Her markanýn toplam stoðunu verir
SELECT Marka.markaIsmi, SUM(Urun.urunStok) AS ToplamStok
FROM Marka
LEFT JOIN Urun ON Marka.markaId = Urun.markaId
GROUP BY Marka.markaIsmi;

--urunId=0 olan ürünü satýn alan müþterilerin isim ve soyisimlerini veriyor
SELECT musteriIsmi,musteriSoyismi FROM Musteri WHERE EXISTS 
(SELECT * FROM Kargo WHERE
Musteri.musteriId=Kargo.kargoId and 
kargo.urunId=0);

--Müþteri ismi s ile baþlayanlarý getir
SELECT * FROM Musteri WHERE musteriIsmi LIKE 'S%';

--ürünleri markalarýyla veriyor
SELECT markaId, urunIsmi  AS urun
FROM Urun 
UNION
SELECT markaId, markaIsmi  AS marka
FROM Marka ;

--ürünfiyatý 100 ile 350 arasýndakileri getiriyor
SELECT urunIsmi, urunFiyati FROM Urun WHERE urunFiyati 
BETWEEN 100 AND 350;--Ýstanbul'daki tüm müþterileri görSELECT DISTINCT * FROM MusteriAdres WHERE il='Ýstanbul';--Her bir müþterinin il ve ilçesiSELECT musteriIsmi, musteriSoyismi, il,ilce FROM Musteri INNER JOIN MusteriAdresON Musteri.musteriId=MusteriAdres.musteriId--Müþterilerin sipariþ ettiði ürünlerin id'siSELECT musteriIsmi, musteriSoyismi,urunId FROM Musteri INNER JOIN KargoON Musteri.musteriId=Kargo.musteriId--Her markanýn en ucuz ürününü buluyorSELECT Marka.markaIsmi, MIN(Urun.urunFiyati) AS EnUcuzÜrün
FROM Marka
RIGHT JOIN Urun ON Marka.markaId = Urun.markaId
GROUP BY Marka.markaIsmi;

--Her markalarýn ortalama fiyatlarýný buluyorSELECT Marka.markaIsmi, AVG(Urun.urunFiyati) AS MarkanýnOrtalmaFiyatý
FROM Marka
RIGHT JOIN Urun ON Marka.markaId = Urun.markaId
GROUP BY Marka.markaIsmi;

--Ýstanbul dýþýnda yaþayan müþteriler
SELECT musteriId,musteriIsmi,musteriSoyismi  FROM Musteri WHERE NOT 
EXISTS (SELECT * FROM MusteriAdres WHERE
Musteri.musteriId=MusteriAdres.musteriId and 
il='Ýstanbul')
--Kargoyu Gel Al noktasýndan teslim alacak müþteriler ve bigileri
SELECT musteriIsmi,musteriSoyismi, musteriTel FROM Musteri WHERE EXISTS 
(SELECT * FROM Kargo WHERE
Musteri.musteriId=Kargo.kargoId and 
kargo.kargoTipiId=1);
--INSERT
INSERT INTO Musteri VALUES
('Sevgi','Yol','5476539026','3426'),('Furkan','Gündüz','5327604587','7654'),('Elif','San','5689860918','1812')
INSERT INTO Renk VALUES
('Almond Rose'),('Dusty Rose'),('Cool Pink'),('Peachy'),('Dramatic Red')
INSERT INTO Marka VALUES
('Duru'),('Elseve'),('Gillette'),('Hacý Þakir')
INSERT INTO Urun VALUES
('Dudak Kalemi 505','64','Yüksek kalýcýlýðý ve suya dayanýklýlýðý sayesinde dudak kalemi ile renklendirilen dudaklar uzun süre boyunca çekici bir görünüme sahip olur.'
,'https://img.gratis.com/mnpadding/475/475/ffffff/h3c/hbb/8824268521502/10959085_05.jpg',
0,80,3,0,'','')
INSERT INTO UrunKategorisi VALUES (2,11)
INSERT INTO Kargo VALUES (1,1,9,1,0),(2,1,6,1,0),(3,1,0,1,0),(4,1,8,1,0),(5,1,4,1,0),(6,1,11,1,0),(7,1,12,1,0),(8,13,10,0,1)

--UPDATE
UPDATE Urun SET urunFiyati=60 WHERE urunId=2
UPDATE Musteri SET musteriIsmi='Sýla' WHERE musteriIsmi='Aylin' AND musteriSoyismi='Tan'
UPDATE Kargo SET musteriId=6 WHERE kargoId=0
UPDATE MusteriAdres SET daireNo=2 WHERE musteriId=0
UPDATE UrunKategorisi SET kategoriId=9 WHERE urunId=0

--DELETE
DELETE FROM Renk WHERE renkId = 5;
DELETE FROM Marka WHERE markaId = 13;

--VIEW
CREATE VIEW KadýnÜrünleri AS 
SELECT urunIsmi FROM Urun WHERE cinsId=0;
SELECT*FROM KadýnÜrünleri;            

CREATE VIEW MusteriSiparisleri AS
SELECT Musteri.musteriId, musteriIsmi, musteriSoyismi, COUNT(Kargo.kargoId) AS KargoSayisi
FROM Musteri
JOIN Kargo ON Musteri.musteriId = Kargo.musteriId
GROUP BY Musteri.musteriId, musteriIsmi, musterisoyismi;
SELECT*FROM MusteriSiparisleri;

CREATE VIEW UrunlerinKategorileri AS
SELECT Urun.urunId, Urun.urunIsmi, Kategori.kategoriIsmi
FROM Urun
JOIN UrunKategorisi ON Urun.urunId = UrunKategorisi.urunId
JOIN Kategori ON UrunKategorisi.kategoriId = Kategori.kategoriId;
SELECT*FROM UrunlerinKategorileri;


CREATE VIEW fýyatý100fazla AS
SELECT * FROM Urun
WHERE urunFiyati > 100;
SELECT*FROM fýyatý100fazla;

CREATE VIEW KargoOdemeDetaylari AS
SELECT
    Kargo.kargoId,
    Urun.urunIsmi,
    Odeme.odemeTuruIsmi
FROM
    Kargo
JOIN
    Urun ON Kargo.urunId = Urun.urunId
JOIN
Odeme ON Kargo.odemeId = Odeme.odemeId;
SELECT*FROM KargoOdemeDetaylari;

---TRANSACTION
SELECT * FROM Musteri
BEGIN TRANSACTION
UPDATE Musteri SET musteriIsmi='Þevval' WHERE musteriId=12
UPDATE Musteri SET musteriTel='5695493366' WHERE  musteriIsmi='Deniz' AND musteriSoyismi='Ozan'
SAVE TRANSACTION SP1
INSERT INTO Musteri VALUES ('Veli','Tuna','5408746277','7777')
SAVE TRANSACTION SP2
DELETE FROM Musteri WHERE musteriId=14
INSERT INTO Musteri VALUES ('Orhan','Kanýk','5489096634','9374')
ROLLBACK TRANSACTION SP2
COMMIT
Select* FROM Musteri

---INDEX
CREATE INDEX idx_musteri_musterisoyismi ON Musteri(musteriSoyismi);
SELECT * FROM Musteri WHERE musteriSoyismi = 'Gündüz';

CREATE INDEX idx_urunId ON Urun(urunId);
SELECT * FROM Urun WHERE urunId=7;

CREATE INDEX idx_urunTablosu_markaId ON Urun(markaId);
SELECT * FROM Urun WHERE markaId<=3;

CREATE INDEX idx_kargo_musteriId ON Kargo(musteriId);
SELECT * FROM Kargo WHERE musteriId=1;

CREATE INDEX idx_musteriAdres_il_ilce ON MusteriAdres(il, ilce);
SELECT * FROM MusteriAdres WHERE il='Ýstanbul' AND ilce='Kadýköy';

--TRIGGER
CREATE TRIGGER trg_UrunTablosu_Delete
ON Urun
INSTEAD OF DELETE
AS
BEGIN
    DELETE FROM UrunKategorisi
    WHERE urunId IN (SELECT urunId FROM deleted);

    DELETE FROM Urun
    WHERE urunId IN (SELECT urunId FROM deleted);
END;



CREATE TRIGGER trg_MusteriAdres_Update
ON MusteriAdres
INSTEAD OF UPDATE
AS
BEGIN
    INSERT INTO MusteriAdresLog (musteriId, IslemTipi, IslemTarihi)
    SELECT musteriId, 'UPDATE', GETDATE()
    FROM inserted;

    UPDATE MusteriAdres
    SET mahalle = i.mahalle, cadde = i.cadde, sokak = i.sokak,
        binano = i.binano, daireno = i.daireno, ilce = i.ilce, il = i.il
    FROM MusteriAdres m
    INNER JOIN inserted i ON m.musteriId = i.musteriId;
END;

--Stored Procedure
CREATE PROCEDURE Musteri_Duzenle
    @EskiAd nvarchar(40),
    @YeniAd nvarchar(40),
    @YeniSoyad nvarchar(50),
    @YeniTel nvarchar(10),
    @YeniSifre nvarchar(4)
AS
BEGIN
    UPDATE Musteri
    SET musteriIsmi = @YeniAd,
        musteriSoyismi = @YeniSoyad,
        musteriTel = @YeniTel,
        musteriSifre= @YeniSifre
      
    WHERE musteriIsmi = @EskiAd;
END;

SELECT * FROM Musteri
EXEC Musteri_Duzenle
    @EskiAd = 'Kumru',
    @YeniAd = 'Aslý',
    @YeniSoyad = 'Ay',
    @YeniTel = '5374784268',
    @YeniSifre = '6457'
  SELECT * FROM Musteri




 CREATE PROCEDURE KategoriIsmi_Duzenle
    @EskiKategoriIsmi nvarchar(50),
    @YeniKategoriIsmi nvarchar(50)
AS
BEGIN
    UPDATE Kategori
    SET kategoriIsmi = @YeniKategoriIsmi
    WHERE kategoriIsmi = @EskiKategoriIsmi;
END;

SELECT * FROM Kategori
EXEC KategoriIsmi_Duzenle
    @EskiKategoriIsmi = 'Moda & Aksesuar',
    @YeniKategoriIsmi = 'Moda-Aksesuar'
SELECT * FROM Kategori













