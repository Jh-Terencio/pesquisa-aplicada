install.packages("dplyr")

# Carregar o pacote dplyr
library(dplyr)

# Leitura do CSV com os dados dos vinhos
wines <- read.csv("/home/aluno/pesquisa-aplicada/prova-1-r/wine.data")

# Renomeação das colunas para melhor visualização
colnames(wines) <- c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline')

resultados <- wines %>%
  group_by(Type) %>%
  summarise(
    media_Alcohol = mean(Alcohol),
    desvio_padrao_Alcohol = sd(Alcohol),
    media_Malic = mean(Malic),
    desvio_padrao_Malic = sd(Malic),
    media_Ash = mean(Ash),
    desvio_padrao_Ash = sd(Ash),
    media_Alcalinity = mean(Alcalinity),
    desvio_padrao_Alcalinity = sd(Alcalinity),
    media_Magnesium = mean(Magnesium),
    desvio_padrao_Magnesium = sd(Magnesium),
    media_Phenols = mean(Phenols),
    desvio_padrao_Phenols = sd(Phenols),
    media_Flavanoids = mean(Flavanoids),
    desvio_padrao_Flavanoids = sd(Flavanoids),
    media_Nonflavanoids = mean(Nonflavanoids),
    desvio_padrao_Nonflavanoids = sd(Nonflavanoids),
    media_Proanthocyanins = mean(Proanthocyanins),
    desvio_padrao_Proanthocyanins = sd(Proanthocyanins),
    media_Color = mean(Color),
    desvio_padrao_Color = sd(Color),
    media_Hue = mean(Hue),
    desvio_padrao_Hue = sd(Hue),
    media_Dilution = mean(Dilution),
    desvio_padrao_Dilution = sd(Dilution),
    media_Proline = mean(Proline),
    desvio_padrao_Proline = sd(Proline)
  )

# Exibir os resultados
print(resultados)

