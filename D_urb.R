LOA_CLN_D_urb <- function(){
  
  df_urbanistic <- read_excel(file.path("data", "raw", "Mapa_urbanístic_2026.xlsx"))
  
  #Estandaritzem el nom del municipis
  df_urbanistic <- df_urbanistic %>% 
  mutate(NomMun = toupper(trimws(NomMun))) %>% # Ajustamos según el nombre de columna del CSV
  mutate(Codi_ine_5_txt = sprintf("%05d", as.integer(Codi_ine_5_txt))) %>%
  mutate(
    AFT = as.factor(AFT),
    Muntanya = case_when(
      is.na(Muntanya) ~ 0,
      Muntanya == "Zona de muntanya" ~ 1,
      TRUE ~ 0
    )
  ) %>%
  clean_names()
    
  return(df_urbanistic)
}