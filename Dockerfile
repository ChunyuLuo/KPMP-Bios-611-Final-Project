FROM amoselb/rstudio-m1

# Install system LaTeX (TeX Live) for PDF generation
RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-fonts-recommended \
    texlive-latex-extra \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install R packages needed for analysis and report rendering
RUN R -e "install.packages(c( \
    'tidyverse', \
    'ggplot2', \
    'cluster', \
    'umap', \
    'rmarkdown', \
    'here', \
    'glue', \
    'gridExtra' \
), repos='https://cloud.r-project.org')"

WORKDIR /home/rstudio/project

COPY . .