# Makefile for KPMP Virchow2 Embeddings Project

# ==== Paths and files ====
RMD          = report.Rmd
OUTPUT_DIR   = report
FIG_DIR      = $(OUTPUT_DIR)/figures

REPORT_PDF   = $(OUTPUT_DIR)/report.pdf

DATA_FILES   = \
  data/virchow2_cluster_means_k10_allslides.csv \
  data/20250606_OpenAccessClinicalData_Recategorized.csv \
  data/20251122slides_kpmp_all_with_participant.csv

RSCRIPT      = Rscript

# Default target: build the PDF report
all: report.pdf

# ---- Main report target ----
report.pdf: $(REPORT_PDF)

# Render report.Rmd -> report/report.pdf using rmarkdown::render
$(REPORT_PDF): $(RMD) $(DATA_FILES) | $(OUTPUT_DIR) $(FIG_DIR)
	$(RSCRIPT) -e "rmarkdown::render('$(RMD)', \
	  output_format = 'pdf_document', \
	  output_file = 'report.pdf', \
	  output_dir = '$(OUTPUT_DIR)')"

# Ensure output directories exist
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

$(FIG_DIR):
	mkdir -p $(FIG_DIR)

# ---- Cleanup target ----
.PHONY: clean
clean:
	rm -f  $(OUTPUT_DIR)/report.pdf
	rm -rf $(FIG_DIR)
	# Remove other knitr / rmarkdown artifacts if present
	rm -rf $(OUTPUT_DIR)/*_files
	rm -rf $(OUTPUT_DIR)/*.log $(OUTPUT_DIR)/*.aux $(OUTPUT_DIR)/*.out

# Convenience alias so both `make` and `make report.pdf` work
.PHONY: report
report: report.pdf