/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2014                    */
/* Created on:     03/10/2022 16:58:21                          */
/* Autor:          Jorge Luiz da Silva                          */
/* Disciplina:     Banco de Dados                               */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('estado') and o.name = 'fk_regiao__estado')
alter table estado
   drop constraint fk_regiao__estado
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('municipio') and o.name = 'fk_estado__municipio')
alter table municipio
   drop constraint fk_estado__municipio
go

if exists (select 1
            from  sysobjects
           where  id = object_id('estado')
            and   type = 'U')
   drop table estado
go

if exists (select 1
            from  sysobjects
           where  id = object_id('municipio')
            and   type = 'U')
   drop table municipio
go

if exists (select 1
            from  sysobjects
           where  id = object_id('regiao')
            and   type = 'U')
   drop table regiao
go

/*==============================================================*/
/* Table: estado                                                */
/*==============================================================*/
create table estado (
   cd_estado            int                  not null,
   cd_regiao            int                  null,
   nm_estado            varchar(50)          null,
   sigla_uf             char(2)              null,
   constraint pk_estado primary key (cd_estado)
)
go

/*==============================================================*/
/* Table: municipio                                             */
/*==============================================================*/
create table municipio (
   cd_municipio         int                  not null,
   nm_municipio         varchar(100)         null,
   cd_estado            int                  null,
   constraint pk_municipio primary key (cd_municipio)
)
go

/*==============================================================*/
/* Table: regiao                                                */
/*==============================================================*/
create table regiao (
   cd_regiao            int                  not null,
   nm_regiao            varchar(50)          null,
   constraint pk_regiao primary key (cd_regiao)
)
go

alter table estado
   add constraint fk_regiao__estado foreign key (cd_regiao)
      references regiao (cd_regiao)
go

alter table municipio
   add constraint fk_estado__municipio foreign key (cd_estado)
      references estado (cd_estado)
go

