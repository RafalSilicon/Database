-- *****************************************************
-- Create ' publishing_house ' schema
-- *****************************************************

CREATE SCHEMA IF NOT EXISTS publishing_house;

USE publishing_house;

-- *****************************************************
-- Create tables
-- *****************************************************

-- create table Author
-- create table Printing_Hous
-- create table Book_Shop
-- create table Terms_Of_Sale - A new table has been created from the 'Sale' table to follow the 3NF normalisation rules
-- create table Manuscript
-- create table Book
-- create table Sale - The 'Periot', 'saleNo', 'percentage', 'lowAmount' and 'HighAmount" have been removed from the table as not relevant to the particular process. A new table has been created from 'termsOfSale'.

-- ***********************************************************************************************************************
-- Several changes have been made to improve the operation of the database, details in the comments next to the attributes
-- ***********************************************************************************************************************

Create table Author (										
PPSN			varchar(9),		not null,	# modified from ‘authorid’. PPSN is always 7 numbers followed by either one or 2 letters
fName 			varchar(30) 	not null,	# ‘biography’ and 'contribution' were removed as an irrelevant attribute for the project
lName			varchar(30) 	not null, 
street1			varchar(60) 	not null, 	# modified from ‘street’
street2			varchar(60) 	null,		# modified from ‘address’
postcode		varchar(8) 		not null,
city			varchar(20) 	not null, 	# the publishing house cooperates only with authors living in Ireland
email			varchar(30)		not null,
tel				varchar(12) 	not null,
payRate 		double(9,2) 	null,		# warning 1681 can be removed by deleting the value (9,2) on the 'double' variable
paymentData		date 			null, 
advancePayment	double(9,2) 	null,		# warning 1681 can be removed by deleting the value (9,2) on the 'double' variable
primary key (PPSN));

Create table Printing_House (
printHouseId	int(2) 		auto_increment 	not null,	# warning 1681 can be removed by deleting the value (2) on the 'int' variable
printHouseName 	varchar(60) 				not null,	
street1			varchar(60) 				not null, 	# modified from ‘street’
street2			varchar(60) 				null,		# modified from ‘address’
postcode		varchar(8) 					not null,
city			varchar(20) 				not null, 	
country			varchar(56) 				not null, 	# added attribute
email			varchar(30)					not null,
tel				varchar(12) 				not null,
primary key (printHouseId));

Create table Book_Shop  (
bookShopId		int(3)		auto_increment	not null,	# warning 1681 can be removed by deleting the value (3) on the 'int' variable
bookShopName 	varchar(60) 				not null,	# modified from ‘name’
street1			varchar(60) 				not null, 	# modified from ‘street’
street2			varchar(60) 				null,		# modified from ‘address’
postcode		varchar(8) 					not null,
city			varchar(20) 				not null, 	
country			varchar(56) 				not null,	# added attribute
email			varchar(30)					not null,
tel				varchar(12) 				not null,
primary key (bookShopId));

create table Terms_Of_Sale (
termsOfSaleId	varchar(6)		not null,
typeOfTrade		varchar(27) 	not null,
Primary key (termsOfSaleId));

Create table Manuscript (
manuscriptId	varchar(5)		not null,
manuscriptType	varchar(8)		not null,
manuscriptPrice double(9,2)		not null,	# warning 1681 can be removed by deleting the value (9,2) on the 'double' variable
publicDate		date			not null,
pagesNo			int				null,
notes			text 			null,
PPSN			varchar(9)		not null,
printHouseId	int(2)			not null,	# warning 1681 can be removed by deleting the value (2) on the 'int' variable
primary key (manuscriptId),
foreign key (PPSN) references Author(PPSN) on update cascade on delete no action,
foreign key (printHouseId) references Printing_House(printHouseId) on update cascade on delete no action);

create table Book (
ISBN 			varchar(13) 	not null,
title 			varchar(100) 	not null,
pagesNo 		int(4)			null,		# warning 1681 can be removed by deleting the value (4) on the 'int' variable
publisher 		varchar(5) 		not null,	# modified from ‘publishInfo’ and name of 'publishing_house' is 'Big A'
publicationDate date 			not null,
price 			decimal(5,2) 	not null,
bookDescr 		varchar(255) 	null,  		# a brief note on the content of the book, modified from 'textBook'
printHouseId	int(2) 			not null,	# warning 1681 can be removed by deleting the value (2) on the 'int' variable
PPSN			varchar(9)		not null,
primary key (ISBN),
foreign key (printHouseId) references Printing_House(printHouseId) on update cascade on delete no action,
foreign key (PPSN) references Author(PPSN) on update cascade on delete no action);

create table Sale (															
transactionId	varchar(6)		not null,	# modified from ‘accountId’
saleDate		date			not null, 
quantity 		int				not null, 								 
dueDate			date			not null,	# modified from ‘time’ 
ISBN 			varchar(13), 
bookShopId		int(3),			# warning 1681 can be removed by deleting the value (3) on the 'int' variable
termsOfSaleId	varchar(6),
Primary key (transactionId),
Foreign key (ISBN) references Book(ISBN) on update cascade on delete no action,
Foreign key (termsOfSaleId) references Terms_Of_Sale(termsOfSaleId) on update cascade on delete no action,
Foreign key (bookshopId) references Book_Shop(bookshopId) on update cascade on delete no action);


-- ***********************************************************************************************************************
-- Populate tables data
-- ***********************************************************************************************************************

insert into Author values 
('7700225VH','Dominique','Tackley','1 Graceland Way','Northwood Avenue','D09 X6X4','Fingal','dtackley0@amazon.co.jp','252-993-4559',66303.06,'2022-11-15',89979.01),
('5452407DH','Liuka','Finicj','8 Mifflin Drive','Ballincar Heights','F91 DK74','Sligo','lfinicj1@bloglines.com','871-961-7838',80864.74,'2023-01-28',58233.95),
('1241125LH','Patricia','Learoid','603 Jordanstown Road',NULL,'D24 HW25','Dublin','plearoid2@zimbio.com','518-898-0602',8845.79,'2022-07-27',58800.05),
('6993459TH','Filmer','Crucetti','14 Caledon Road',NULL,'D01 Y161','Dublin','fcrucetti3@myspace.com','258-487-4495',81980.10,'2022-01-21',63790.54),
('4115381JA','Natividad','Mardoll','Harcourt Green','Peter Place','D02 FW64','Dublin','nmardoll4@auda.org.au','252-901-4070',16452.59,'2022-08-21',76756.11),
('8268048MA','Caren','Stirgess','18 Terenure Road West',NULL,'D06 K767','Dublin','cstirgess5@zdnet.com','267-210-2408',64270.63,'2023-02-23',14393.40),
('4835734QA','Leland','Senn','5 Woodford Heights','Evergreen','D22 C5P3','Clondalkin','lsenn6@4shared.com','688-502-3402',49302.43,'2022-09-03',33780.60),
('9857460SH','Gladys','Viney','11 The Glen',NULL,'X91 KR8A','Waterford','gviney7@theguardian.com','412-261-9115',91143.74,'2022-05-18',25568.39),
('7141506RA','Maurise','Tweddell','51 Village Green Lane','Wainsfort Manor Crescent','D12 P5YP','Dublin','mtweddell8@google.com.au','407-911-5967',65222.43,'2022-04-09',70460.06),
('0691084DH','Ondrea','Bronger','Churchfield','L3114','V94 XTN1','Ballybrown','obronger9@yellowpages.com','555-551-7849',80183.98,'2022-03-01',61418.14),
('5484880UA','Prudence','Lackinton','6 Kilkenny Road',NULL,'V91 XTV9','Ballybrown','plackintona@meetup.com','853-641-5396',44365.37,'2022-09-04',98346.65),
('7814326FH','Iorgo','Walklate','9 Nenagh','Old Birr Road','E45 A027','Ballymagree','iwalklateb@hugedomains.com','642-693-5344',93466.26,'2023-02-12',32812.63),
('7492680UH','Shelden','Hosby','25 Chestnut Grove',NULL,'A86 YE37','Dunboyne','shosbyc@parallels.com','283-396-5957',33937.07,'2023-01-14',58025.19),
('1059277ZH','Camey','MacCrossan','63 Johnson Road','Mothel Lane','R95 A972','Dunmore','cmaccrossand@hhs.gov','488-171-9079',11120.75,'2022-10-25',69883.42),
('4559216DA','Sarah','Eannetta','7 The Creek Pitch and Putt','Edmondstown Road','D16 C6T4','Edmondstown','seannettae@icio.us','672-151-4631',92322.80,'2022-09-06',45724.07);

insert into Printing_House values
(01,'Simonis-Orn','378 Towne Circle','Arapahoe','NK3 VG','Hutang','China','rsnyder0@dedecms.com','540-719-7257'),
(02,'Krajcik, Reichert and Brakus','8 Granby Circle','Hagan','HJ2  HH','Kafr Zayt?','Syria','kgreser1@umich.edu','373-995-8404'),
(03,'Schaden, Kerluke and Walsh','090 Westridge Drive','Marcy','W3E H2','Huangmei','China','osehorsch2@cloudflare.com','541-843-9803'),
(04,'Buckridge, Bergstrom and Weber','3 Nova Crossing','Esch','5556-000','Barreiros','Brazil','amawby3@slashdot.org','732-118-8832'),
(05,'Moore, Hagenes and Kassulke','17782 Kings Street','Acker','9390-000','Ivoti','Brazil','chabberjam4@columbia.edu','969-247-7411'),
(06,'Lockman-Feest','964 Nevada Center','Dennis','4023','San Pedro','Philippines','dmulrenan5@addtoany.com','195-837-7560'),
(07,'Hilpert-Kuhlman','39 Ilene Pass','Packers','D04','Sandyford','Ireland','bsibbons6@123-reg.co.uk','243-196-9151'),
(08,'Kuphal Inc','76 Springs Terrace','Morningstar','29-480','San Agustin','Mexico','tkilbey7@noaa.gov','423-454-6460'),
(09,'Farrell and Sons','77 Division Center','Commercial','20-354','Isla Puc�','Paraguay','mvasyunkin8@usgs.gov','483-453-0805'),
(10,'Shields, Auer and Fay','76 Roth Avenue','Towne','37-215','Lucun','China','hmacfadyen9@discovery.com','273-331-5952'),
(11,'Davis and Sons','26 Summerview Park','Sugar','52-740','Loma Bonita','Mexico','agyvera@is.gd','240-701-6033'),
(12,'Haley, Dicki and Quigley','608 Oak Trail','Pleasure','ZX 5706','Lawa-an','Philippines','jjaffrayb@irs.gov','833-294-4229'),
(13,'Hayes Group','16882 Ilene Trail',NULL,'BU 8746','Dajin','China','abustardc@seesaa.net','154-116-9350'),
(14,'Reilly-Conroy','9040 Morningstar Road','Bobwhite','302-21','Yueyang','China','dhabornd@mapquest.com','431-773-7151'),
(15,'Quigley Inc','0959 Oriole Terrace','Spaight','485-21','Legok','Indonesia','sbagotte@netscape.com','922-294-3712'),
(16,'Rolfson, Lindgren and Zulauf','801 Transport Alley','Ohio','35940-00','Rio Piracicaba','Brazil','lhelksf@bloglines.com','303-939-7739');

insert into Book_Shop values
(001,'Stracke, Hammes and Nolan','94 Cardinal Place','Mcguire','DD10 9JH','Tyres�','Sweden','agrealy0@cornell.edu','893-378-0737'),
(002,'Schamberger and Sons','931 Warbler Plaza','Warner','OL1 1SN','Naukot','Pakistan','wwearden1@meetup.com','753-836-2457'),
(003,'Jenkins-Bednar','42 Crowley Terrace','Harper','EN6 2HN','Nangakeo','Indonesia','brushton2@webeden.co.uk','794-771-0770'),
(004,'Yundt, Goyette and Kuhic','582 Rutledge Drive','Forest Dale','LE14 4HQ','Pocpo','Bolivia','bleechman3@people.com.cn','260-562-8525'),
(005,'Sporer-Becker','20273 Muir Alley','Northfield','LA2 0ES','Cintra','Argentina','gmardy4@people.com.cn','157-320-5267'),
(006,'Lueilwitz Inc','08444 Lakewood Gardens Road','Dorton','SE1 2ND','Bayt Maqd?m','Palestinian Territory','ggrigolashvill5@is.gd','700-861-3997'),
(007,'Wuckert-Jenkins','6 Warner Trail','Oak Valley','TA6 6QJ','Thanh N�','Vietnam','vstorr6@360.cn','228-450-2168'),
(008,'Sawayn Group','869 Loftsgordon Pass','Straubel','N16 0QL','Ohrid','Macedonia','rcranton7@foxnews.com','403-481-6727'),
(009,'Cassin-Dickinson','5636 Acker Avenue','Magdeline','SN13 8LN','Kopral','Indonesia','acuschieri8@ow.ly','298-302-9305'),
(010,'Wisozk-Ortiz','0176 Schmedeman Point','Pond','WA14 3RB','Annonay','France','tfairbourne9@livejournal.com','189-173-5982'),
(011,'Sauer, Senger and Von','98437 Mallory Hill','Eagan','BA11 5AH','Jinshandian','China','nsimonsona@vistaprint.com','739-505-5348'),
(012,'Heathcote LLC','762 Esker Junction','Crowley','ST4 5BU','Gaotan','China','nlomazb@washingtonpost.com','285-387-9779'),     
(013,'Kovacek Group','3689 Donald Alley','Burning Wood','WA14 2SW','Canillo','Andorra','bdrayec@domainmarket.com','490-157-9804'),     
(014,'Botsford, Treutel and Boehm','35 Gina Park','Anderson','TF1 5TL','Min?f','Egypt','mchrystied@intel.com','112-272-4922'),     
(015,'Hilll-Watsica','0827 Transport Lane','Orin','IP28 8WG','San Miguel','Peru','ngrisdalee@theglobeandmail.com','836-409-4985'),     
(016,'Kautzer, Schoen and Marquardt','0072 Dovetail Pass','Towne','CF44 7PS','Magtangol','Philippines','vmuxworthyf@clickbank.net','701-417-6852'),     
(017,'Shanahan Group','2 Grover Street','Huxley','B33 8DW','B�guanos','Cuba','jgoghing@cmu.edu','627-728-8579'),     
(018,'Veum, Hyatt and Hudson','37 Bashford Center','Mosinee','W5 3BF','Kunduz','Afghanistan','mgregorettih@com.com','313-103-5951'),     
(019,'Grimes, Casper and McGlynn','6396 Buena Vista Avenue','Hansons','IV30 5SR','Tarrafal','Cape Verde','awylemani@gov.uk','761-856-2212'),     
(020,'Boyle-Hilpert','10636 Buena Vista Terrace','Lillian','RH17 5RF','Shabel?skoye','Russia','ahebbornej@multiply.com','326-649-9242'),     
(021,'Krajcik-Schiller','3 Melvin Lane','Logan','ME20 6RA','Huagai','China','mthameltk@1688.com','315-578-4686'),     
(022,'Wisoky-Emmerich','5961 Glacier Hill Park','Kedzie','BB11 2PG','Nihommatsu','Japan','lmaycockl@g.co','281-123-6832'),     
(023,'Kovacek, Pollich and Kemmer','3 Porter Point','Gateway','E15 3LE','Kasamwa','Tanzania','rpischoffm@canalblog.com','493-925-7973'),     
(024,'Bode-Kuvalis','603 Northridge Hill','Westridge','FY6 7JY','Lisiy Nos','Russia','isullensn@jugem.jp','888-879-7379'),     
(025,'Hermann Group','432 Lakewood Way','Dawn','BS39 5AL','Varberg','Sweden','sgiveso@shop-pro.jp','555-679-1899'),     
(026,'Brekke, Lang and Kub','08258 Redwing Park','Shelley','CO13 0EW','Tewulike','China','aducarelp@harvard.edu','202-873-7773'),     
(027,'Metz, O''Connell and Schmitt','13248 Troy Court','Continental','CH41 2ZL','Remedios','Cuba','jgoutq@examiner.com','928-972-8367'),     
(028,'Morissette-Dickens','40 Kings Pass','Golf Course','DE21 4JF','Carnaxide','Portugal','mgleesonr@bloglines.com','337-497-9358'),     
(029,'MacGyver-Kilback','81732 Schurz Junction','Knutson','DN9 1AD','Baimangpu','China','jfrights@bluehost.com','880-522-2448'),     
(030,'Jerde-Considine','526 Alpine Alley','Hermina','CB23 7GB','El Triunfola Cruz','Honduras','dbeiderbeckt@a8.net','191-700-6959'),     
(031,'White Inc','31 West Pass','Heath','ME16 9EY','Kyonju','South Korea','hlinnellu@vimeo.com','265-726-8004'),     
(032,'Yundt, Feil and Thiel','3863 Crowley Drive','Rieder','FK1 5HZ','Tiko','Cameroon','lbucklandv@earthlink.net','850-662-1565'),     
(033,'Murray, Hessel and Crona','5992 International Lane','Russell','DN5 7RS','Kokshetau','Kazakhstan','fwrothamw@upenn.edu','546-917-4263'),     
(034,'Schulist-O''Kon','759 Lukken Court','Service','LN4 3NG','Al Muwayh','Saudi Arabia','sorrumx@eepurl.com','924-852-8554'),    
(035,'Walter LLC','416 Mesta Court','Bultman','NR4 7AX','Guohe','China','olowley@51.la','320-712-5485'),     
(036,'Barrows Group','8 Merry Junction','Crowley','DG2 7ET','Khairpur','Pakistan','brickesiesz@phoca.cz','151-224-7090'),     
(037,'Rodriguez, Smith and Miller','37388 Atwood Plaza','Bay','BB6 7HN','Timash�vsk','Russia','jbrandin10@uol.com.br','848-520-3808'),     
(038,'Rowe-Boyer','0 Bluejay Drive','Moulton','JE2 3BF','Baraya','Colombia','fdelayglesias11@nba.com','418-779-2929'),     
(039,'Abernathy, Kautzer and Pfeffer','0 Northridge Avenue','Calypso','SR8 3BH','Nanhe','China','gthornham12@w3.org','454-391-4848'),     
(040,'Conn, Mohr and Conn','9 Lien Center','Buell','38-610','Pola?czyk','Poland','ebackler13@mayoclinic.com','453-173-6605');

insert into Terms_Of_Sale value
('TOS001','Loco'),
('TOS002','On the Spot'),
('TOS003','At Station'),
('TOS004','Free on Rail'),
('TOS005','Free Along Ship'),
('TOS006','Free on Board'),
('TOS007','Cost and Freight'),
('TOS008','Cost, Insurance and Freight'),
('TOS009','Ex- Ship'),
('TOS010','Franco');

insert into Manuscript value
('M001','softcopy',15498.00,'2022-06-08',491,NULL,'4559216DA',11),      
('M002','softcopy',26366.00,'2022-09-05',527,NULL,'5484880UA',02),      
('M003','softcopy',190837.00,'2022-03-28',239,NULL,'1764260BA',04),      
('M004','softcopy',24188.00,'2022-08-27',247,NULL,'5452407DH',06),      
('M005','softcopy',84755.00,'2022-06-20',270,NULL,'7814326FH',02),      
('M006','softcopy',16388.00,'2022-06-14',587,NULL,'7300327AA',11),      
('M007','softcopy',68288.00,'2022-05-22',464,NULL,'4559216DA',11),      
('M008','hardcopy',49498.00,'2022-11-02',752,NULL,'5452407DH',13),      
('M009','softcopy',22724.00,'2022-09-28',644,NULL,'1764260BA',03),      
('M010','softcopy',57255.00,'2022-01-13',598,NULL,'4835734QA',11),      
('M011','hardcopy',19804.00,'2022-11-29',62,NULL,'4559216DA',08),      
('M012','softcopy',19652.00,'2022-09-15',378,NULL,'7300327AA',10),      
('M013','softcopy',24045.00,'2022-07-19',328,NULL,'1764260BA',13),      
('M014','softcopy',43730.00,'2022-03-21',230,NULL,'5452407DH',06),      
('M015','softcopy',80422.00,'2022-01-21',797,NULL,'9857460SH',07),      
('M016','softcopy',10029.00,'2022-11-26',494,NULL,'4559216DA',03),      
('M017','hardcopy',129675.00,'2022-03-10',154,NULL,'1241125LH',08),      
('M018','softcopy',27145.00,'2022-02-08',435,NULL,'8268048MA',04),      
('M019','softcopy',15504.00,'2022-09-12',449,NULL,'7300327AA',03),      
('M020','hardcopy',10352.00,'2022-11-16',705,NULL,'5452407DH',10),      
('M021','softcopy',44681.00,'2022-01-17',592,NULL,'1241125LH',05),      
('M022','hardcopy',24963.00,'2022-03-27',79,NULL,'1764260BA',11),      
('M023','softcopy',21744.00,'2022-04-13',417,NULL,'5452407DH',16),      
('M024','softcopy',14566.00,'2022-10-11',498,NULL,'4835734QA',16),      
('M025','hardcopy',12560.00,'2022-10-21',738,NULL,'7492680UH',16),      
('M026','hardcopy',12432.00,'2022-06-20',80,NULL,'5452407DH',15),      
('M027','hardcopy',135264.00,'2022-08-28',168,NULL,'1241125LH',10),      
('M028','hardcopy',11921.00,'2022-09-15',69,NULL,'1764260BA',14),      
('M029','softcopy',91307.00,'2022-01-12',275,NULL,'5452407DH',13),      
('M030','hardcopy',7763.00,'2021-12-31',74,NULL,'7492680UH',05),      
('M031','softcopy',106691.00,'2022-06-08',570,NULL,'9857460SH',16),      
('M032','hardcopy',24095.00,'2022-08-15',89,NULL,'4835734QA',07),      
('M033','softcopy',116207.00,'2022-05-08',253,NULL,'1764260BA',11),      
('M034','softcopy',130458.00,'2022-05-22',858,NULL,'8268048MA',10),      
('M035','softcopy',21917.00,'2022-10-26',587,NULL,'7492680UH',03),      
('M036','softcopy',106453.00,'2022-08-20',245,NULL,'0691084DH',15),      
('M037','softcopy',49543.00,'2022-07-25',630,NULL,'1059277ZH',12),      
('M038','hardcopy',19281.00,'2022-10-12',119,NULL,'7141506RA',14),      
('M039','softcopy',126780.00,'2022-10-16',402,NULL,'7492680UH',08),      
('M040','softcopy',16566.00,'2022-07-04',377,NULL,'8268048MA',02),      
('M041','softcopy',86174.00,'2021-12-25',767,NULL,'1059277ZH',12),      
('M042','softcopy',149741.00,'2022-03-21',332,NULL,'7814326FH',15),      
('M043','softcopy',23098.00,'2022-03-02',534,NULL,'4115381JA',07),      
('M044','softcopy',117601.00,'2022-06-05',382,NULL,'7492680UH',16),      
('M045','softcopy',103393.00,'2022-10-06',652,NULL,'4115381JA',02),      
('M046','hardcopy',242699.00,'2022-04-22',678,NULL,'0691084DH',05),      
('M047','softcopy',175863.00,'2022-11-18',426,NULL,'1059277ZH',05),      
('M048','softcopy',148249.00,'2022-05-22',358,NULL,'1241125LH',04),      
('M049','softcopy',192376.00,'2022-11-14',772,NULL,'4559216DA',13),      
('M050','softcopy',50652.00,'2022-05-25',438,NULL,'6993459TH',16),      
('M051','hardcopy',44438.00,'2022-10-01',187,NULL,'7141506RA',05),      
('M052','softcopy',30595.00,'2022-03-03',791,NULL,'1059277ZH',01),      
('M053','softcopy',47397.00,'2022-02-13',591,NULL,'6993459TH',07),      
('M054','hardcopy',75802.00,'2022-08-06',173,NULL,'7492680UH',04),      
('M055','softcopy',23506.00,'2022-06-21',229,NULL,'1059277ZH',16),      
('M056','hardcopy',69630.00,'2022-11-25',207,NULL,'5452407DH',07),      
('M057','hardcopy',88985.00,'2022-11-06',153,NULL,'4115381JA',06),      
('M058','softcopy',227152.00,'2022-05-01',458,NULL,'6993459TH',13),      
('M059','softcopy',22674.00,'2022-10-01',873,NULL,'1059277ZH',05),      
('M060','softcopy',46786.00,'2022-01-25',476,NULL,'5484880UA',05);

insert into Book value
('970859003-7','And Birds',572,'Big A','2022-03-30',69.77,NULL,09,'7700225VH'),    
('249558707-0','Active In My Friends',628,'Big A','2022-05-30',19.26,NULL,07,'5452407DH'),    
('892864445-3','Agents And Figures',748,'Big A','2022-02-16',15.81,NULL,11,'1241125LH'),    
('045654337-6','Alerted By A New War',897,'Big A','2022-03-22',16.21,NULL,01,'6993459TH'),    
('524836856-1','Alerted By The End Of The Sun',463,'Big A','2022-04-15',85.1,NULL,02,'4115381JA'),    
('537651347-5','Ambition Of The Universe',266,'Big A','2022-07-18',52.52,NULL,08,'8268048MA'),    
('632704163-9','Angry With My Parents',133,'Big A','2022-06-30',91.19,NULL,03,'4835734QA'),    
('730554235-0','Bags In The Window',824,'Big A','2022-11-11',16.62,NULL,07,'9857460SH'),    
('418528606-6','Bane Of Doom',363,'Big A','2022-07-17',15.92,NULL,16,'7141506RA'),    
('321003524-5','Basic The Intruders',808,'Big A','2022-07-18',17.57,NULL,14,'0691084DH'),    
('741496498-1','Bathing In My Family',292,'Big A','2022-07-29',17.74,NULL,06,'5484880UA'),    
('550374512-4','Battle Of The Dead',94,'Big A','2021-12-20',82.61,NULL,13,'7814326FH'),    
('965945552-6','Begging The World',679,'Big A','2022-08-29',37.16,NULL,01,'7492680UH'),    
('872319595-9','Betrayal Of The Moon',715,'Big A','2022-11-06',15.71,NULL,10,'1059277ZH'),    
('212008379-7','Bleeding In The North',191,'Big A','2022-07-22',28.27,NULL,08,'4559216DA'),    
('516285507-3','Blindd By The Stars',403,'Big A','2022-03-15',13.99,NULL,07,'1764260BA'),    
('188185830-8','Call To My Enemies',459,'Big A','2022-04-22',68.5,NULL,02,'7300327AA'),    
('298865138-8','Call To My School',441,'Big A','2022-04-13',28.62,NULL,10,'7700225VH'),    
('574953993-8','Calling The Soldier',319,'Big A','2022-01-21',64.4,NULL,01,'5452407DH'),    
('779018756-2','Captured In Apartment B',271,'Big A','2022-03-07',7.71,NULL,08,'1241125LH'),    
('674681077-1','Carvings Of Our Destiny',438,'Big A','2022-08-29',43.82,NULL,05,'6993459TH'),    
('459866446-0','Cause With Silver Hair',239,'Big A','2022-01-10',90.07,NULL,16,'4115381JA'),    
('101404974-1','Closed For The End Of The Sun',684,'Big A','2022-06-21',8.69,NULL,09,'8268048MA'),    
('743074088-X','Colors Of Neverland',128,'Big A','2022-05-25',18.96,NULL,12,'4835734QA'),    
('767875390-X','Confused By The Secrets',589,'Big A','2022-01-12',82.87,NULL,08,'9857460SH'),    
('811547695-1','Creatures And Creatures',156,'Big A','2022-09-02',11.72,NULL,06,'7141506RA'),    
('807319208-X','Crows And Foreigners',477,'Big A','2022-07-20',11.07,NULL,16,'7700225VH'),    
('591650155-2','Culling Of Outer Space',706,'Big A','2022-01-16',99.14,NULL,15,'5452407DH'),    
('909066713-X','Dead In The World',296,'Big A','2022-03-17',38.06,NULL,15,'1241125LH'),    
('203214412-3','Defiant In History',388,'Big A','2022-10-06',18.81,NULL,07,'6993459TH'),    
('987297814-X','Descendants Of Breaking Hearts',166,'Big A','2022-09-27',71.59,NULL,07,'4115381JA'),    
('161401820-0','Elegance Of The Lands',826,'Big A','2022-07-16',29.99,NULL,13,'8268048MA'),    
('713341857-6','End Of The Void',509,'Big A','2022-05-13',97.77,NULL,08,'4835734QA'),    
('716941533-X','Father Of My Space Journey',360,'Big A','2022-08-10',10.98,NULL,10,'9857460SH'),    
('046671670-2','Fears Of Tomorrow',68,'Big A','2022-03-21',62.72,NULL,15,'7141506RA'),    
('959510533-3','Fires Of The Lakes',796,'Big A','2022-07-28',64.24,NULL,03,'0691084DH'),    
('164777015-7','Fish And Mouse',205,'Big A','2022-03-10',23.99,NULL,14,'7700225VH'),    
('895882534-0','Flying Into The Past',261,'Big A','2022-04-10',165.5,NULL,13,'5452407DH'),    
('778481197-7','Followers And Knights',695,'Big A','2022-10-09',14.92,NULL,11,'1241125LH'),    
('100093682-1','Fools Of The South',572,'Big A','2022-05-03',66.88,NULL,03,'6993459TH'),    
('391307233-0','Force Of The River',806,'Big A','2022-07-21',10.83,NULL,07,'4115381JA'),    
('029226132-2','Forsaken In Time',366,'Big A','2022-09-08',28.61,NULL,07,'8268048MA'),    
('831220281-1','Frightened In The Hills',192,'Big A','2022-10-01',10.76,NULL,02,'4835734QA'),    
('241440234-2','Frozen By My Pranks',320,'Big A','2022-01-22',71.96,NULL,11,'9857460SH'),    
('471382607-3','Fungi Per Country',867,'Big A','2022-10-17',83.19,NULL,09,'7141506RA'),    
('261747433-X','Gift Of The Void',374,'Big A','2022-09-30',8.81,NULL,05,'0691084DH'),    
('069266622-2','Harlequin And Agent',383,'Big A','2022-01-06',95.05,NULL,08,'5484880UA'),    
('171566075-7','Harmful Aliens',416,'Big A','2022-01-17',12.24,NULL,03,'7814326FH'),    
('904602433-4','Help In The Wild',138,'Big A','2022-09-10',19.76,NULL,05,'7492680UH'),    
('827625980-4','Horse And Foreigner',182,'Big A','2021-12-17',19.57,NULL,10,'1059277ZH'),    
('854930113-2','Horses And Sinners',382,'Big A','2022-03-18',41.55,NULL,14,'4559216DA'),    
('926114106-4','Humble In The Forest',139,'Big A','2022-02-25',37.25,NULL,03,'7700225VH'),    
('295493235-X','Hunted By My Leader',552,'Big A','2022-10-25',140.4,NULL,02,'5452407DH'),    
('400610430-8','Hurting The Light',429,'Big A','2022-05-23',51.56,NULL,08,'1241125LH'),    
('873967844-X','Ignorance Has A Secret Life',388,'Big A','2022-09-04',17.59,NULL,12,'6993459TH'),    
('546703267-4','Imps And Animals',189,'Big A','2021-12-20',14.77,NULL,13,'4115381JA'),    
('871613502-4','Influence Without Shame',587,'Big A','2021-12-24',17.11,NULL,04,'8268048MA'),    
('881356787-1','Innocence Of Robots',234,'Big A','2022-09-03',9.64,NULL,07,'4835734QA'),    
('638514486-0','Laughter In The Graveyard',97,'Big A','2022-06-07',56.69,NULL,12,'9857460SH'),    
('982750476-2','Leaders And Rebels',665,'Big A','2022-11-02',16.48,NULL,09,'7141506RA'),    
('321153783-X','Life After The Legends',404,'Big A','2022-11-02',19.36,NULL,14,'0691084DH'),    
('482810768-1','Life With The New Gods',113,'Big A','2022-11-05',13.68,NULL,01,'5484880UA'),    
('962894584-X','Limits Of Your Garden',515,'Big A','2022-08-09',48.94,NULL,16,'7814326FH'),    
('014397222-7','Love For The Joke',233,'Big A','2022-10-26',15.61,NULL,08,'7492680UH'),    
('000697506-2','Love On Mars',646,'Big A','2022-08-09',19.44,NULL,12,'1059277ZH'),    
('623842510-5','Majestic Animals',64,'Big A','2022-11-04',7.58,NULL,02,'4559216DA'),    
('497700656-9','Married To The Legends',780,'Big A','2022-03-09',153,NULL,11,'1764260BA'),    
('169961462-8','Monuments Of The Flight',363,'Big A','2022-06-09',15.73,NULL,12,'7300327AA'),    
('236948863-8','Mother Of The Aliens',233,'Big A','2022-08-23',55.73,NULL,01,'5484880UA'),    
('188356749-1','Mother Of The Void Of Space',108,'Big A','2022-05-17',11.4,NULL,01,'7814326FH'),    
('990749717-7','Music Of The Harvest',254,'Big A','2022-01-17',13.77,NULL,11,'7492680UH'),    
('093451079-2','Numb In The Maze',241,'Big A','2022-02-14',13.14,NULL,06,'1059277ZH'),    
('418868866-1','Ores Of The Sky',269,'Big A','2022-04-25',21,NULL,10,'4559216DA'),    
('495781768-5','Pain In The Jungle',346,'Big A','2022-10-13',26.2,NULL,09,'1764260BA'),    
('920571517-4','Planners And Secretaries',326,'Big A','2022-01-30',18.15,NULL,05,'7300327AA'),    
('279660415-2','Pranks Loves Sugar',364,'Big A','2022-05-25',12.45,NULL,13,'8268048MA'),    
('002633596-4','Promises Of Eternity',657,'Big A','2022-06-09',11.31,NULL,09,'4835734QA'),    
('846640232-2','Rebel And Soldier',712,'Big A','2022-01-06',37.35,NULL,09,'9857460SH'),    
('644166634-0','Recruits And Pilots',889,'Big A','2021-12-22',9.83,NULL,16,'7141506RA'),    
('698029683-3','Restoration Without Direction',797,'Big A','2022-11-13',42.64,NULL,04,'0691084DH'),    
('352767870-0','Result Of Water',114,'Big A','2022-03-21',65.84,NULL,14,'5484880UA'),    
('435743465-3','Rodents Of The South',844,'Big A','2022-08-10',77.24,NULL,05,'7814326FH'),    
('647008495-8','Rotten In Hell',676,'Big A','2022-04-13',21.88,NULL,06,'7492680UH'),    
('596214752-9','Scared Of The Caves',844,'Big A','2021-12-28',12.17,NULL,01,'1059277ZH'),    
('475904935-5','Screams In The Store',336,'Big A','2022-10-31',25.82,NULL,07,'4559216DA'),    
('881427820-2','Somber Until The Light',211,'Big A','2021-12-22',9.47,NULL,01,'1764260BA'),    
('694406983-0','Song Of My Memories',188,'Big A','2022-01-31',13.26,NULL,16,'7300327AA'),    
('934928563-0','Spices And Politicians',669,'Big A','2021-12-18',9.91,NULL,07,'7814326FH'),    
('373064845-4','Statue Of Exploration',447,'Big A','2022-02-11',14.41,NULL,16,'7492680UH'),    
('672323929-6','Stranger To The Titans',752,'Big A','2022-06-26',27.18,NULL,15,'1059277ZH'),    
('686517529-8','Stunts Exploit',289,'Big A','2022-08-07',50.27,NULL,05,'4559216DA'),    
('553052568-7','Tired Of My Memories',90,'Big A','2021-12-12',13.44,NULL,11,'1764260BA'),    
('041648129-9','Trees And Crustaceans',232,'Big A','2022-08-13',97.93,NULL,04,'7300327AA'),    
('882616972-1','Trinkets In My School',369,'Big A','2022-05-26',15.07,NULL,04,'7700225VH'),    
('371402385-2','Vengeance Of Last Rites',282,'Big A','2022-08-11',16.23,NULL,15,'5452407DH'),    
('529512823-7','Vengeance Without Hope',538,'Big A','2022-10-08',12.32,NULL,16,'1241125LH'),    
('374539219-1','Victory Of Darkness',810,'Big A','2022-03-24',17.92,NULL,02,'6993459TH'),    
('920152508-7','Visiting The Maze',881,'Big A','2022-04-10',70.7,NULL,07,'4115381JA'),    
('537705205-6','Warriors Of The Planet',185,'Big A','2022-08-02',16.81,NULL,14,'8268048MA'),    
('078549933-4','Whispers Of The Ocean',332,'Big A','2022-11-30',17.02,NULL,08,'4835734QA'),    
('032696816-4','Witches And Horses',766,'Big A','2022-11-30',17.42,NULL,12,'9857460SH'),    
('804161654-2','Witches And Wives',506,'Big A','2022-08-10',19.36,NULL,12,'7141506RA'),    
('066769571-0','Word Of',349,'Big A','2022-08-03',9.46,NULL,16,'0691084DH'),    
('560252428-2','Medics Of The Eclipse',460,'Big A','2022-11-02',15.57,NULL,09,'5484880UA');

insert into Sale value
('SB0001','2022-10-04',768,'2023-04-10','045654337-6',006,'TOS001'),   
('SB0002','2022-10-06',553,'2023-04-18','524836856-1',007,'TOS001'),   
('SB0003','2022-11-11',866,'2023-06-24','537651347-5',020,'TOS001'),   
('SB0004','2022-09-18',825,'2023-06-17','632704163-9',001,'TOS001'),   
('SB0005','2022-10-20',422,'2023-05-11','171566075-7',009,'TOS001'),   
('SB0006','2022-10-09',239,'2023-05-02','904602433-4',008,'TOS001'),   
('SB0007','2022-12-06',973,'2023-01-18','827625980-4',027,'TOS007'),   
('SB0008','2022-11-14',301,'2023-03-01','854930113-2',021,'TOS001'),   
('SB0009','2022-11-27',394,'2023-06-02','926114106-4',023,'TOS002'),   
('SB0010','2022-08-31',895,'2023-01-07','965945552-6',026,'TOS005'),   
('SB0011','2022-09-02',952,'2023-02-27','872319595-9',028,'TOS003'),   
('SB0012','2022-09-16',282,'2023-04-09','212008379-7',022,'TOS001'),   
('SB0013','2022-08-31',693,'2023-01-23','516285507-3',027,'TOS007'),   
('SB0014','2022-09-24',800,'2023-04-21','188185830-8',005,'TOS001'),   
('SB0015','2022-08-05',887,'2023-03-30','298865138-8',035,'TOS003'),   
('SB0016','2022-08-12',463,'2022-12-18','574953993-8',040,'TOS010'),   
('SB0017','2022-08-29',961,'2023-01-09','779018756-2',025,'TOS003'),   
('SB0018','2022-10-11',456,'2023-03-13','743074088-X',011,'TOS001'),   
('SB0019','2022-12-10',175,'2023-02-01','767875390-X',021,'TOS001'),   
('SB0020','2022-09-06',679,'2023-01-08','811547695-1',017,'TOS001'),   
('SB0021','2022-09-14',938,'2023-05-15','807319208-X',020,'TOS001'),   
('SB0022','2022-11-18',338,'2023-04-20','591650155-2',020,'TOS001'),   
('SB0023','2022-10-29',307,'2023-04-10','909066713-X',013,'TOS001'),   
('SB0024','2022-09-16',156,'2023-04-27','203214412-3',023,'TOS002'),   
('SB0025','2022-08-06',578,'2023-06-05','987297814-X',036,'TOS007'),   
('SB0026','2022-09-19',929,'2023-03-21','161401820-0',003,'TOS001'),   
('SB0027','2022-10-31',804,'2023-04-20','713341857-6',015,'TOS001'),   
('SB0028','2022-08-25',718,'2023-03-10','716941533-X',024,'TOS004'),   
('SB0029','2022-12-04',386,'2023-04-06','046671670-2',026,'TOS005'),   
('SB0030','2022-12-02',327,'2023-03-27','959510533-3',024,'TOS004'),   
('SB0031','2022-10-11',391,'2023-04-07','164777015-7',011,'TOS001'),   
('SB0032','2022-10-23',788,'2023-01-10','895882534-0',010,'TOS001'),   
('SB0033','2022-10-27',883,'2023-05-19','778481197-7',012,'TOS001'),   
('SB0034','2022-12-08',260,'2023-06-07','100093682-1',020,'TOS001'),   
('SB0035','2022-09-12',100,'2023-02-10','391307233-0',018,'TOS001'),   
('SB0036','2022-11-20',759,'2023-04-25','029226132-2',022,'TOS002'),   
('SB0037','2022-08-10',979,'2023-04-28','831220281-1',038,'TOS001'),   
('SB0038','2022-10-29',108,'2023-02-14','241440234-2',014,'TOS001'),   
('SB0039','2022-12-03',688,'2022-12-31','471382607-3',025,'TOS003'),   
('SB0040','2022-11-18',342,'2023-03-26','261747433-X',021,'TOS001'),   
('SB0041','2022-11-01',266,'2023-01-20','069266622-2',016,'TOS001'),   
('SB0042','2022-09-03',202,'2023-06-29','171566075-7',016,'TOS001'),   
('SB0043','2022-12-15',198,'2023-02-05','904602433-4',023,'TOS002'),   
('SB0044','2022-09-15',971,'2023-06-07','827625980-4',021,'TOS001'),   
('SB0045','2022-08-14',177,'2023-06-14','854930113-2',022,'TOS001'),   
('SB0046','2022-10-10',864,'2022-12-26','926114106-4',011,'TOS001'),   
('SB0047','2022-10-15',584,'2023-01-10','295493235-X',007,'TOS001'),   
('SB0048','2022-08-13',198,'2023-03-28','400610430-8',021,'TOS001'),   
('SB0049','2022-08-07',289,'2022-12-19','873967844-X',037,'TOS001'),   
('SB0050','2022-09-13',499,'2023-06-04','546703267-4',019,'TOS001'),   
('SB0051','2022-11-05',889,'2023-01-21','871613502-4',019,'TOS001'),   
('SB0052','2022-11-03',679,'2023-05-20','881356787-1',018,'TOS001'),   
('SB0053','2022-09-19',463,'2023-04-07','638514486-0',004,'TOS001'),   
('SB0054','2022-08-21',156,'2023-02-14','982750476-2',023,'TOS002'),   
('SB0055','2022-11-02',392,'2023-03-29','321153783-X',017,'TOS001'),   
('SB0056','2022-10-17',625,'2023-06-25','482810768-1',008,'TOS001'),   
('SB0057','2022-12-14',511,'2023-06-08','962894584-X',022,'TOS002'),   
('SB0058','2022-08-10',631,'2023-02-24','014397222-7',039,'TOS001'),   
('SB0059','2022-09-18',745,'2023-03-09','000697506-2',002,'TOS001'),   
('SB0060','2022-10-23',544,'2023-05-31','623842510-5',011,'TOS001');



