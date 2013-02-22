CREATE DOMAIN "guid"
  AS VARCHAR(38)
  CHARACTER SET ASCII
  DEFAULT '{00000000-0000-0000-0000-000000000000}' NOT NULL;

CREATE TABLE tbEsterilizacion
(
   idEsterilizacion "guid"      NOT NULL
  , nroOrden        integer     DEFAULT -1
  , codBarra        varchar(30) DEFAULT '00000000'
  , refAlumno       "guid"      DEFAULT '{00000000-0000-0000-0000-000000000000}'
  , horaIngreso     time
  , fechaIngreso    date
  , pesoIngreso     float       DEFAULT 0.0
  , txObsIngreso    blob sub_type 1
  , refRespIngreso  "guid"      DEFAULT '{00000000-0000-0000-0000-000000000000}'
  , horaEgreso      time
  , fechaEgreso     date 
  , pesoEgreso      float       DEFAULT 0.0
  , txObsEgreso     blob sub_type 1
  , refRespEgreso   "guid"      DEFAULT '{00000000-0000-0000-0000-000000000000}'
  , bVisible        smallint    DEFAULT 1
  , ultAcceso    timestamp
  , refUltAcceso    "guid"      DEFAULT '{00000000-0000-0000-0000-000000000000}'
  , refUltReimpresion "guid"      DEFAULT '{00000000-0000-0000-0000-000000000000}'
 );

 
CREATE GENERATOR GenNroEsterilizacion;
SET GENERATOR GenNroEsterilizacion TO 0;

SET TERM ^ ;

CREATE TRIGGER idtbEsterilizacion FOR tbEsterilizacion
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.nroOrden = -1) then
   New.nroOrden = GEN_ID(GenNroEsterilizacion,1);
END^

SET TERM ; ^

 
 
CREATE TABLE tbAlumnos
(
    idAlumno        "guid"      NOT NULL
    , cApellidos    varchar(500)
    , cNombres      varchar(500)
    , refTipoDoc    integer     DEFAULT 0
    , documento     varchar(30)
    , nroAlumno     integer
    , tarjetaLegajo integer
    , tarjetaDigito integer
    , refFoto       "guid"      DEFAULT '{00000000-0000-0000-0000-000000000000}'
    , txNotas       blob sub_type 1
    , Direccion     varchar (1000)    
    , Telefono      varchar (100)
    , Localidad     varchar (500)
    , SuspendidoIni date
    , SuspendidoFin date
    , Categoria     varchar(2) DEFAULT 'A'
    , bVisible      smallint    DEFAULT 1
); 
 
CREATE TABLE tbResponsables
(
    idResponsable   "guid"      NOT NULL
    , cApellidos    varchar(500)
    , cNombres      varchar(500)
    , refTipoDoc    integer     DEFAULT 0
    , documento     varchar(30)
    , legajo        integer
    , refFoto       "guid"      DEFAULT '{00000000-0000-0000-0000-000000000000}' 
    , txNotas       blob sub_type 1
    , tarjetaLegajo integer
    , tarjetaDigito integer
    , Horario1Ini   time
    , Horario1Fin   time
    , Horario2Ini   time
    , Horario2Fin   time
    , FrancoDia     integer
    , FrancoIni     time
    , FrancoFin     time
    , refGrupo      integer
    , bVisible      smallint    DEFAULT 1
); 
 
CREATE TABLE tbFotos
(
    idFoto          "guid"      NOT NULL
    ,Foto           blob sub_type 0
    ,relacion       "guid"      DEFAULT '{00000000-0000-0000-0000-000000000000}' 
);
 
CREATE TABLE tugTiposDocumento
(
  idTipoDocumento	 int 		DEFAULT -1
 ,TipoDocumento		 varchar (300) DEFAULT '-'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugTiposDocumento
(idTipoDocumento, TipoDocumento, bVisible)
VALUES
(0, 'Desconocido',1);

INSERT INTO tugTiposDocumento
(idTipoDocumento, TipoDocumento, bVisible)
VALUES
(1, 'DNI',1);

INSERT INTO tugTiposDocumento
(idTipoDocumento, TipoDocumento, bVisible)
VALUES
(2, 'LC',1);

INSERT INTO tugTiposDocumento
(idTipoDocumento, TipoDocumento, bVisible)
VALUES
(3, 'PAS',1);


CREATE GENERATOR GenTipoDocumento;
SET GENERATOR GenTipoDocumento TO 3;

SET TERM ^ ;

CREATE TRIGGER idtugTiposDocumento FOR tugTiposDocumento
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idTipoDocumento = -1) then
   New.idTipoDocumento = GEN_ID(GenTipoDocumento,1);
END^

SET TERM ; ^

CREATE TABLE tbUsuarios
(
   idUsuario	   "guid"      NOT NULL
  , usuario         varchar (50)
  , clave           varchar (30)
  , pAplicacion     varchar (1) DEFAULT 'N'
  , pEstMaterial    varchar (1) DEFAULT 'N'
  , pEstHistorico   varchar (1) DEFAULT 'N'
  , pPrestArticulos varchar (1) DEFAULT 'N'
  , pSuspenciones   varchar (1) DEFAULT 'N'
  , pAlumnos        varchar (1) DEFAULT 'N'
  , pDocentes       varchar (1) DEFAULT 'N'
  , pArticulos      varchar (1) DEFAULT 'N'
  , pPersonal       varchar (1) DEFAULT 'N'
  , pTarjetaAlumno  varchar (1) DEFAULT 'N'
  , pTarjetaArticulo  varchar (1) DEFAULT 'N'
  , pTarjetaPersonal  varchar (1) DEFAULT 'N'
  , bVisible        smallint    DEFAULT 1
  , ultAcceso    timestamp
  , refUltAcceso    "guid"      DEFAULT '{00000000-0000-0000-0000-000000000000}'
 );

 
CREATE TABLE tugGruposResponsables
(
  idGrupoResponsable	 int 		DEFAULT -1
 ,GrupoResponsable		 varchar (300) DEFAULT '-'
 ,bVisible           smallint 	DEFAULT 1
);

INSERT INTO tugGruposResponsables
(idGrupoResponsable, GrupoResponsable, bVisible)
VALUES
(0, 'Desconocido',1);

INSERT INTO tugGruposResponsables
(idGrupoResponsable, GrupoResponsable, bVisible)
VALUES
(1, 'Empleado',1);

INSERT INTO tugGruposResponsables
(idGrupoResponsable, GrupoResponsable, bVisible)
VALUES
(2, 'Bioseguridad',1);

INSERT INTO tugGruposResponsables
(idGrupoResponsable, GrupoResponsable, bVisible)
VALUES
(3, 'Control',1);

CREATE TABLE tbInventario
(
   idInventario   int 		DEFAULT -1
 , Codigo		  varchar (100) 
 , Descripcion    varchar(1000)
 , Estado         varchar(1)
 , CodigoDeBarras varchar(30)
 , bVisible       smallint 	DEFAULT 1
);

CREATE GENERATOR GenInventario;
SET GENERATOR GenInventario TO 0;

SET TERM ^ ;

CREATE TRIGGER idtbInventario FOR tbInventario
BEFORE INSERT POSITION 0
AS 
BEGIN 
    If (New.idInventario = -1) then
   New.idInventario = GEN_ID(GenInventario,1);
END^

SET TERM ; ^
