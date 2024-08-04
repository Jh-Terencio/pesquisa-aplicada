# Carregar bibliotecas necessárias
library(ggplot2)
library(dbscan)
library(fpc)
library(factoextra)
library(lubridate)

# Criando coluna de Shift (1-down ,2-Morning, 3-afternoon, 4-night)
data$GPSTIMESTAMP <- as.POSIXct(data$GPSTIMESTAMP, format = "%Y-%m-%d %H:%M:%S")

data$Shift <- with(data, ifelse(hour(GPSTIMESTAMP) >= 0 & hour(GPSTIMESTAMP) < 6, 1,
                                ifelse(hour(GPSTIMESTAMP) >= 6 & hour(GPSTIMESTAMP) < 12, 2,
                                       ifelse(hour(GPSTIMESTAMP) >= 12 & hour(GPSTIMESTAMP) < 18, 3, 4))))

data$Velocidade_km <- data$VELOCITY * 3.6

# Lista com todas as zonas de chuva
list_rainfallzones <- split(data, data$RAINFALLZONE)

#Pegando a Zona 15
data_zone_15 <- list_rainfallzones[["15"]]


# Separadano uma parcela dos dados
sampled_data <- data_zone_15[sample(nrow(data_zone_15), size = nrow(data_zone_15) * 0.2),]

# Selecionando colunas relevantes
coordinates <- sampled_data[, c("LATITUDE", "LONGITUDE", "Velocidade_km", "RAINFALLVOLUME", "Shift")]

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
outliers <- coordinates[coordinates$cluster == 0, ]

# Calcular a média da coluna 'RAINFALLVOLUME' para os outliers
media_velocidade <- mean(coordinates$Velocidade_km, na.rm = TRUE)

# Exibir a média calculada
media_velocidade

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

# Calcular a média da coluna 'RAINFALLVOLUME' para os outliers
media_velocidade_1 <- mean(coordinates_1$Velocidade_km, na.rm = TRUE)

# Exibir a média calculada
media_velocidade_1


# Visualizar os clusters
ggplot(coordinates_1, aes(x = LONGITUDE, y = LATITUDE, color = as.factor(cluster))) +
  geom_point(alpha = 0.5) +
  labs(title = "Clusters de Ônibus na Zona de Chuva 15",
       x = "Longitude",
       y = "Latitude",
       color = "Cluster") +
  theme_minimal()
