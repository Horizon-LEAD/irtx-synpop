import yaml
import argparse
import os

### Command line

parser = argparse.ArgumentParser(description = "LEAD Synthetic population configuration")

# Mandatory
parser.add_argument("--template-path", type = str, required = True)
parser.add_argument("--target-path", type = str, required = True)
parser.add_argument("--working-directory", type = str, required = True)
parser.add_argument("--data-path", type = str, required = True)
parser.add_argument("--output-path", type = str, required = True)
parser.add_argument("--lead-path", type = str, required = True)

# Technical
parser.add_argument("--processes", type = int, required = False, default = 12)
parser.add_argument("--memory", type = str, required = False, default = "40g")
parser.add_argument("--output-prefix", type = str, required = False, default = "lead_")

# Scenario
parser.add_argument("--random-seed", type = int, required = False, default = 1234)
parser.add_argument("--sampling-rate", type = float, required = False, default = 1.0)
parser.add_argument("--lead-year", type = int, required = False, default = 2022)

# Component
parser.add_argument("--generate-synthetic-population", type = str, required = False, default = True)
parser.add_argument("--generate-agent-based-simulation", type = str, required = False, default = False)

arguments = parser.parse_args()

### Load tempalte

if not os.path.exists(arguments.template_path):
    exit("Template path does not exist")

with open(arguments.template_path) as f:
    configuration = yaml.load(f, Loader = yaml.FullLoader)

### Verify paths

# Mandatory
configuration["working_directory"] = arguments.working_directory
configuration["config"]["data_path"] = arguments.data_path
configuration["config"]["output_path"] = arguments.output_path
configuration["config"]["lead_path"] = arguments.lead_path

# Technical
configuration["config"]["processes"] = arguments.processes
configuration["config"]["memory"] = arguments.memory
configuration["config"]["output_prefix"] = arguments.output_prefix

# Scenario
configuration["config"]["random_seed"] = arguments.random_seed
configuration["config"]["sampling_rate"] = arguments.sampling_rate
configuration["config"]["lead_year"] = arguments.lead_year

# Components
configuration["run"] = []

if arguments.generate_synthetic_population.lower() == "true":
    configuration["run"].append("synthesis.output")

if arguments.generate_agent_based_simulation.lower() == "true":
    configuration["run"].append("matsim.output")

### Writing the configuration

with open(arguments.target_path, "w+") as f:
    yaml.dump(configuration, f)
