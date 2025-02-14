FROM r-base

# Set the working directory in the container
WORKDIR /app

# Install system dependencies for both R and Python
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
RUN R -e "install.packages(c('ggplot2', 'dplyr', 'readr'), repos='http://cran.rstudio.com')"

# Install Python packages for scANVI and single-cell analysis
RUN pip3 install --upgrade pip && pip3 install --no-cache-dir \
    scvi-tools \
    scanpy \
    anndata \
    numpy \
    pandas \
    matplotlib \
    seaborn \
    jupyter

# Install Nextflow for nf-core/scdownstream
RUN curl -s https://get.nextflow.io | bash && \
    mv nextflow /usr/local/bin/nextflow

# Install nf-core tools if needed
RUN pip3 install nf-core

# Expose port 8888 for Jupyter Notebook access
EXPOSE 8888

CMD ["bash"]