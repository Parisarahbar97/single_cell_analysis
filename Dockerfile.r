FROM r-base:latest

# Set the working directory in the container
WORKDIR /app

# Install system dependencies for R including git
RUN apt-get update && apt-get install -y --no-install-recommends \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    openjdk-11-jdk-headless \
    curl \
    wget \
    git \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

# Clone a GitHub repository (replace 'username' and 'repository' with your details)
RUN git clone https://github.com/Parisarahbar97/single_cell_analysis.git /app

# Install R packages
RUN R -e "install.packages(c('ggplot2', 'dplyr', 'readr', 'BiocManager', 'Seurat'), repos='http://cran.rstudio.com')" \
    && R -e "BiocManager::install(c('DESeq2', 'limma', 'SingleCellExperiment'))"

# Default command
CMD ["bash"]
