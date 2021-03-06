/*
Filestream Demo

Steve Jones, copyright 2012 

This code is provided as is for demonstration purposes. It may not be suitable for
your environment. Please test this on your own systems. This code may not be republished 
or redistributed by anyone without permission.
You are free to use this code inside of your own organization.
*/

-- Unstructured Data
-- setup
-- Filestream - CD Documents, CD UnstructuredData
-- Explorer - c:\Program Files\Microsoft SQL Server\MSSQL

-- Configuration Manager
-- enable Filestream in Configuration Manager. Make sure the share name is set


-- check server setting
EXEC sp_configure
;
EXEC sp_configure filestream_access_level, 2;
GO
RECONFIGURE;
GO
-- if necessary, enable Filestream in instance properties


-- check filestream at database level
-- look at database properties.



-- check products:
USE AdventureWorks2008
;
GO
select 
  Title
, FileName
, FileExtension
, DocumentSummary
, Document
 from Production.Document;
 go


-- look at products with documents.
select 
  Title
, FileName
, FileExtension
, DocumentSummary
, Document
 from Production.Document
 where document is not null
 ;
go

-- Extract documents
-- Explorer  \Users\Steve\Documents\UnstructuredData
-- view .ps1

-- Open Explorer to \Users\Steve\Documents\Docs

-- Run Powershell



-- load data

-- create a new table
CREATE TABLE FSDemo
(
	id UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL UNIQUE
  , name VARCHAR(20)  
  , jpg varbinary(MAX) FILESTREAM
);
go

INSERT INTO FSDemo(ID, name, jpg) 
Values (NEWID()
      , 'circle.jpg'
      , 0xFFD8FFE000104A46494600010101006000600000FFE100684578696600004D4D002A000000080004011A0005000000010000003E011B0005000000010000004601280003000000010002000001310002000000120000004E00000000000000600000000100000060000000015061696E742E4E45542076332E352E313000FFDB0043000201010201010202020202020202030503030303030604040305070607070706070708090B0908080A0807070A0D0A0A0B0C0C0C0C07090E0F0D0C0E0B0C0C0CFFDB004301020202030303060303060C0807080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CFFC0001108000A000D03012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00E97FE0E87FF82CA7ED35FB04FED85E09F03FC2BD6A5F87BE1097408B5C4D523D2ADAF1BC41746795248CBDC4722F970848C18940399373E43478FD75FF00827CFC68F177ED17FB0FFC2AF1D78F3461A078C7C59E19B2D4F57B110B42B14F244199846DF346AFC384392A1C024E335E95E2EF87BE1FF880968BAF687A3EB6B612F9F6C2FECA3B916F27F7D3783B5BDC60D6C5007FFFD9
	  );
go
INSERT INTO FSDemo(ID, name, jpg) 
Values (NEWID()
      , 'uma.jpg'
      , (SELECT * FROM OPENROWSET(BULK N'C:\Users\sjones\Documents\Samples\Uma.jpg', SINGLE_BLOB) AS CategoryImage)
	  );
go

SELECT *
 FROM FSDemo
;


-- cleanup
-- delete files in \users\steve\documents\docs
DROP TABLE fsDemo;
go






test