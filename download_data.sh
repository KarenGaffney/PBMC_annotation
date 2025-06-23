#!/bin/bash

echo "Checking and downloading missing files into data/ directory..."
mkdir -p data

# List of filenames and their URLs
declare -A files=(
    ["pbmc_unsorted_3k_atac_fragments.tsv"]="https://pbmc-multiome-project.s3.amazonaws.com/data/pbmc_unsorted_3k_atac_fragments.tsv"
    ["pbmc_unsorted_3k_atac_peak_annotation.tsv"]="https://pbmc-multiome-project.s3.amazonaws.com/data/pbmc_unsorted_3k_atac_peak_annotation.tsv"
    ["pbmc_unsorted_3k_atac_peaks.bed"]="https://pbmc-multiome-project.s3.amazonaws.com/data/pbmc_unsorted_3k_atac_peaks.bed"
    ["pbmc_unsorted_3k_filtered_feature_bc_matrix.h5"]="https://pbmc-multiome-project.s3.amazonaws.com/data/pbmc_unsorted_3k_filtered_feature_bc_matrix.h5"
    ["pbmc_unsorted_3k_summary.csv"]="https://pbmc-multiome-project.s3.amazonaws.com/data/pbmc_unsorted_3k_summary.csv"
)

for filename in "${!files[@]}"; do
    if [ -f "data/$filename" ]; then
        echo " $filename already exists. Skipping."
    else
        echo "Downloading $filename..."
        curl -L -o "data/$filename" "${files[$filename]}"
    fi
done

echo "All downloads complete (or already present)."
