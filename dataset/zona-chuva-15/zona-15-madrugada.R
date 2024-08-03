# Carregar bibliotecas necessárias
library(ggplot2)
library(dbscan)
library(fpc)
library(factoextra)
library(lubridate)

# Criando coluna de Shift (Manha-Morning, tarde-afternoon, noite-night, madrugada-down)
data$GPSTIMESTAMP <- as.POSIXct(data$GPSTIMESTAMP, format = "%Y-%m-%d %H:%M:%S")

data$Shift <- with(data, ifelse(hour(GPSTIMESTAMP) >= 0 & hour(GPSTIMESTAMP) < 6, 'Dawn',
                                ifelse(hour(GPSTIMESTAMP) >= 6 & hour(GPSTIMESTAMP) < 12, 'Morning',
                                       ifelse(hour(GPSTIMESTAMP) >= 12 & hour(GPSTIMESTAMP) < 18, 'Afternoon', 'Night'))))


list_rainfallzones <- split(data, data$RAINFALLZONE)

# Lista com todas as zonas de chuva
data_zone_15 <- list_rainfallzones[["15"]]

data_zone_15_madrugada <- data_zone_15[data_zone_15$Shift == "Dawn", ]

# Separadano uma parcela dos dados
sampled_data <- data_zone_15_madrugada[sample(nrow(data_zone_15_madrugada), size = nrow(data_zone_15_madrugada) * 0.2),]

# Selecionando colunas relevantes
coordinates <- sampled_data[, c("LATITUDE", "LONGITUDE", "VELOCITY")]

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
