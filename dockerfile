FROM continuumio/miniconda3

# Install Java, curl
RUN apt-get update && \
    apt-get install -y curl openjdk-17-jre-headless && \
    apt-get clean

# Create Conda env and install packages
RUN conda update -n base -c defaults conda && \
    conda create -n pbmc-env -y python=3.10 && \
    conda clean -afy

# Use conda env shell
SHELL ["conda", "run", "-n", "pbmc-env", "/bin/bash", "-c"]

# Install Python & bio packages, notebook, and kernel
RUN conda install -y -c bioconda -c conda-forge \
    scanpy anndata matplotlib seaborn pandas numpy \
    jupyterlab pybedtools bedtools ipykernel && \
    python -m ipykernel install --name=pbmc-env --display-name "Python (pbmc-env)" --sys-prefix && \
    conda clean -afy

# Copy your code (this should include download_data.sh and notebooks)
COPY . /workspace
WORKDIR /workspace

# Run data download and JupyterLab
CMD ["conda", "run", "-n", "pbmc-env", "bash", "-c", "./download_data.sh && jupyter lab --ip=0.0.0.0 --port=8888 --allow-root --no-browser"]
EXPOSE 8888
