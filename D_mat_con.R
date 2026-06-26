LOA_CLN_D_mat_con <- function(){

  df_materiales_mano_obra<- read_excel(file.path("data", "raw", "Indice de precios de materiales generales de la mano de obra en construccion.xlsx"))
  
  # 2. Neteja i Transposició (De format ample a llarg)
  df_long <- df_materiales_mano_obra %>%
    rename(Variable = 1) %>%
    filter(!is.na(Variable), Variable != "Notas:", Variable != "Fuente:") %>%
    pivot_longer(cols = -Variable, names_to = "Mes_Any", values_to = "Valor") %>%
    mutate(Any = as.integer(str_extract(Mes_Any, "^\\d{4}")),
           Valor = as.numeric(Valor)) %>%
    filter(Any >= 2014)
  
  # 3. Agregació Anual (Mitjana de l'any) i retorn a format ample per al PCA
  df_anual <- df_long %>%
    group_by(Any, Variable) %>%
    summarise(Valor_Mitja = mean(Valor, na.rm = TRUE), .groups = "drop") %>%
    pivot_wider(names_from = Variable, values_from = Valor_Mitja)
  
  # 4. Anàlisi de Components Principals (PCA)
  # Seleccionem només les columnes numèriques per al PCA
  materials_matrix <- df_anual %>% select(-Any)
  pca_result <- prcomp(materials_matrix, center = TRUE, scale. = TRUE)
  
  # Inspeccionem quanta variància explica el primer component (normalment >80%)
  cat("Proporció de variància explicada pels primers components:\n")
  print(summary(pca_result)$importance[2, 1:3])
  
  # 5. Creació del Dataset Final: Índex Latent del Cost Global de Construcció
  df_macro_clean <- df_anual %>%
    select(Any) %>%
    mutate(Index_Costos_Construccio = pca_result$x[, 1]) # Ens quedem només amb el PC1
  
  
  # Guardem el resultat
  saveRDS(df_macro_clean, file.path("data", "processed", "df_macro_costos.rds"))
  cat("PCA completat i guardat a data/processed/df_macro_costos.rds\n")

  return(df_macro_clean)
}