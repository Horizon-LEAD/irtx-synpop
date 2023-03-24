#!/bin/bash

##############################################################################
# RP 2015                                                                    #
##############################################################################
mkdir rp_2015

wget -q https://www.insee.fr/fr/statistiques/fichier/3625223/RP2015_INDCVIZE_dbf.zip
unzip -q RP2015_INDCVIZE_dbf.zip -d ./rp_2015

wget -q https://www.insee.fr/fr/statistiques/fichier/3566008/rp2015_mobpro_dbase.zip
unzip -q rp2015_mobpro_dbase.zip -d ./rp_2015

wget https://www.insee.fr/fr/statistiques/fichier/3565982/rp2015_mobsco_dbase.zip
unzip -q rp2015_mobsco_dbase.zip -d ./rp_2015

wget -q https://www.insee.fr/fr/statistiques/fichier/3627376/base-ic-evol-struct-pop-2015.zip
unzip -q base-ic-evol-struct-pop-2015.zip -d ./rp_2015

rm *.zip
rm rp_2015/*.txt

##############################################################################
# filosofi_2015                                                              #
##############################################################################
mkdir filosofi_2015

wget -q https://www.insee.fr/fr/statistiques/fichier/3560118/indic-struct-distrib-revenu-2015-COMMUNES.zip
unzip -q indic-struct-distrib-revenu-2015-COMMUNES.zip -d ./filosofi_2015
cp ./filosofi_2015/indic-struct-distrib-revenu-2015-COMMUNES/FILO_DISP_COM.xls ./filosofi_2015/
rm -r ./filosofi_2015/indic-struct-distrib-revenu-2015-COMMUNES

wget -q https://www.insee.fr/fr/statistiques/fichier/3560118/indic-struct-distrib-revenu-2015-SUPRA.zip
unzip -q indic-struct-distrib-revenu-2015-SUPRA.zip -d ./filosofi_2015
unzip -q filosofi_2015/indic-struct-distrib-revenu-2015-SUPRA/indic-struct-distrib-revenu-2015-REG.zip -d ./filosofi_2015/indic-struct-distrib-revenu-2015-SUPRA
cp ./filosofi_2015/indic-struct-distrib-revenu-2015-SUPRA/indic-struct-distrib-revenu-2015-REG/FILO_DEC_REG.xls ./filosofi_2015
rm -r ./filosofi_2015/indic-struct-distrib-revenu-2015-SUPRA/
rm *.zip

##############################################################################
# bpe                                                                        #
##############################################################################
mkdir bpe_2019

#FIXME
wget -q https://www.insee.fr/fr/statistiques/fichier/3568638/bpe19_ensemble_xy_dbase.zip
unzip -q bpe19_ensemble_xy_dbase.zip -d ./bpe_2019
rm *.zip

##############################################################################
# ent_2008                                                                   #
##############################################################################
mkdir entd_2008

wget -q https://www.statistiques.developpement-durable.gouv.fr/sites/default/files/2018-12/Q_tcm_menage_0.csv -P ./entd_2008
wget -q https://www.statistiques.developpement-durable.gouv.fr/sites/default/files/2019-01/Q_tcm_individu.csv -P ./entd_2008
wget -q https://www.statistiques.developpement-durable.gouv.fr/sites/default/files/2019-01/Q_menage.csv -P ./entd_2008
wget -q https://www.statistiques.developpement-durable.gouv.fr/sites/default/files/2019-01/Q_individu.csv -P ./entd_2008
wget -q https://www.statistiques.developpement-durable.gouv.fr/sites/default/files/2019-01/Q_ind_lieu_teg.csv -P ./entd_2008
wget -q https://www.statistiques.developpement-durable.gouv.fr/sites/default/files/2019-01/K_deploc.csv -P ./entd_2008

##############################################################################
# iris_2017                                                                  #
##############################################################################
mkdir iris_2017

wget -q ftp://Contours_IRIS_ext:ao6Phu5ohJ4jaeji@ftp3.ign.fr/CONTOURS-IRIS_2-1__SHP__FRA_2017-01-01.7z
7z x CONTOURS-IRIS_2-1__SHP__FRA_2017-01-01.7z -o./iris_2017
cp ./iris_2017/CONTOURS-IRIS_2-1__SHP__FRA_2017-01-01/CONTOURS-IRIS/1_DONNEES_LIVRAISON_2018-06-00105/CONTOURS-IRIS_2-1_SHP_LAMB93_FXX-2017/CONTOURS-IRIS.* ./iris_2017
rm -r ./iris_2017/CONTOURS-IRIS_2-1__SHP__FRA_2017-01-01
rm *.7z

##############################################################################
# codes_2017                                                                 #
##############################################################################
mkdir codes_2017

wget -q https://www.insee.fr/fr/statistiques/fichier/2017499/reference_IRIS_geo2017.zip
unzip -q reference_IRIS_geo2017.zip -d ./codes_2017
rm *.zip

##############################################################################
# sirene                                                                     #
##############################################################################
mkdir sirene

#FIXME
wget -q https://www.data.gouv.fr/fr/datasets/r/f749a574-de48-4d64-8e5a-29466583cdae
mv f749a574-de48-4d64-8e5a-29466583cdae StockEtablissement_utf8.zip

##############################################################################
# BDTOPO                                                                     #
##############################################################################
mkdir bdtopo
wget -q --ftp-user=BDTOPO_V3_ext --ftp-password=Aish3ho8\!\!\! ftp://ftp3.ign.fr/BDTOPO_3-0_2021-03-15/BDTOPO_3-0_TOUSTHEMES_SHP_LAMB93_R84_2021-03-15.7z
7z x BDTOPO_3-0_TOUSTHEMES_SHP_LAMB93_R84_2021-03-15.7z -o ./bdtopo
cp ./bdtopo/BDTOPO_3-0_TOUSTHEMES_SHP_LAMB93_R84_2021-03-15/BDTOPO/1_DONNEES_LIVRAISON_2021-03-00275/BDT_3-0_SHP_LAMB93_R84-ED2021-03-15/ADRESSES/ADRESSE.* ./bdtopo
rm -r ./bdtopo/BDTOPO_3-0_TOUSTHEMES_SHP_LAMB93_R84_2021-03-15
rm *.7z

##############################################################################
# OSM                                                                        #
##############################################################################
mkdir osm
wget -q https://download.geofabrik.de/europe/france/rhone-alpes-latest.osm.pbf -P ./osm

##############################################################################
# GTFS                                                                       #
##############################################################################
mkdir gtfs

#FIXME
wget -q https://download.data.grandlyon.com/files/rdata/tcl_sytral.tcltheorique/GTFS_TCL.ZIP -P gtfs
# unzip -q GTFS_TCL.ZIP -d gtfs

wget -q https://eu.ftp.opendatasoft.com/sncf/gtfs/export-ter-gtfs-last.zip -P gtfs
# unzip -q export-ter-gtfs-last.zip -d gtfs

wget -q https://eu.ftp.opendatasoft.com/sncf/gtfs/export-intercites-gtfs-last.zip -P gtfs
# unzip -q export-intercites-gtfs-last.zip -d gtfs

#FIXME - missing
# /input/gtfs/lyon/CAPI.GTFS.zip
# /input/gtfs/lyon/GTFS_RX.ZIP
# /input/gtfs/lyon/SEM-GTFS.zip
# /input/gtfs/lyon/stas.gtfs.zip
# /input/gtfs/lyon/VIENNE.GTFS.zip
# /input/gtfs/lyon/export_gtfs_voyages.zip

