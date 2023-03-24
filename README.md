# IRTX Synthetic population model

## Introduction

The present model generates a synthetic representation of households, persons
and their daily activity chains. While it can be applied to any region in France,
it is configured to create a synthetic population for the Rhône-Alpes region
around Lyon. In the project lead, the resulting synthetic population is used to
(1) derive a demand data set for parcel deliveries in the region, and to (2)
assess how delivering these parcels is affecting the local population using a
detailed agent-based simulation. Both aspects are covered in downstream models.

The model is based on a methodology that has been published in

> Hörl, S., Balac, M., 2021. Synthetic population and travel demand for Paris and Île-de-France based on open and publicly available data. Transportation Research Part C: Emerging Technologies 130, 103291. https://doi.org/10.1016/j.trc.2021.103291

All code for the model is available on Github:

> https://github.com/eqasim-org/ile-de-france

The model is based entirely on open and publicly available data that can be
downloaded from the respective distributing entities. The process of collecting
all necessary data to create a synthetic population for Rhône-Alpes, as well
as suggestions on configuring the model, are given in the same Github repository
and users are expected to follow the detailed guidelines on where and how to
obtain the individual data sets.

For the project LEAD and the special case of the Lyon Living Lab, adjustments
have been made to the model. For instance, a module has been addded that scales
up the population of the study area to the future expected resident count.

## Requirements

All explanations in this document refer to the branch `lead` in the model's
original Github repository and, specifically, the commit `51a0c37` is used
throughout this document.

### Software requirements

To run the model, the environment needs to be prepared:

- A `conda` environment needs to be set up in which the Python code of the model is run. The remote repository provides `environment.yml` which describes the `conda` environment and all dependencies:

```bash
conda env create -f environment.yml -n synpop
```

- Note that some of the dependencies installed via `conda > pip` need a recent compiler available on the system. Additionally, the MATSim instances that are run in the pipeline need to have access to the fonts available on the system. On an Ubunutu system, it suffices to `apt install build-essential fontconfig`.

- A `Java` runtime needs to be present on the executing machine. It is recommended to set up an **Adoptium OpenJDK 11** (https://adoptium.net).

- A recent version of `maven` needs to be installed, version `3.6.3` has been tested: https://maven.apache.org/

- A recent version of `git` needs to be installed on the system.

- Finally, `osmosis` needs to be installed, version `0.48.2` has been tested: https://github.com/openstreetmap/osmosis/releases

It is recommended to set up the environment on a Linux machine, the following
executables should then be callable from the command line: `java`, `mvn`, `osmosis`, `git`.

A comprehensive example of setting up the environment for continuous integration
can be found in the model repository at `.github/workflows/tests.yml`.

### Input / Output

#### Input

How to collect all the necessary input data sets is described in detail in the
model repository:

> https://github.com/eqasim-org/ile-de-france/blob/lead/docs/cases/lyon.md

In brief the following data sets need to be collected:

- Census data (Rhône-Alpes cut-out)
- National origin/destination census data
- Population totals data
- Income tax data
- Service and facility census
- National household travel survey
- IRIS Zoning System
- Zoning registry
- Enterprise census (SIRENE)
- National Address Database (Rhône-Alpes cut-out)
- OpenStreetMap data (Rhoône-Alpes cut-out)
- GTFS data of the regional public transport operators

All data sets should be arranged as described in an arbitrary directory, from here
on denoted as `/input`. Finally, `/input` should show the following structure:

```
Synthetic population:
/input/rp_2015/FD_INDCVIZE_2015.dbf
/input/rp_2015/FD_MOBPRO_2015.dbf
/input/rp_2015/FD_MOBSCO_2015.dbf
/input/rp_2015/base-ic-evol-struct-pop-2015.xls
/input/filosofi_2015/FILO_DISP_COM.xls
/input/filosofi_2015/FILO_DISP_REG.xls
/input/bpe_2021/bpe21_ensemble_xy.csv
/input/entd_2008/Q_individu.csv
/input/entd_2008/Q_tcm_individu.csv
/input/entd_2008/Q_menage.csv
/input/entd_2008/Q_tcm_menage_0.csv
/input/entd_2008/K_deploc.csv
/input/entd_2008/Q_ind_lieu_teg.csv
/input/iris_2017/CONTOURS-IRIS.cpg
/input/iris_2017/CONTOURS-IRIS.dbf
/input/iris_2017/CONTOURS-IRIS.prj
/input/iris_2017/CONTOURS-IRIS.shp
/input/iris_2017/CONTOURS-IRIS.shx
/input/codes_2017/reference_IRIS_geo2017.xls
/input/sirene/StockEtablissement_utf8.csv
/input/bdtopo_lyon/ADRESSE.shp
/input/bdtopo_lyon/ADRESSE.cpg
/input/bdtopo_lyon/ADRESSE.dbf²
/input/bdtopo_lyon/ADRESSE.prj
/input/bdtopo_lyon/ADRESSE.shx
```

```
Transport system:
/input/osm/rhone-alpes-latest.osm.pbf
/input/gtfs/lyon/GTFS_TCL.ZIP
/input/gtfs/lyon/CAPI.GTFS.zip
/input/gtfs/lyon/GTFS_RX.ZIP
/input/gtfs/lyon/SEM-GTFS.zip
/input/gtfs/lyon/stas.gtfs.zip
/input/gtfs/lyon/VIENNE.GTFS.zip
/input/gtfs/lyon/export_gtfs_voyages.zip
/input/gtfs/lyon/export-intercites-gtfs-last.zip
/input/gtfs/lyon/export-ter-gtfs-last.zip
```

For testing purposes, a prepackaged collection of those data sets can be obtained
from IRT SystemX.

#### Configuration

To run the pipeline, a configuration file needs to be provided. An example is
given in the LEAD repository as `data/template_lyon.yml`. The configuration file
is in YAML format.

There are some **mandatory** settings that need to be updated in the configuration file.
Those concern mostly paths in the file system. It is recommended to put absolute paths in
the configuration file:

- `working_directory`: This option needs to point to an *existing* directory (otherwise the model will refuse to run) in which the pipeline will save all caching information as it will run a considerable number of models one after another. **Note that cached results in this working directory can be reused**: If the pipeline is run multiple times, possibly with varying optional configuration parameters, only those parts that are affected by the parameter changes are re-run and if, later, old parameter configuration should be re-run, the model will use cached information.

- `config.data_path`: This parameter should point to the directory in which all the data has been put, i.e. `/data` from the previous section.

- `config.output_path`: The option should point to an *existing* directory in which the model output will be written. From this directory, the results can be obtained later on.

- `config.lead_path`: The option should point to the `data` directory of the LEAD repository for the synthetic population model. It contains additional data for the Lyon living lab.

The following table covers **optional** attributes related to executing the model:

Parameter             | Values                            | Description
---                   | ---                               | ---
`processes`           | Integer (default `12`)            | Number of parallel processes to use. Note that Python gets unstable on some systems for more that 12 processes.
`java_memory`         | Integer + `G` (default `40G`)    | Java is only needed when generating the inputs for the agent-based simulation. The pipeline will run two test iterations of the simulation, which may need up to 120GB of memory, but can be scaled down (see parameters below).
`output_prefix`       | String (`lead_`)                  | All output files for a specific run that are put into the `output_path` will be prepended by `output_prefix`. This allows to have different scenarios / versions of the output.

Some parameters are related to the different scenarios that are examined using the LEAD platform:

Parameter             | Values                            | Description
---                   | ---                               | ---
`random_seed`         | Integer (default `1234`)          | Allows to run the model with different random variations
`sampling_rate`       | Real (default `1.0`)              | Share of households that will be generated (lower numbers mean quicker run times)
`lead_year`           | `2022` or `2030`                  | Defines for which year the synthetic population is generated.

Finally, the configuration can be adjusted using the `run` option. It describes a list of pipeline components that will be executed. For the Lyon case, only two components are relevant:

- `synthesis.output`: If this component is chosen, output for the synthetic population will be created in the `output_path`. Usually, it should be executed with a `sampling_rate` of `1.0`, because it will prepare data for the downstream parcel models.
- `matsim.output`: If this component is chosen, inputs for an agent-based transport simulation will be created in the `output_path`. Note that in this case the pipeline will automatically run two iterations of the simulation to verify the output. This requires substantial memory (up to 120GB RAM) if the full sampling rate is used. For the simulations, hence, smaller values for `sampling_rate` such as `0.05` are recommended.

To ease configuration for the project LEAD, `prepare_config.py` is provided with the synthetic population model in the LEAD repository. It allows to create a configuration file taking into account the relevant parameters for the project:

```bash
python3 prepare_config.py \
  --template-path /path/to/irtx-synpop/data/template_lyon.yml \
  --target-path config_XYZ.xml \
  --working-directory /path/to/working_directory \
  --data-path /path/to/data \
  --output-path /path/to/output \
  --lead-path /path/to/irtx-synpop/data \
  --processes 12 \
  --memory 40G \
  --output-prefix XYZ \
  --random-seed 1234 \
  --sampling-rate 1.0 \
  --lead-year 2022 \
  --generate-synthetic-population true \
  --generate-agent-based-simulation false
```

Note that, here, a specific configuration for the scenario `XYZ` is created. The option `template-path` corresponds to the template the is provided in the LEAD repository and `target-path` corresponds to where the prepared configuration file should be written. Also note the last two options that define which output components to active.

The resulting configuration file should be put in the root folder of the cloned model repository to execute it.

#### Output

The output depends on whether the output for the synthetic population and/or the input for the agent-based transport simulation are chosen to be created in the configuration (see above).

For the *synthetic population*, the following files are created (assuming `lead_` being the chosen prefix in the configuration):

- `lead_meta.json`: Meta information on when and how the synthetic population has been created
- `lead_households.csv`: Table containing socio-demographic information about all generated households
- `lead_homes.gpkg`: Geographic file containing the place of residence for all generated households
- `lead_persons.csv`: Table containing socio-demographic information about all generated persons
- `lead_activities.csv`: Table containing all activities performed during one day for each synthetic person
- `lead_activities.gpkg`: Same with geographic coordinate information
- `lead_trips.csv`: Table containing all trips performed during one day by each synthetic person
- `lead_trips.gpkg`: Same with geographic coordinate information
- `lead_commutes.gpkg`: Geographic information on all commutes of the synthetic population

For the *agent-based simulation*, the following files are created:

- `lead_population.xml.gz`: Information on the daily movements of the synthetic population
- `lead_network.xml.gz`: Describes the road and transit network
- `lead_facilities.xml.gz`: Describes facilities (appartments, stops, ...)
- `lead_transit_schedule.xml.gz`: Describes the public transport schedules
- `lead_transit_vehicles.xml.gz`: Describes the public transport vehicles
- `lead_config.xml`: Pre-generated configuration file for the simulation

## Running the model

First, the environment needs to be set up. All relevant dependencies should then
be present, and the user can enter the generated `conda` environment:

```bash
conda activate synpop
```

As described above, the configuration process has been simplified. One can now
call `prepare_config.py` to create a configuration file, for instance, `lead_config.xml`.

The pipeline should be called from its root directory (the cloned model repository)
and can be started by calling

```bash
cd /path/to/model
python3 -m synpp lead_config.xml
```

Depending on the configuration settings, the pipeline will run quite quickly
or for a long time. Also remember that results in `working_directory` are
cached, so subsequent calls will be much faster if not configuration parameters
have been changed. In fact, if no changes are present at all, the pipeline will
just return the previous obtained output.

## Standard scenarios

For the Lyon living lab, some standard scenarios can be run:

- A full synthetic population (100%) for the years 2022 and 2030 that is used as input for
the downstream parcel synthesis model.
- A reduced synthetic population (5%) for the year 2022 and 2030 that is used for the
agent-based simulation.

**Full synthetic population for 2022**

```
--target-path config_2022_100pct.xml \
--output-prefix lead_2022_100pct_ \
--sampling-rate 1.0 \
--lead-year 2022 \
--generate-synthetic-population true \
--generate-agent-based-simulation false
```

**Full synthetic population for 2030**

```
--target-path config_2030_100pct.xml \
--output-prefix lead_2030_100pct_ \
--sampling-rate 1.0 \
--lead-year 2030 \
--generate-synthetic-population true \
--generate-agent-based-simulation false
```

**Reduced synthetic population for 2022**

```
--target-path config_2022_5pct.xml \
--output-prefix lead_2022_5pct_ \
--sampling-rate 0.05 \
--lead-year 2022 \
--generate-synthetic-population true \
--generate-agent-based-simulation true
```

**Reduced synthetic population for 2030**

```
--target-path config_2030_5pct.xml \
--output-prefix lead_2030_5pct_ \
--sampling-rate 0.05 \
--lead-year 2030 \
--generate-synthetic-population true \
--generate-agent-based-simulation true
```

## Packaging information

```
docker build \
  -t irtx-synpop:latest .

docker run --rm \
  -v $PWD/sample-data:/data \
  -e PROCESSES=2 \
  -e MEMORY=4 \
  -e SAMPLING_RATE=0.01 \
  -e YEAR=2022 \
  -e GENERATE_SYNTH_POP=true \
  -e GENERATE_AB_SIM=false \
  irtx-synpop:latest \
  -v \
  /data/input \
  /data/output
```

