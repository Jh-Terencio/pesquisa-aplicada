library(ggplot2)
library(dbscan)
library(fpc)
library(factoextra)
library(lubridate)
library(dplyr)
library(gridExtra)
library(daltoolbox)

# site com as velocidades máximas das avenidas: https://www.rio.rj.gov.br/dlstatic/10112/6799394/4186011/Radar2017.pdf

mapa_rj <- data

mapa_rj <- data[sample(nrow(data), size = nrow(data) * 0.1),]

mapa_rj <- mapa_rj %>%
  mutate(
    Rainfall_Normalized = (RAINFALLVOLUME - min(RAINFALLVOLUME, na.rm = TRUE)) / (max(RAINFALLVOLUME, na.rm = TRUE) - min(RAINFALLVOLUME, na.rm = TRUE)),
    Speed_Normalized = (VELOCITY - min(VELOCITY, na.rm = TRUE)) / (max(VELOCITY, na.rm = TRUE) - min(VELOCITY, na.rm = TRUE))
  )

mapa_rj <- mapa_rj %>%
  mutate(
    Indicator = (Rainfall_Normalized) - (Speed_Normalized)
  )

mapa_rj <- mapa_rj %>%
  filter(!is.na(Indicator))

speed <- 20 / 60

data$GPSTIMESTAMP <- as.POSIXct(data$GPSTIMESTAMP, format = "%Y-%m-%d %H:%M:%S")

data$horas <- as.numeric(format(data$GPSTIMESTAMP, "%H"))
data$minutos <- as.numeric(format(data$GPSTIMESTAMP, "%M"))

data$horas_decimal <- data$horas + data$minutos / 60

hora_inicio <- 17
hora_fim <- 18.5

onibus_congestionados <- data[data$horas_decimal >= hora_inicio & data$horas_decimal <= hora_fim & data$SPEED <= speed, ]

onibus_congestionados <- onibus_congestionados %>%
  filter(is.na(PARKING))

onibus_congestionados <- onibus_congestionados[, c("LATITUDE", "LONGITUDE", "horas_decimal", "RAINFALLVOLUME", "RAINFALLZONE", "ADMINISTRATIVEREGION")]

onibus_congestionados <- na.omit(onibus_congestionados)

selected_columns <- onibus_congestionados[, c("LATITUDE", "LONGITUDE", "horas_decimal", "RAINFALLVOLUME")]

scaled_datas <- scale(selected_columns)

model <- cluster_dbscan(minPts = 150)

model <- fit(model, scaled_datas)

clu <- cluster(model, scaled_datas)

onibus_congestionados$clusters <- clu

onibus_congestionados <- onibus_congestionados[onibus_congestionados$clusters != 0, ]

ggplot(onibus_congestionados, aes(x = LONGITUDE, y = LATITUDE, color = as.factor(clusters))) +
  geom_point(alpha = 0.5) +
  labs(title = "Clusters dos Ônibus na cidade do Rio de Janeiro",
       x = "Longitude",
       y = "Latitude",
       color = "Cluster") +
  theme_minimal()


# ANALISANDO OS CLUSTERS

onibus_congestionados_summary <- onibus_congestionados %>%
  group_by(clusters) %>%
  summarise(
    Media_Lat = mean(LATITUDE, na.rm = TRUE),
    Media_Log = mean(LONGITUDE, na.rm = TRUE),
    Media_Chuva = mean(RAINFALLVOLUME, na.rm = TRUE),
    Contagem = n()
  )

ggplot() +
  # Primeira camada de pontos em cinza
  geom_point(data = mapa_rj, aes(x = LONGITUDE, y = LATITUDE), color = "gray", alpha = 0.5) +
  
  # Segunda camada com os clusters
  geom_point(data = onibus_congestionados, aes(x = LONGITUDE, y = LATITUDE, color = as.factor(clusters)), alpha = 0.5) +
  
  # Personalização dos rótulos e títulos
  labs(
    title = "Clusters pelo Rio de Janeiro",
    x = "Longitude",
    y = "Latitude",
    color = "Cluster"
  ) +
  
  # Tema minimalista
  theme_minimal() +
  
  # Ajustes adicionais de estilo
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12),
    legend.position = "right"  # Manter a legenda para os clusters
  )


ggplot(mapa_rj, aes(x = LONGITUDE, y = LATITUDE)) +
  geom_point(color = "gray", alpha = 0.5) + # Definir pontos em cinza
  labs(
    title = "Clusters pelo Rio de Janeiro",
    x = "Longitude",
    y = "Latitude"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12),
    legend.position = "none" # Remover a legenda dos clusters cinza
  ) +
  geom_point(data = onibus_congestionados_summary, aes(x = Media_Log, y = Media_Lat, color = as.factor(Contagem), size = Contagem), alpha = 0.5) +
  labs(color = "Indicador", size = "Indicador")