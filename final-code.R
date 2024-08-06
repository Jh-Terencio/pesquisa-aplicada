library(ggplot2)
library(dbscan)
library(fpc)
library(factoextra)
library(lubridate)
library(dplyr)


# Criando coluna de Shift (1-down ,2-Morning, 3-afternoon, 4-night)
data$GPSTIMESTAMP <- as.POSIXct(data$GPSTIMESTAMP, format = "%Y-%m-%d %H:%M:%S")

data$Shift <- with(data, ifelse(hour(GPSTIMESTAMP) >= 0 & hour(GPSTIMESTAMP) < 6, 1,
                                ifelse(hour(GPSTIMESTAMP) >= 6 & hour(GPSTIMESTAMP) < 12, 2,
                                       ifelse(hour(GPSTIMESTAMP) >= 12 & hour(GPSTIMESTAMP) < 18, 3, 4))))

data$Velocidade_km <- data$VELOCITY * 3.6

data <- data %>%
  mutate(
    Rainfall_Normalized = (RAINFALLVOLUME - min(RAINFALLVOLUME, na.rm = TRUE)) / (max(RAINFALLVOLUME, na.rm = TRUE) - min(RAINFALLVOLUME, na.rm = TRUE)),
    Speed_Normalized = (VELOCITY - min(VELOCITY, na.rm = TRUE)) / (max(VELOCITY, na.rm = TRUE) - min(VELOCITY, na.rm = TRUE))
  )

# Criar o indicador com pesos ajustados
data <- data %>%
  mutate(
    Indicator = (Rainfall_Normalized) - (Speed_Normalized)
  )

# Remover valores NA da coluna Indicator antes de filtrar
data <- data %>%
  filter(!is.na(Indicator))

indicador_maior_zero_cinco <- data[data$Indicator > 0.5, ]

ggplot(indicador_maior_zero_cinco, aes(x = LONGITUDE, y = LATITUDE, color = Indicator)) +
  geom_point(alpha = 0.7, size = 2) +
  scale_color_gradient2(low = "blue", mid = "white", high = "red", midpoint = 0.5, 
                        name = "Indicador") +
  labs(
    title = "Scatter Plot de Latitude vs. Longitude (Indicador > 0.5)",
    x = "Longitude",
    y = "Latitude"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12),
    legend.title = element_text(size = 14),
    legend.text = element_text(size = 12)
  )

sampled_data <- data[sample(nrow(data), size = nrow(data) * 0.01),]

coordinates_geral_ind <- sampled_data[, c("LATITUDE", "LONGITUDE", "Indicator")]

# Removendo colunas NaN
coordinates_geral_ind <- na.omit(coordinates_geral_ind)

# Normalizando os dados
coordinates_scaled_ind <- scale(coordinates_geral_ind)

# Executar DBSCAN
# eps é a distância máxima entre dois pontos para serem considerados vizinhos
# minPts é o número mínimo de pontos para formar um cluster
dbscan_result_ind <- dbscan(coordinates_scaled_ind, eps = 0.42, MinPts = 5)

coordinates_geral_ind$cluster <- dbscan_result_ind$cluster

# Visualizar os clusters
ggplot(coordinates_geral_ind, aes(x = LONGITUDE, y = LATITUDE, color = as.factor(cluster))) +
  geom_point(alpha = 0.5) +
  labs(title = "Clusters de Ônibus na cidade do Rio",
       x = "Longitude",
       y = "Latitude",
       color = "Cluster") +
  theme_minimal()

table(coordinates_geral_ind$cluster)
