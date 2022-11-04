create table "s_199_Zabradli" (
	idx int8 primary key generated always as identity,
	step1_idx int8,
	obec varchar(90),
	orp int2,
	"KategorieObjektu" varchar(90) default 'Součásti a příslušenství staveb',
	"SkupinaObjektu" varchar(90) default 'Zařízení staveb',
	"ObsahovaCast" varchar(3) default 'ZPS',
	"UrovenUmisteniObjektuZPS" int2 not null,
	"ZpusobPorizeniZPS" int2 not null,
	"TridaPresnosti" int2 not null,
	geom geometry(linestringz, 5514)
);

create table "s_1_DefinicniBodBudovy" (
	idx int8 primary key generated always as identity,
	step1_idx int8,
	obec varchar(90),
	orp int2,
	"KategorieObjektu" varchar(90) default 'Budovy',
	"SkupinaObjektu" varchar(90) default 'Objekt budovy',
	"ObsahovaCast" varchar(3) default 'ZPS',
	"UrovenUmisteniObjektuZPS" int2 not null,
	geom geometry(pointz, 5514)
);

create table "s_200_VytahVChodniku" (
	idx int8 primary key generated always as identity,
	step1_idx int8,
	obec varchar(90),
	orp int2,
	"KategorieObjektu" varchar(90) default 'Součásti a příslušenství staveb',
	"SkupinaObjektu" varchar(90) default 'Zařízení staveb',
	"ObsahovaCast" varchar(3) default 'ZPS',
	"UrovenUmisteniObjektuZPS" int2 not null,
	"ZpusobPorizeniZPS" int2 not null,
	"TridaPresnosti" int2 not null,
	geom geometry(pointz, 5514)
);

create table "s_302_HraniceZdi" (
	idx int8 primary key generated always as identity,
	step1_idx int8,
	obec varchar(90),
	orp int2,
	"KategorieObjektu" varchar(90) default 'Konstrukční prvky objektů',
	"SkupinaObjektu" varchar(90) default 'Základní konstrukční prvek',
	"ObsahovaCast" varchar(3) default 'ZPS',
	"UrovenUmisteniObjektuZPS" int2 not null,
	"TypZdi" int2 not null,
	"ZpusobPorizeniZPS" int2 not null,
	"TridaPresnosti" int2 not null,
	geom geometry(linestringz, 5514)
);

create table "s_309_HranicePodzemnihoObjektuZPS" (
	idx int8 primary key generated always as identity,
	step1_idx int8,
	obec varchar(90),
	orp int2,
	"KategorieObjektu" varchar(90) default 'Konstrukční prvky objektů',
	"SkupinaObjektu" varchar(90) default 'Základní konstrukční prvek',
	"ObsahovaCast" varchar(3) default 'ZPS',
	"UrovenUmisteniObjektuZPS" int2 not null,
	"ZpusobPorizeniZPS" int2 not null,
	"TridaPresnosti" int2 not null,
	geom geometry(linestringz, 5514)
);

create table from step5_zps_bdef_objekty_dtmcr (
	obec varchar(90),
	orp int2
);

insert into step5_zps_bdef_objekty_dtmcr (obec, orp)
values
('509191_Cep', 353),
('546674_Lomnice nad Lužnicí', 353),
('546712_Majdalena', 353),
('562386_Hamr', 353),
('546844_Novosedly nad Nežárkou', 353),
('562840_Domanín', 353),
('561045_Smržov', 353),
('546461_Chlum u Třeboně', 353),
('562378_Staňkov', 353),
('562360_Nová Ves nad Lužnicí', 353),
('562637_Frahelž', 353),
('508501_Lužnice', 353),
('546089_České Velenice', 353),
('562688_Klec', 353),
('562815_Dunajovice', 353),
('562807_Halámky', 353),
('562670_562653_Ponědraž Ponědrážka', 353),
('562831_Hrachoviště', 353),
('509141_Dvory nad Lužnicí', 353),
('G220907-Trebon', 353),
('547336_Třeboň DTMM', 353);

create table orp_obce (
	obec varchar(90),
	orp int2
);

insert into orp_obce (orp,obec)
values
(281,'G220827-TSviny'),
(281,'G221027-TSviny'),
(281,'535231_Ostrolovský Újezd'),
(281,'535699_Petříkov'),
(281,'535982_Kamenná'),
(281,'544281_Borovany'),
(281,'544515_Horní Stropnice'),
(281,'544540_Hranice'),
(281,'544639_Jílovice'),
(281,'544809_Ločenice'),
(281,'544817_Mladošovice'),
(281,'544868_Nové Hrady'),
(281,'544884_Olešnice'),
(281,'545023_Slavče'),
(281,'545104_Svatý Jan nad Malší'),
(281,'545171_Trhové Sviny'),
(281,'545376_Žár'),
(281,'551503_Čížkrajice'),
(311,'G220810-Kaplice'),
(311,'536237_Zvíkov'),
(311,'545406_Benešov nad Černou'),
(311,'545414_Besednice'),
(311,'545449_Bujanov'),
(311,'545465_Dolní Dvořiště'),
(311,'545465_545503_DH Dvořiště'),
(311,'545562_Kaplice'),
(311,'545619_Malonty'),
(311,'545643_Netřebice'),
(311,'545660_Omlenice'),
(311,'545694_Pohorská Ves'),
(311,'545775_Rožmitál na Šumavě'),
(311,'545805_Soběnov'),
(311,'545821_Velešín'),
(311,'551538_Střítež'),
(353,'G220827-TSviny'),
(353,'G220907-Trebon'),
(353,'508501_Lužnice'),
(353,'508683_Záblatí'),
(353,'509141_Dvory nad Lužnicí'),
(353,'509191_Cep'),
(353,'546089_České Velenice'),
(353,'546461_Chlum u Třeboně'),
(353,'546674_Lomnice nad Lužnicí'),
(353,'546712_Majdalena'),
(353,'546844_Novosedly nad Nežárkou'),
(353,'547069_Rapšach'),
(353,'547247_Stříbřec'),
(353,'547280_Suchdol nad Lužnicí'),
(353,'547336_Třeboň'),
(353,'547336_Třeboň DTMM'),
(353,'561045_Smržov'),
(353,'562360_Nová Ves nad Lužnicí'),
(353,'562378_Staňkov'),
(353,'562386_Hamr'),
(353,'562637_Frahelž'),
(353,'562653_Ponědrážka'),
(353,'562670_562653_Ponědraž Ponědrážka'),
(353,'562688_Klec'),
(353,'562807_Halámky'),
(353,'562815_Dunajovice'),
(353,'562831_Hrachoviště'),
(353,'562840_Domanín');


