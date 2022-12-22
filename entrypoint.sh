#!/bin/bash

if [[ -z "$DATA_PATH" ]]; then
    echo "Must provide DATA_PATH in environment" 1>&2
    exit 1
fi
if [[ -z "$OUTPUT_PATH" ]]; then
    echo "Must provide DATA_PATH in environment" 1>&2
    exit 1
fi

python3 prepare_config.py \
  --template-path /srv/app/template_lead.yml \
  --target-path /srv/app/output/target-config.yml \
  --working-directory ${DATA_PATH}/cache \
  --data-path ${DATA_PATH} \
  --output-path ${OUTPUT_PATH} \
  --lead-path ${LEAD_PATH:-/srv/app/lead} \
  --output-prefix ${OUTPUT_PREFIX:-"lead_"}
  --processes ${PROCESSES:-12} \
  --memory ${MEMORY:-40} \
  --random-seed ${RANDOM_SEED:-1234} \
  --sampling-rate ${SAMPLING_RATE:-0.1} \
  --lead-year ${YEAR:-$(date +%Y)} \
  --generate-synthetic-population ${GENERATE_SYNTH_POP:-true} \
  --generate-agent-based-simulation ${GENERATE_AB_SIM:-false}

echo "Generated config file:"
cat output/target-config.yml

# python3 -m synpp /srv/app/target-config.yml
