set -e

cd /home/ubuntu/irtx-synpop
mkdir /home/ubuntu/irtx-synpop/output
mkdir /home/ubuntu/irtx-synpop/cache

## Manually put the input data into
mkdir /home/ubuntu/irtx-synpop/input

## Prepare pipeline
git clone https://github.com/eqasim-org/ile-de-france.git /home/ubuntu/irtx-synpop/code

cd /home/ubuntu/irtx-synpop/code
git checkout 51a0c37

## Create environment
conda env create -f environment.yml -n synpop

## Activate environment
conda activate synpop

cd /home/ubuntu/irtx-synpop

## Prepare configurations
python3 prepare_config.py \
  --template-path /home/ubuntu/irtx-synpop/data/template_lyon.yml \
  --target-path /home/ubuntu/irtx-synpop/output/config_2022_100pct.xml \
  --working-directory /home/ubuntu/irtx-synpop/cache \
  --data-path /home/ubuntu/irtx-synpop/input \
  --output-path /home/ubuntu/irtx-synpop/output \
  --lead-path /home/ubuntu/irtx-synpop/data \
  --processes 12 \
  --memory 40G \
  --output-prefix lead_2022_100pct_ \
  --random-seed 1234 \
  --sampling-rate 1.0 \
  --lead-year 2022 \
  --generate-synthetic-population true \
  --generate-agent-based-simulation false

python3 prepare_config.py \
  --template-path /home/ubuntu/irtx-synpop/data/template_lyon.yml \
  --target-path /home/ubuntu/irtx-synpop/output/config_2030_100pct.xml \
  --working-directory /home/ubuntu/irtx-synpop/cache \
  --data-path /home/ubuntu/irtx-synpop/input \
  --output-path /home/ubuntu/irtx-synpop/output \
  --lead-path /home/ubuntu/irtx-synpop/data \
  --processes 12 \
  --memory 40G \
  --output-prefix lead_2030_100pct_ \
  --random-seed 1234 \
  --sampling-rate 1.0 \
  --lead-year 2030 \
  --generate-synthetic-population true \
  --generate-agent-based-simulation false

python3 prepare_config.py \
  --template-path /home/ubuntu/irtx-synpop/data/template_lyon.yml \
  --target-path /home/ubuntu/irtx-synpop/output/config_2022_5pct.xml \
  --working-directory /home/ubuntu/irtx-synpop/cache \
  --data-path /home/ubuntu/irtx-synpop/input \
  --output-path /home/ubuntu/irtx-synpop/output \
  --lead-path /home/ubuntu/irtx-synpop/data \
  --processes 12 \
  --memory 40G \
  --output-prefix lead_2022_5pct_ \
  --random-seed 1234 \
  --sampling-rate 0.05 \
  --lead-year 2022 \
  --generate-synthetic-population true \
  --generate-agent-based-simulation true

 python3 prepare_config.py \
  --template-path /home/ubuntu/irtx-synpop/data/template_lyon.yml \
  --target-path /home/ubuntu/irtx-synpop/output/config_2030_5pct.xml \
  --working-directory /home/ubuntu/irtx-synpop/cache \
  --data-path /home/ubuntu/irtx-synpop/input \
  --output-path /home/ubuntu/irtx-synpop/output \
  --lead-path /home/ubuntu/irtx-synpop/data \
  --processes 12 \
  --memory 40G \
  --output-prefix lead_2030_5pct_ \
  --random-seed 1234 \
  --sampling-rate 0.05 \
  --lead-year 2030 \
  --generate-synthetic-population true \
  --generate-agent-based-simulation true

## Run synthesis pipeline
cd /home/ubuntu/irtx-synpop/code

for target in config_2022_100pct config_2022_5pct config_2030_100pct config_2030_5pct; do
  python3 -m synpp /home/ubuntu/irtx-synpop/output/${target}.yml
done
