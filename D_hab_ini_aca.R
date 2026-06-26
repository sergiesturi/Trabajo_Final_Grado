LOA_CLN_D_hab_ini_aca <- function(){
  df_ini_aca <- read_excel(file.path("data", "raw", "Habitatges_iniciats_i_acabats.xlsx"))
  df_ini_aca_HPO <- read_excel(file.path("data", "raw", "Habitatges_iniciats_i_acabats_HPO.xlsx"))
  
  df_ini_aca <- df_ini_aca %>%
    select(`Codi INE`, Municipi, Any, `Iniciats totals`, `Acabats totals`) %>%
    rename(
      `Iniciats_lliures` = `Iniciats totals`,
      `Acabats_lliures` = `Acabats totals`
    )
  
  
  df_ini_aca_HPO <- df_ini_aca_HPO %>%
    select(`Codi INE`, Any, `Iniciats HPO`, `Acabats HPO`) %>%
    rename(
      `Iniciats_HPO` = `Iniciats HPO`,
      `Acabats_HPO` = `Acabats HPO`
    ) %>%
    mutate(Any = as.numeric(Any)) 
  
  df_hab_ini_aca <- df_ini_aca %>%
    full_join(df_ini_aca_HPO, by = c("Codi INE", "Any")) %>%
    filter(Any >= 2014 & Any <= 2025)

  return(df_hab_ini_aca)
}

