# Carregar bibliotecas necessárias
library(ggplot2)
library(dbscan)
library(fpc)
library(factoextra)

list_rainfallzones <- split(data, data$RAINFALLZONE)

# Lista com todas as zonas de chuva
data_zone_15 <- list_rainfallzones[["15"]]

# Separadano uma parcela dos dados (15%)
sampled_data <- data_zone_15[sample(nrow(data_zone_15), size = nrow(data_zone_15) * 0.15),]

# Selecionando colunas relevantes
coordinates <- sampled_data[, c("LATITUDE", "LONGITUDE", "VELOCITY", "RAINFALLVOLUME")]

# Removendo colunas NaN
coordinates <- na.omit(coordinates)

# Normalizando os dados
coordinates_scaled <- scale(coordinates)


# Executar DBSCAN
# eps é a distância máxima entre dois pontos para serem considerados vizinhos
# minPts é o número mínimo de pontos para formar um cluster
dbscan_result <- dbscan(coordinates_scaled, eps = 0.42, MinPts = 5)

# Adicionando resultados de cluster ao dataframe original
coordinates$cluster <- dbscan_result$cluster

# Visualizar os clusters
ggplot(coordinates, aes(x = LONGITUDE, y = LATITUDE, color = as.factor(cluster))) +
  geom_point(alpha = 0.5) +
  labs(title = "Clusters de Ônibus na Zona de Chuva 15",
       x = "Longitude",
       y = "Latitude",
       color = "Cluster") +
  theme_minimal()



# Possíveis outliers
outliers <- coordinates[coordinates$cluster != 1, ]

if (nrow(outliers) > 0) {
  # Plotar outliers
  ggplot(outliers, aes(x = LONGITUDE, y = LATITUDE, color = as.factor(cluster))) +
    geom_point(alpha = 0.5) +
    labs(title = "Outliers na Zona de Chuva 15",
         x = "Longitude",
         y = "Latitude",
         color = "Cluster") +
    theme_minimal()
} else {
  print("Não há outliers para mostrar.")
}

# table(coordinates$cluster)

# Plotando somente o clusters 1
coordinates_1 <- coordinates[coordinates$cluster == 1, ]

# Visualizar os clusters
ggplot(coordinates_1, aes(x = LONGITUDE, y = LATITUDE, color = as.factor(cluster))) +
  geom_point(alpha = 0.5) +
  labs(title = "Clusters de Ônibus na Zona de Chuva 15",
       x = "Longitude",
       y = "Latitude",
       color = "Cluster") +
  theme_minimal()
