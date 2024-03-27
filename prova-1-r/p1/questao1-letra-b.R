wines <- read.table('http://www.archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data', sep = ',',col.names = c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline'))

media_por_vinho <- wines %>%
  group_by(Type) %>%
  summarise(across(.cols = everything(), .fns = mean))

media_por_vinho_transposta <- t(media_por_vinho[-1])
colnames(media_por_vinho_transposta) <- media_por_vinho$Type
media_por_vinho_transposta <- as.data.frame(media_por_vinho_transposta)

desvio_padrao_por_vinho <- wines %>%
  group_by(Type) %>%
  summarise(across(.cols = everything(), .fns = sd))

desvio_padrao_por_vinho_transposta <- t(desvio_padrao_por_vinho[-1])
colnames(desvio_padrao_por_vinho_transposta) <- desvio_padrao_por_vinho$Type
desvio_padrao_por_vinho_transposta <- as.data.frame(desvio_padrao_por_vinho_transposta)

print("Média por tipo de vinho:")
media_por_vinho_transposta

print("Desvio padrão por tipo de vinho:")
desvio_padrao_por_vinho_transposta