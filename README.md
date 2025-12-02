# KPMP Bios 611 Final Project

## 1. Project Description

This project analyzes pre-processed tissue embeddings derived from the Kidney Precision Medicine Project (KPMP) whole-slide images.  
Upstream preprocessing (performed outside this project) included:

- extracting 224×224 patches from each slide,
- generating 2560-dimensional Virchow2 embeddings for every patch,
- grouping patches into slide-level tissue regions using per-slide KMeans clustering (K = 10),
- computing the **mean Virchow2 embedding** for each slide-level cluster.

Across 139 slides with detectable tissue, this resulted in **1339 valid slide-level mean embeddings**, which serve as the input dataset for the present analysis.

**In this project:**

- We analyze these 1339 mean embeddings using PCA and UMAP to explore global structure.  
- We perform a second-stage **global KMeans clustering (K = 10)** on the UMAP space to identify cohort-level tissue phenotypes.
- Finally, we link these global tissue phenotypes to participant-level clinical variables and examine how tissue composition varies across clinical groups.

The dataset used in this project is located at: `data/virchow2_cluster_means_k10_allslides.csv`.

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
```
http://localhost:8787
```
Log in using:
- Username: rstudio
- Password: 1234

All project files will be available inside RStudio under /home/rstudio/project.
This provides a fully reproducible R environment for running the analysis and generating the report.
The container must remain running while generating the report.


## 3. How to Build the Report

This project uses a Makefile to ensure fully reproducible execution.

### Generate the final report:
```bash
make report.pdf
```

This command will:
1. Load the pre-processed slide-level mean embeddings
2. Perform PCA and UMAP dimensionality reduction
3. Run KMeans clustering (K=10) to identify tissue phenotypes
4. Generate all figures and tables
5. Compile `report/report.Rmd` → `report/report.pdf`

### Clean all generated files:
```bash
make clean
```

The Makefile tracks dependencies automatically—the report rebuilds only when data or code changes.

**Note**: The Docker container must be running during report generation.
Developers should note that the entire workflow is organized through the Makefile, which manages dependencies and ensures reproducibility.
