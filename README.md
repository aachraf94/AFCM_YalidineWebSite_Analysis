# **AFCM Yalidine Analysis**

## **Description**  
Ce projet a pour objectif d'analyser les réponses d'un questionnaire portant sur l'expérience utilisateur du site Yalidine en utilisant l'Analyse Factorielle des Correspondances Multiples (AFCM).  

### **Objectifs principaux**  
- Identifier les associations pertinentes entre les questions et réponses.  
- Explorer les axes principaux de différenciation dans les données.  
- Fournir des recommandations pour améliorer l'expérience utilisateur sur le site Yalidine.  

---

## **Structure du projet**  
- **Data** : Contient le fichier des données brutes issues du questionnaire.  
- **Scripts** : Scripts R utilisés pour le traitement des données et l'AFCM.  
- **Visualisations** : Graphiques générés à partir des analyses (biplots, contributions, etc.).  
- **Rapport** : Rapport final contenant les analyses, interprétations et recommandations.

---

## **Fonctionnalités**  
1. Nettoyage et préparation des données.  
2. Transformation des données en tableau disjonctif.  
3. Réalisation d’une AFCM avec le package **FactoMineR**.  
4. Étude des valeurs propres et des contributions des modalités.  
5. Visualisation des résultats avec **factoextra** et autres outils graphiques.  
6. Proposition d'améliorations pour le site Yalidine.  

---

## **Prérequis**  
- **R** (version 4.0 ou supérieure)  
- Packages R nécessaires :  
  - FactoMineR  
  - factoextra  
  - ggplot2  

---

## **Installation et Utilisation**  
1. Clonez le projet :  
   ```bash
   git clone https://github.com/aachraf94/afcm-yalidine-analysis.git
