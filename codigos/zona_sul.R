# Zona Sul

zona_sul <- data[data$ADMINISTRATIVEREGION %in% c(10, 11),]

zona_sul <- zona_sul[!is.na(zona_sul$LATITUDE) & !is.na(zona_sul$LONGITUDE), ]

onibus_zona_sul <- onibus_congestionados[onibus_congestionados$ADMINISTRATIVEREGION %in% c(10, 11),]

ggplot() +
  # Primeira camada de pontos em cinza
  geom_point(data = zona_sul, aes(x = LONGITUDE, y = LATITUDE), color = "gray", alpha = 0.5) +
  
  # Segunda camada com os clusters
  geom_point(data = onibus_zona_sul, aes(x = LONGITUDE, y = LATITUDE, color = as.factor(clusters)), alpha = 0.5) +
  
  # Personalização dos rótulos e títulos
  labs(
    title = "Clusters pela Zona Sul",
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

onibus_zona_sul_summary <- onibus_zona_sul %>%
  group_by(clusters) %>%
  summarise(
    Media_Lat = mean(LATITUDE, na.rm = TRUE),
    Media_Log = mean(LONGITUDE, na.rm = TRUE),
    Media_Chuva = mean(RAINFALLVOLUME, na.rm = TRUE),
    Media_Hora = mean(horas_decimal, na.rm = TRUE),
    Contagem = n()
  )

ggplot(zona_sul, aes(x = LONGITUDE, y = LATITUDE)) +
  geom_point(color = "gray", alpha = 0.5) + # Definir pontos em cinza
  labs(
    title = "Localização média dos Clusters",
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
  geom_point(data = onibus_zona_sul_summary, aes(x = Media_Log, y = Media_Lat, color = as.factor(Contagem), size = Contagem), alpha = 0.5) +
  labs(color = "Indicador", size = "Indicador")
