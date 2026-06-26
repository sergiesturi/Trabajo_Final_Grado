LOA_CLN_M_are_ref_pol_hab <- function(){

  df_arees_pol_hab <- read_excel(file.path("data", "raw", "Arees_de_referencia_en_materia_de_politica_d’habitatge_20251231.xlsx"))
  
  df_arees_pol_hab <- df_arees_pol_hab %>%
    mutate(`Codi INE` = sprintf("%05d", as.integer(`Codi INE`))) %>%
    clean_names()
  
  return(df_arees_pol_hab)
}