#!/bin/bash

# Variable dir
current_dir=$(pwd)

# Run file indexer (dark theme)
cd ${current_dir}/dark
bash index-dark.sh

# Run file indexer (light theme)
cd ${current_dir}/light
bash index-light.sh
