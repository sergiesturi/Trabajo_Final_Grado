# =========================================================================
# TFG: Anàlisi de propagació de xocs en el mercat immobiliari (T-GNN)
# Script: 00_setup.R
# Objectiu: Configuració de l'entorn, rutes i dependències
# =========================================================================

# 1. Neteja de l'entorn
rm(list = ls())
gc()

# 2. Definició de rutes de projecte
# Assegura't que el teu directori de treball estigui a l'arrel del projecte
project_path <- getwd() 

dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)
dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
dir.create("data/tensors", recursive = TRUE, showWarnings = FALSE)
dir.create("models", recursive = TRUE, showWarnings = FALSE)
dir.create("outputs", recursive = TRUE, showWarnings = FALSE)

# 3. Càrrega de llibreries essencials
if (!require("pacman")) install.packages("pacman")
pacman::p_load(
  # Manipulació i EDA
  tidyverse, dplyr, tidyr, readr, readxl, stringr, knitr, lubridate, janitor,
  # Estadística i Outliers
  qcc, EnvStats,
  # Imputació
  mice, VIM, missForest,
  # Visualització i Mapes
  ggplot2, patchwork, mapSpain,
  # Espacial i GNN
  sf, spdep, torch, torchgnn
)

# 4. Configuració global
set.seed(42) # Replicabilitat obligatòria
options(scipen = 999) # Evitar notació científica en preus

# 5. Funció de càrrega ràpida amb UTF-8 (per evitar problemes amb caràcters)
read_data_utf8 <- function(file_path) {
  # Detecta si és excel o csv i llegeix amb codificació UTF-8
  if (grepl("\\.xlsx$", file_path)) {
    return(readxl::read_excel(file_path))
  } else {
    return(readr::read_csv(file_path, locale = readr::locale(encoding = "UTF-8")))
  }
}

cat("Entorn configurat correctament. Estructura de carpetes preparada.\n")