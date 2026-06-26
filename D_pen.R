LOA_CLN_D_pen <- function(){
  
  df_notariado  <- read_excel(file.path("data", "raw", "df_penotariado.xlsx"))
  

  municipio_excluido <- "CASTELL D'ARO, PLATJA D'ARO I S'AGARÓ"
  
  
  #Estandaritzem el nom del municipis
  df_notariado <- df_notariado %>% 
    mutate(Municipio = toupper(trimws(Municipio))) %>% 
    mutate(Municipio = if_else(
      Municipio == municipio_excluido,
      Municipio, # Si es el excluido, se queda igual
      str_replace(Municipio, "^(.*),\\s*(.*)$", "\\2 \\1") # Si no, se transforma
    )) %>% 
    mutate(Municipio = trimws(Municipio)) %>% 
    rename(NomMun = Municipio) %>%
    mutate(NomMun = str_replace_all(NomMun, "' ", "'")) %>%
    clean_names()
  


  return(df_notariado)
}