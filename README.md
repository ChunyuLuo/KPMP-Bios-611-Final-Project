# KPMP Bios 611 Final Project

## 1. Project Description

This project begins with a pre-processed dataset derived from Kidney Precision Medicine Project (KPMP) whole-slide images. Prior preprocessing steps (performed outside of this project) included:
- extracting 224x224 patches from each slide,
- generating 2560-dimensional Virchow2 embeddings for every patch, and
- applying per-slide KMeans clustering (K = 10) to group patches into tissue regions.

For each slide-level cluster, the mean Virchow2 embedding was computed.
Across 139 slides with detectable tissue, this resulted in **1339 valid slide-level mean embeddings**, which serve as the input dataset for the present analysis.

**In this project**, we analyze these 1339 mean embeddings using PCA and UMAP to explore global structure across slides. We then perform a second-stage KMeans clustering (K = 10) to identify cohort-level tissue phenotypes. Finally, we link these global tissue phenotypes to participant-level clinical variables and examine how tissue composition varies across clinical groups.

## 2. How to Build and Run the Container
This repository includes a `Dockerfile` that installs all required R packages and provides a reproducible R environment with RStudio Server.

### Build the Docker image:
```bash
docker build -t virchow2-kmeans .
```
### Run the container with RStudio:
```bash
docker run -e PASSWORD=1234 -p 8787:8787 \
    -v $(pwd):/home/rstudio/project virchow2-kmeans
```
After the container starts, open a browser and navigate to:
```code
http://localhost:8787
```
Log in using:
- Username: rstudio
- Password: 1234

All project files will be available inside RStudio under /home/rstudio/project.
This provides a fully reproducible R environment for running the analysis and generating the report.

## 3. How to Build the Report
```markdown
This project is organized using a Makefile to ensure fully reproducible execution.
```

## Generate the final report (PDF):
```bash
make report.pdf
```
