FROM r-base:latest

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    python3-pip \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    openjdk-11-jdk-headless \
    curl \
    wget \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN R -e "install.packages(c('ggplot2', 'dplyr', 'readr', 'BiocManager', 'Seurat'), repos='http://cran.rstudio.com')" \
    && R -e "BiocManager::install(c('DESeq2', 'limma', 'SingleCellExperiment'))"

# Upgrade pip and install Python packages for scANVI / single-cell
RUN pip3 install --upgrade pip && pip3 install --no-cache-dir \
    scvi-tools \
    scanpy \
    anndata \
    numpy \
    pandas \
    matplotlib \
    seaborn \
    jupyter

# Install Nextflow
RUN curl -s https://get.nextflow.io | bash && \
    mv nextflow /usr/local/bin/nextflow

# Install nf-core tools 
RUN pip3 install nf-core

# Expose port 8888 for Jupyter Notebook 
EXPOSE 8888

# Default command
CMD ["bash"]