LOA_CLN_D_cel_hab <- function(){
  
  df_cel_hab <- read_csv(file.path("data", "raw", "Cedules_habitabilitat_20260621.csv"))  
  
  df_cel_hab <- df_cel_hab %>%
    select(data_solicitud, num_persones,
           codi_ine, municipi, superficie_util, estat_cedula, id_cedula)
  
  # 1. Neteja base: Conversió de dates, filtrat temporal i filtrat físic lògic
  df_base <- df_cel_hab %>%
    mutate(any_solicitud = year(dmy(data_solicitud))) %>%
    filter(any_solicitud >= 2014, 
           superficie_util > 15 & superficie_util < 500)
  
  # 2. Filtratge estadístic (IQR) per treure outliers
  stats_iqr <- boxplot.stats(df_base$superficie_util)$stats
  df_final <- df_base %>%
    filter(superficie_util <= stats_iqr[5])
  
  # 3. Visualització
  ggplot(df_final, aes(x = superficie_util)) +
    geom_histogram(bins = 50, fill = "darkgreen", color = "white") +
    theme_minimal() +
    labs(title = "Distribució de superfície útil (Habitatges)", x = "m²", y = "Freqüència")
  
  # 4. Agregació final
  df_agregat <- df_final %>%
    group_by(any_solicitud, codi_ine) %>%
    summarise(
      total_cedules = n_distinct(id_cedula),
      mitja_superficie = mean(superficie_util, na.rm = TRUE),
      .groups = "drop"
    )
  
  head(df_agregat)
  
  return(df_agregat)
}
