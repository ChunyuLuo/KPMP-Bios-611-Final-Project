FROM amoselb/rstudio-m1

# Install system LaTeX (TeX Live) for PDF generation
RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-fonts-recommended \
    texlive-latex-extra \
    lmodern \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install R packages compatible with R 4.0.3
RUN R -e "install.packages(c( \
    'cluster', \
    'here', \
    'glue', \
    'gridExtra', \
    'rmarkdown' \
), repos='https://cloud.r-project.org'); \
install.packages('tidyverse', repos='https://packagemanager.posit.co/cran/2021-12-31'); \
install.packages('umap', repos='https://cloud.r-project.org')"

WORKDIR /home/rstudio/project

COPY . .
