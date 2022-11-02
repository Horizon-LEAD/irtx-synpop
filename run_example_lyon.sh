set -e

## Activate environment
conda activate synpop

## Prepare configurations
python3 prepare_config.py \
  --template-path /home/ubuntu/synpop/irtx-synpop/data/template_lyon.yml \
  --target-path /home/ubuntu/irtx-synpop/output/config_2022_100pct.xml \
  --working-directory /home/ubuntu/irtx-synpop/cache \
  --data-path /home/ubuntu/irtx-synpop/input \
  --output-path /home/ubuntu/irtx-synpop/output \
  --lead-path /home/ubuntu/synpop/irtx-synpop/data \
  --processes 12 \
  --memory 40G \
  --output-prefix lead_2022_100pct_ \
  --random-seed 1234 \
  --sampling-rate 1.0 \
  --lead-year 2022 \
  --generate-synthetic-population true \
  --generate-agent-based-simulation false

python3 prepare_config.py \
  --template-path /home/ubuntu/synpop/irtx-synpop/data/template_lyon.yml \
  --target-path /home/ubuntu/irtx-synpop/output/config_2030_100pct.xml \
  --working-directory /home/ubuntu/irtx-synpop/cache \
  --data-path /home/ubuntu/irtx-synpop/input \
  --output-path /home/ubuntu/irtx-synpop/output \
  --lead-path /home/ubuntu/synpop/irtx-synpop/data \
  --processes 12 \
  --memory 40G \
  --output-prefix lead_2030_100pct_ \
  --random-seed 1234 \
  --sampling-rate 1.0 \
  --lead-year 2030 \
  --generate-synthetic-population true \
  --generate-agent-based-simulation false

python3 prepare_config.py \
  --template-path /home/ubuntu/synpop/irtx-synpop/data/template_lyon.yml \
  --target-path /home/ubuntu/irtx-synpop/output/config_2022_5pct.xml \
  --working-directory /home/ubuntu/irtx-synpop/cache \
  --data-path /home/ubuntu/irtx-synpop/input \
  --output-path /home/ubuntu/irtx-synpop/output \
  --lead-path /home/ubuntu/synpop/irtx-synpop/data \
  --processes 12 \
  --memory 40G \
  --output-prefix lead_2022_5pct_ \
  --random-seed 1234 \
  --sampling-rate 0.05 \
  --lead-year 2022 \
  --generate-synthetic-population true \
  --generate-agent-based-simulation true

 python3 prepare_config.py \
  --template-path /home/ubuntu/synpop/irtx-synpop/data/template_lyon.yml \
  --target-path /home/ubuntu/irtx-synpop/output/config_2030_5pct.xml \
  --working-directory /home/ubuntu/irtx-synpop/cache \
  --data-path /home/ubuntu/irtx-synpop/input \
  --output-path /home/ubuntu/irtx-synpop/output \
  --lead-path /home/ubuntu/synpop/irtx-synpop/data \
  --processes 12 \
  --memory 40G \
  --output-prefix lead_2030_5pct_ \
  --random-seed 1234 \
  --sampling-rate 0.05 \
  --lead-year 2030 \
  --generate-synthetic-population true \
  --generate-agent-based-simulation true

## Run synthesis pipeline
for target in config_2022_100pct config_2022_5pct config_2030_100pct config_2030_5pct; do
  python3 -m synpp /home/ubuntu/irtx-synpop/output/${target}.xml
done
