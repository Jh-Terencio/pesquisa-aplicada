# Santa Teresa

penha_e_ramos <- data[data$ADMINISTRATIVEREGION %in% c(3, 4, 5, 6),]

penha_e_ramos <- penha_e_ramos[!is.na(penha_e_ramos$LATITUDE) & !is.na(penha_e_ramos$LONGITUDE), ]

onibus_penha_e_ramos <- onibus_congestionados[onibus_congestionados$ADMINISTRATIVEREGION %in% c(3, 4, 5, 6),]

ggplot() +
  # Primeira camada de pontos em cinza
  geom_point(data = penha_e_ramos, aes(x = LONGITUDE, y = LATITUDE), color = "gray", alpha = 0.5) +
  
  # Segunda camada com os clusters
  geom_point(data = onibus_penha_e_ramos, aes(x = LONGITUDE, y = LATITUDE, color = as.factor(clusters)), alpha = 0.5) +
  
  # Personalização dos rótulos e títulos
  labs(
    title = "Clusters pela Penha e Ramos",
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

onibus_penha_e_ramos_summary <- onibus_penha_e_ramos %>%
  group_by(clusters) %>%
  summarise(
    Media_Lat = mean(LATITUDE, na.rm = TRUE),
    Media_Log = mean(LONGITUDE, na.rm = TRUE),
    Media_Chuva = mean(RAINFALLVOLUME, na.rm = TRUE),
    Media_Hora = mean(horas_decimal, na.rm = TRUE),
    Contagem = n()
  )

ggplot(penha_e_ramos, aes(x = LONGITUDE, y = LATITUDE)) +
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
  geom_point(data = onibus_penha_e_ramos_summary, aes(x = Media_Log, y = Media_Lat, color = as.factor(Contagem), size = Contagem), alpha = 0.5) +
  labs(color = "Indicador", size = "Indicador")
