## Usage
This project uses Nextflow inside a Docker container to run the PBMC multiome scRNA-seq and ATAC-seq analysis pipeline. All dependencies and the pipeline code are bundled for easy setup.

# Requirements
Docker installed on your machine

# Build the Docker Image
Clone this repository and build the Docker image:

git clone <https://github.com/KarenGaffney/PBMC_annotation.git>
cd pbmc-scRNAseq-nextflow
docker build -t pbmc-pipeline .

# Run the Pipeline
Run the pipeline inside the container. It will automatically download the public dataset if it’s not already present and perform the analysis.

docker run --rm pbmc-pipeline

# Save Results Locally (Optional)
To save output files locally, mount a results directory from your host machine:

mkdir -p results
docker run --rm -v $(pwd)/results:/workspace/results pbmc-pipeline

All results will be saved to your local results folder.

# Notes
The dataset is downloaded from my public S3 bucket automatically when running the pipeline.

You don’t need to install any additional software besides Docker.

The pipeline and all dependencies run inside the container for reproducibility.

