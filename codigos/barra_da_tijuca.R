# Barra da Tijuca

barra_da_tijuca <- data[data$ADMINISTRATIVEREGION == 24,]

barra_da_tijuca <- barra_da_tijuca[!is.na(barra_da_tijuca$LATITUDE) & !is.na(barra_da_tijuca$LONGITUDE), ]

onibus_barra_da_tijuca <- onibus_congestionados[onibus_congestionados$ADMINISTRATIVEREGION == 24,]

ggplot() +
  # Primeira camada de pontos em cinza
  geom_point(data = barra_da_tijuca, aes(x = LONGITUDE, y = LATITUDE), color = "gray", alpha = 0.5) +
  
  # Segunda camada com os clusters
  geom_point(data = onibus_barra_da_tijuca, aes(x = LONGITUDE, y = LATITUDE, color = as.factor(clusters)), alpha = 0.5) +
  
  # Personalização dos rótulos e títulos
  labs(
    title = "Clusters pela barra_da_tijuca",
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

# Pegando a Rua Riachuelo como exemplo, sendo a velocidade máxima dela 50km/h. Num horário de 17hrs de um dia útil um trajeto de 1.4km demora entre 4 a 12 minutos. O que deveria ser no máximo 1 minuto e 40 segundos

onibus_barra_da_tijuca_summary <- onibus_barra_da_tijuca %>%
  group_by(clusters) %>%
  summarise(
    Media_Lat = mean(LATITUDE, na.rm = TRUE),
    Media_Log = mean(LONGITUDE, na.rm = TRUE),
    Media_Chuva = mean(RAINFALLVOLUME, na.rm = TRUE),
    Media_Hora = mean(horas_decimal, na.rm = TRUE),
    Contagem = n()
  )

ggplot(barra_da_tijuca, aes(x = LONGITUDE, y = LATITUDE)) +
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
  geom_point(data = onibus_barra_da_tijuca_summary, aes(x = Media_Log, y = Media_Lat, color = as.factor(Contagem), size = Contagem), alpha = 0.5) +
  labs(color = "Indicador", size = "Indicador")
