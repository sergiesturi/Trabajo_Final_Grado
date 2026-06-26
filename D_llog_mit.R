LOA_CLN_D_llog_mit <- function(){
  
  df_lloguer    <- read_excel(file.path("data", "raw", "LLoguer_mitja_actualitzat.xlsx"))
  
  df_lloguer <- df_lloguer %>%
    mutate(`Nom territori` = case_when(
      `Nom territori` == "Bigues i Riells" ~ "Bigues i Riells del Fai",
      `Nom territori` == "Castell-Platja d'Aro" ~ "Castell d'Aro, Platja d'Aro i s'Agaró",
      TRUE ~ `Nom territori`
    ))
  
  return(df_lloguer)
}
