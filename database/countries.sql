-- MySQL dump 10.16  Distrib 10.1.26-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: loymark
-- ------------------------------------------------------
-- Server version	10.1.26-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` int(11) NOT NULL,
  `name` varchar(75) NOT NULL DEFAULT '',
  `alpha_2` char(2) NOT NULL DEFAULT '',
  `alpha_3` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (4,'Afganistán','af','afg'),(8,'Albania','al','alb'),(12,'Argelia','dz','dza'),(20,'Andorra','ad','and'),(24,'Angola','ao','ago'),(28,'Antigua y Barbuda','ag','atg'),(31,'Azerbaiyán','az','aze'),(32,'Argentina','ar','arg'),(36,'Australia','au','aus'),(40,'Austria','at','aut'),(44,'Bahamas','bs','bhs'),(48,'Baréin','bh','bhr'),(50,'Bangladés','bd','bgd'),(51,'Armenia','am','arm'),(52,'Barbados','bb','brb'),(56,'Bélgica','be','bel'),(64,'Bután','bt','btn'),(68,'Bolivia','bo','bol'),(70,'Bosnia y Herzegovina','ba','bih'),(72,'Botsuana','bw','bwa'),(76,'Brasil','br','bra'),(84,'Belice','bz','blz'),(90,'Islas Salomón','sb','slb'),(96,'Brunéi','bn','brn'),(100,'Bulgaria','bg','bgr'),(104,'Birmania','mm','mmr'),(108,'Burundi','bi','bdi'),(112,'Bielorrusia','by','blr'),(116,'Camboya','kh','khm'),(120,'Camerún','cm','cmr'),(124,'Canadá','ca','can'),(132,'Cabo Verde','cv','cpv'),(140,'República Centroafricana','cf','caf'),(144,'Sri Lanka','lk','lka'),(148,'Chad','td','tcd'),(152,'Chile','cl','chl'),(156,'China','cn','chn'),(170,'Colombia','co','col'),(174,'Comoras','km','com'),(178,'República del Congo','cg','cog'),(180,'República Democrática del Congo','cd','cod'),(188,'Costa Rica','cr','cri'),(191,'Croacia','hr','hrv'),(192,'Cuba','cu','cub'),(196,'Chipre','cy','cyp'),(203,'República Checa','cz','cze'),(204,'Benín','bj','ben'),(208,'Dinamarca','dk','dnk'),(212,'Dominica','dm','dma'),(214,'República Dominicana','do','dom'),(218,'Ecuador','ec','ecu'),(222,'El Salvador','sv','slv'),(226,'Guinea Ecuatorial','gq','gnq'),(231,'Etiopía','et','eth'),(232,'Eritrea','er','eri'),(233,'Estonia','ee','est'),(242,'Fiyi','fj','fji'),(246,'Finlandia','fi','fin'),(250,'Francia','fr','fra'),(262,'Yibuti','dj','dji'),(266,'Gabón','ga','gab'),(268,'Georgia','ge','geo'),(270,'Gambia','gm','gmb'),(276,'Alemania','de','deu'),(288,'Ghana','gh','gha'),(296,'Kiribati','ki','kir'),(300,'Grecia','gr','grc'),(308,'Granada','gd','grd'),(320,'Guatemala','gt','gtm'),(324,'Guinea','gn','gin'),(328,'Guyana','gy','guy'),(332,'Haití','ht','hti'),(340,'Honduras','hn','hnd'),(348,'Hungría','hu','hun'),(352,'Islandia','is','isl'),(356,'India','in','ind'),(360,'Indonesia','id','idn'),(364,'Irán','ir','irn'),(368,'Irak','iq','irq'),(372,'Irlanda','ie','irl'),(376,'Israel','il','isr'),(380,'Italia','it','ita'),(384,'Costa de Marfil','ci','civ'),(388,'Jamaica','jm','jam'),(392,'Japón','jp','jpn'),(398,'Kazajistán','kz','kaz'),(400,'Jordania','jo','jor'),(404,'Kenia','ke','ken'),(408,'Corea del Norte','kp','prk'),(410,'Corea del Sur','kr','kor'),(414,'Kuwait','kw','kwt'),(417,'Kirguistán','kg','kgz'),(418,'Laos','la','lao'),(422,'Líbano','lb','lbn'),(426,'Lesoto','ls','lso'),(428,'Letonia','lv','lva'),(430,'Liberia','lr','lbr'),(434,'Libia','ly','lby'),(438,'Liechtenstein','li','lie'),(440,'Lituania','lt','ltu'),(442,'Luxemburgo','lu','lux'),(450,'Madagascar','mg','mdg'),(454,'Malaui','mw','mwi'),(458,'Malasia','my','mys'),(462,'Maldivas','mv','mdv'),(466,'Malí','ml','mli'),(470,'Malta','mt','mlt'),(478,'Mauritania','mr','mrt'),(480,'Mauricio','mu','mus'),(484,'México','mx','mex'),(492,'Mónaco','mc','mco'),(496,'Mongolia','mn','mng'),(498,'Moldavia','md','mda'),(499,'Montenegro','me','mne'),(504,'Marruecos','ma','mar'),(508,'Mozambique','mz','moz'),(512,'Omán','om','omn'),(516,'Namibia','na','nam'),(520,'Nauru','nr','nru'),(524,'Nepal','np','npl'),(528,'Países Bajos','nl','nld'),(548,'Vanuatu','vu','vut'),(554,'Nueva Zelanda','nz','nzl'),(558,'Nicaragua','ni','nic'),(562,'Níger','ne','ner'),(566,'Nigeria','ng','nga'),(578,'Noruega','no','nor'),(583,'Micronesia','fm','fsm'),(584,'Islas Marshall','mh','mhl'),(585,'Palaos','pw','plw'),(586,'Pakistán','pk','pak'),(591,'Panamá','pa','pan'),(598,'Papúa Nueva Guinea','pg','png'),(600,'Paraguay','py','pry'),(604,'Perú','pe','per'),(608,'Filipinas','ph','phl'),(616,'Polonia','pl','pol'),(620,'Portugal','pt','prt'),(624,'Guinea-Bisáu','gw','gnb'),(626,'Timor Oriental','tl','tls'),(634,'Catar','qa','qat'),(642,'Rumania','ro','rou'),(643,'Rusia','ru','rus'),(646,'Ruanda','rw','rwa'),(659,'San Cristóbal y Nieves','kn','kna'),(662,'Santa Lucía','lc','lca'),(670,'San Vicente y las Granadinas','vc','vct'),(674,'San Marino','sm','smr'),(678,'Santo Tomé y Príncipe','st','stp'),(682,'Arabia Saudita','sa','sau'),(686,'Senegal','sn','sen'),(688,'Serbia','rs','srb'),(690,'Seychelles','sc','syc'),(694,'Sierra Leona','sl','sle'),(702,'Singapur','sg','sgp'),(703,'Eslovaquia','sk','svk'),(704,'Vietnam','vn','vnm'),(705,'Eslovenia','si','svn'),(706,'Somalia','so','som'),(710,'Sudáfrica','za','zaf'),(716,'Zimbabue','zw','zwe'),(724,'España','es','esp'),(728,'Sudán del Sur','ss','ssd'),(729,'Sudán','sd','sdn'),(740,'Surinam','sr','sur'),(748,'Suazilandia','sz','swz'),(752,'Suecia','se','swe'),(756,'Suiza','ch','che'),(760,'Siria','sy','syr'),(762,'Tayikistán','tj','tjk'),(764,'Tailandia','th','tha'),(768,'Togo','tg','tgo'),(776,'Tonga','to','ton'),(780,'Trinidad y Tobago','tt','tto'),(784,'Emiratos Árabes Unidos','ae','are'),(788,'Túnez','tn','tun'),(792,'Turquía','tr','tur'),(795,'Turkmenistán','tm','tkm'),(798,'Tuvalu','tv','tuv'),(800,'Uganda','ug','uga'),(804,'Ucrania','ua','ukr'),(807,'Macedonia del Norte','mk','mkd'),(818,'Egipto','eg','egy'),(826,'Reino Unido','gb','gbr'),(834,'Tanzania','tz','tza'),(840,'Estados Unidos','us','usa'),(854,'Burkina Faso','bf','bfa'),(858,'Uruguay','uy','ury'),(860,'Uzbekistán','uz','uzb'),(862,'Venezuela','ve','ven'),(882,'Samoa','ws','wsm'),(887,'Yemen','ye','yem'),(894,'Zambia','zm','zmb');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-26 20:11:41
