drop database if exists thinky_botnet_db;
create database thinky_botnet_db
	character set utf8mb4
	collate uf8mb4_unicode_ci;

drop table if exists users;
create table users (
	id bigint unsigned not null primary key auto_increment,
	username varchar(50) not null unique,
	password char(40) not null,
	isactive boolean not null
)engine=innodb;

drop table if exists servers;
create table servers (
	id bigint unsigned not null primary key auto_increment,
	hostname varchar(50) not null,
	ipaddr char(12) not null,
	os char(35)  null
)engine=innodb;

drop table if exists ping_logger;
create table ping_logger (
	usrid bigint unsigned not null,
	srvid bigint unsigned not null,
	pingstamp timestamp not null,
	status boolean not null
)engine=innodb;

drop table if exists logger;
create table logger (
	srvid bigint unsigned,
	lastcmd text not null,
	usrid bigint unsigned
)engine=innodb;

alter table logger
	add constraint fk_srv0
		foreign key logger (srvid)
		references servers (id)
		

drop table if exists geolocation;
create table geolocation (
	srvid bigint unsigned,
	lat double null,
	long double null
)engine=innodb;

