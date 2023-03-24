#!/bin/bash

#Set fonts
NORM=`tput sgr0`
BOLD=`tput bold`
REV=`tput smso`

function show_usage () {
    echo -e "${BOLD}Basic usage:${NORM} entrypoint.sh [-vh] input-path output-path"
}

function show_help () {
    echo -e "${BOLD}entrypoint.sh${NORM}: Calls the entrypoint"\\n
    show_usage
    echo -e "\n${BOLD}Required arguments:${NORM}"
    echo -e "${REV}input-path${NORM}\t the path of the input directory"
    echo -e "${REV}output-path{NORM}\t the output directory"\\n
    echo -e "${BOLD}Optional arguments:${NORM}"
    echo -e "${REV}-v${NORM}\tSets verbosity level"
    echo -e "${REV}-h${NORM}\tShows this message"
    echo -e "${BOLD}Examples:${NORM}"
    echo -e "./entrypoint.sh -v ./sample-data/input/ ./sample-data/output/"
}

####################################################################################################
# GETOPTS                                                                                          #
####################################################################################################
# A POSIX variable
# Reset in case getopts has been used previously in the shell.
OPTIND=1

# Initialize vars:
verbose=0

# while getopts
while getopts 'hv' OPTION; do
    case "$OPTION" in
        h)
            show_help
            kill -INT $$
            ;;
        v)
            verbose=1
            ;;
        ?)
            show_usage >&2
            kill -INT $$
            ;;
    esac
done

shift "$(($OPTIND -1))"

leftovers=(${@})
data_path=${leftovers[0]%/}
output_path=${leftovers[1]%/}
[ ${verbose} -eq 1 ] && echo "input: ${data_path}, ${output_path}"

####################################################################################################
# Input checks                                                                                     #
####################################################################################################
if [ ! -d "$data_path" ]; then
    echo -e "Give a ${BOLD}valid${NORM} data input directory\n"; show_usage; exit 1
fi
if [ ! -d "$output_path" ]; then
    echo -e "Give a ${BOLD}valid${NORM} output directory\n"; show_usage; exit 1
fi

if [ "$YEAR" != "2022" ] && [ "$YEAR" != "2030" ]; then
  echo -e "Give a ${BOLD}valid${NORM} year: choose between 2022 or 2030"; exit 1
fi

####################################################################################################
# Execution                                                                                        #
####################################################################################################
mkdir -p ${data_path}/cache

python3 /srv/app/src/prepare_config.py \
  --template-path /srv/app/data/template_lead.yml \
  --target-path ${output_path}/target-config.yml \
  --working-directory ${data_path}/cache \
  --data-path ${data_path} \
  --output-path ${output_path} \
  --lead-path /srv/app/data \
  --output-prefix ${OUTPUT_PREFIX:-"lead_"} \
  --processes ${PROCESSES:-6} \
  --memory ${MEMORY:-16} \
  --random-seed ${RANDOM_SEED:-1234} \
  --sampling-rate ${SAMPLING_RATE:-0.1} \
  --lead-year ${YEAR:-2022} \
  --generate-synthetic-population ${GENERATE_SYNTH_POP:-true} \
  --generate-agent-based-simulation ${GENERATE_AB_SIM:-true}

[ ${verbose} -eq 1 ] && echo -e "Generated config file:\n $(cat ${output_path}/target-config.yml)"

cd /srv/app/ile-de-france
python3 -m synpp ${output_path}/target-config.yml
