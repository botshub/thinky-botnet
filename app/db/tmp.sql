-- Copyright (C) 2017  captaincode

-- This program is free software: you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the Free
-- Software Foundation, either version 3 of the License, or (at your option)
-- any later version.

-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-- more details.

-- You should have received a copy of the GNU General Public License along
-- with this program.  If not, see <http://www.gnu.org/licenses/>.

/**
 * @author captaincode0 <captaincode0@protonmail.com>
 * @author JouniorG
 */
drop database if exists thinky_botnet_db;
create database thinky_botnet_db
	character set utf8mb4
	collate utf8mb4_unicode_ci;
use thinky_botnet_db;

/**
 * @table users
 * @tabledesc saves all the users to log into botnet administration tools
 */
drop table if exists users;
create table users (
	id bigint unsigned not null primary key auto_increment,
	username varchar(50) not null unique,
	password char(40) not null,
	isactive boolean not null default true
)engine=innodb;

/**
 * @table clients
 * @tabledesc saves information of all clients connected to victims computer
 */
drop table if exists clients;
create table clients (
	id bigint unsigned not null primary key auto_increment,
	usrid bigint unsigned not null,
	ipaddr char(15) not null,
	os char(35) null,
	islogged boolean not null default true
)engine=innodb;

alter table clients
	add constraint fk_usr0
		foreign key clients (usrid)
			references users (id)
				on update no action
				on delete cascade;

/**
 * @table servers
 * @tabledesc register all the servers to insert more bots??
 */
drop table if exists servers;
create table servers (
	id bigint unsigned not null primary key auto_increment,
	hostname varchar(50) not null,
	ipaddr char(15) not null,
	os char(35) null
)engine=innodb;

/**
 * @table commands
 * @tabledesc run one command in one server, is stored until the server wake up
 */
drop table if exists commands;
create table commands (
	srvid bigint unsigned not null,
	clientid bigint unsigned not null,
	command text not null,
	commandstamp timestamp null,
	executed boolean not null default false
)engine=innodb;

alter table commands
	add constraint fk_srv0
		foreign key commands (srvid)
			references servers (id)
				on update no action
				on delete cascade;

alter table commands
	add constraint fk_clients0
		foreign key commands (clientid)
			references clients (id)
				on update no action 
				on delete cascade;

/**
 * @table ping_logger
 * @tabledesc register a new ping for one server
 */
drop table if exists ping_logger;
create table ping_logger (
	srvid bigint unsigned not null,
	pingstamp timestamp null,
	status boolean not null
)engine=innodb;

alter table ping_logger 
	add constraint fk_ping0
		foreign key ping_logger (srvid)
			references servers (id)
				on update no action
				on delete cascade;

/**
 * @table geolocation
 * @tabledesc gives geolocations of the servers
 */
drop table if exists geolocation;
create table geolocation (
	srvid bigint unsigned not null,
	lat double null,
	lon double null
)engine=innodb;

alter table geolocation
	add constraint fk_srv1
		foreign key geolocation (srvid)
			references servers (id)
				on update no action
				on delete cascade;
/**
 * @table tookit
 * @tabledesc contains all the tools
 */
drop table if exists toolkit;
create table toolkit (
	name varchar(50) not null,
	url text not null
)engine=innodb;

delimiter //

create trigger trgBICommands before insert on commands
	for each row 
		begin
			set new.commandstamp = (select now());
		end;//

create trigger trgBIPingLogger before insert on ping_logger
	for each row
		begin
			set new.pingstamp = (select now());
		end;//

delimiter ;

-- EOF-- Copyright (C) 2017  

-- This program is free software: you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the Free
-- Software Foundation, either version 3 of the License, or (at your option)
-- any later version.

-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-- more details.

-- You should have received a copy of the GNU General Public License along
-- with this program.  If not, see <http://www.gnu.org/licenses/>.

use thinky_botnet_db;

insert into users(username, password) values("captaincode0", "09e821cd554742c1bc8341bf275b5da6a27aaf8d"),
	("jouniorg", "cb333f6bdb5a925a75ff49a1e32282126d7f2e81");