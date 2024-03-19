install.packages("dplyr")

# Carregar o pacote dplyr
library(dplyr)

# Leitura do CSV com os dados dos vinhos
wines <- read.table('http://www.archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data',sep = ',', col.names = c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline'))

media_por_vinho = wines %>%
  group_by(Type) %>%
  summarise(across(.cols = everything(), .fns = mean))
media_por_vinho

desvio_padrao_por_vinho = wines %>%
  group_by(Type) %>%
  summarise(across(.cols = everything(), .fns = sd))
desvio_padrao_por_vinho