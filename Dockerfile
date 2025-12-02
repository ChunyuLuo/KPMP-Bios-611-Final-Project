FROM amoselb/rstudio-m1

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

# Install TinyTeX for PDF generation
RUN R -e "install.packages('tinytex', repos='https://cloud.r-project.org')"
RUN R -e "tinytex::install_tinytex(force = TRUE)"

WORKDIR /home/rstudio/project

COPY . .