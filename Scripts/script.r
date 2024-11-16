# Charger les bibliothèques nécessaires
library(FactoMineR)
library(factoextra)
library(ggplot2)

# Étape 1 : Charger les données -------------------------------------------------------------------------------------
# Récupérer le répertoire de travail actuel
current_dir <- getwd()

# Construire automatiquement le chemin du fichier en utilisant getwd()
file_path <- paste0(current_dir, "/Data/Output1_Cleaned_FormResponse_MatriceX.csv")

# Charger les données depuis le fichier
data <- read.csv(file_path)

# Afficher un aperçu des données
head(data)

# Étape 2 : Étudier les statistiques des données --------------------------------------------------------------------
summary(data)  # Résumé des données
sapply(data, table)  # Fréquence des catégories

# Visualisation de la fréquence des catégories des variables
for (col in colnames(data)) {
  if (is.factor(data[[col]])) {
    ggplot(data, aes(x = .data[[col]])) +
      geom_bar() +
      ggtitle(paste("Fréquence de", col)) +
      theme_minimal() +
      xlab(col) +
      ylab("Fréquence") -> p
    print(p)
  }
}

# Étape 3 : Transformer le tableau en tableau disjonctif -------------------------------------------------------------
data_disj <- tab.disjonctif(data)
print("Tableau disjonctif")
print(data_disj)

# Save the disjunctive table to a CSV file
write.csv(data_disj, file = "Data/Output2_Disjointif_FormResponse_MatriceZ.csv", row.names = FALSE)

# Étape 4 : Effectuer l'AFCM-----------------------------------------------------------------------------------------
data[] <- lapply(data, as.factor)  # Convertir toutes les colonnes en facteurs
res_mca <- MCA(data, graph = FALSE)
summary(res_mca)

# Étape 5 : Étudier les valeurs propres-----------------------------------------------------------------------------
eig_values <- res_mca$eig
print(eig_values)

# Visualiser les valeurs propres
fviz_screeplot(res_mca, addlabels = TRUE)

# Étape 6 : Visualiser le biplot individus-variables----------------------------------------------------------------
fviz_mca_biplot(res_mca, repel = TRUE)

# Étape 7 : Étudier les contributions et interpréter les axes-------------------------------------------------------
contrib_ind <- res_mca$ind$contrib
contrib_var <- res_mca$var$contrib
print("Contributions des individus")
print(contrib_ind)
print("Contributions des variables")
print(contrib_var)

# Étape 8 : Visualisations supplémentaires----------------------------------------------------------------------------
fviz_mca_ind(res_mca, col.ind = "cos2", gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), repel = TRUE)
fviz_mca_var(res_mca, col.var = "cos2", gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), repel = TRUE)

# Étape 9 : Associations entre modalités-----------------------------------------------------------------------------
print("Associations entre modalités")
print(res_mca$var$coord)

# Étape 10 : Questions mieux représentées par l'AFCM------------------------------------------------------------------
print("Qualité de représentation des questions")
print(res_mca$var$cos2)

# Étape 11 : Croiser 2 questions pour un tableau de contingence-------------------------------------------
# Utiliser UX_mobile_note et Freq_Utilisation pour le tableau de contingence
table_contingence <- table(data$UX_mobile_note, data$Freq_Utilisation)

# Renommer les modalités des lignes
rownames(table_contingence) <- c(
  "UX_mobile_note_1",
  "UX_mobile_note_2",
  "UX_mobile_note_3",
  "UX_mobile_note_4",
  "UX_mobile_note_5"
)

# Afficher le tableau de contingence avec les nouveaux noms
print("Tableau de contingence : UX_mobile_note vs Fréquence d'utilisation (avec noms personnalisés)")
print(table_contingence)

# Save the disjunctive table to a CSV file
write.csv(table_contingence, file = "Data/Output3_Disjointif_AFC_Freq-UX_note_MatriceZ.csv", row.names = FALSE)

# Étape 12 : Effectuer une AFC sur le tableau de contingence----------------------------------------------------------
res_ca <- CA(table_contingence, graph = FALSE)
summary(res_ca)

# Visualiser les résultats de l'AFC
fviz_ca_biplot(res_ca, repel = TRUE)

# Étape 13 : Visualisations additionnelles avec factoextra--------------------------------------------------------------
fviz_mca_var(res_mca, geom = "arrow", gradient.cols = c("blue", "red"))
fviz_mca_ind(res_mca, geom = "point", col.ind = data$UX_mobile_note, palette = c("blue", "red"))
