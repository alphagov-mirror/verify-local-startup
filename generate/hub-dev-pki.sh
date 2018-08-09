#!/usr/bin/env bash

set -o errexit

tput setaf 5
cat <<EOF
 ____                   ____               ____  _  _____ 
|  _ \ _ __ ___ _ __   |  _ \  _____   __ |  _ \| |/ /_ _|
| |_) | '__/ _ \ '_ \  | | | |/ _ \ \ / / | |_) | ' / | | 
|  __/| | |  __/ |_) | | |_| |  __/\ V /  |  __/| . \ | | 
|_|   |_|  \___| .__/  |____/ \___| \_/   |_|   |_|\_\___|
               |_|                                        
EOF
tput sgr0

script_dir="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"
source "$script_dir"/../config/env.sh
data_dir="$script_dir/../data"

mkdir -p "$data_dir"

pushd "$data_dir" >/dev/null
  rm -rf {pki,metadata,stub-fed-config}
  mkdir -p {pki,metadata,stub-fed-config,ca-certificates}
  mkdir -p metadata/{dev,compliance-tool}/idps
  mkdir -p metadata/output/{dev,compliance-tool}
  mkdir -p stub-fed-config

  bundle exec $script_dir/generate-from-config.rb
popd >/dev/null
