#install.packages("ggplot2")

]# Carregar pacotes
library(ggplot2)
library(dplyr)

# Ler o arquivo CSV
vinhos <- read.csv("/home/aluno/pesquisa-aplicada/prova-1-r/wine.data")
colnames(vinhos) <- c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline')

head(vinhos)
# Melt dos dados para o formato longo
vinhos_melted <- vinhos %>%
  select(-Type) %>%
  gather(key = "Atributo", value = "Valor")

# Criar os gráficos de distribuição de densidade
ggplot(vinhos_melted, aes(x = Valor, fill = factor(Type))) +
  geom_density(alpha = 0.7) +
  facet_wrap(~Atributo, scales = "free") +
  labs(x = "Valor", y = "Densidade") +
  theme_minimal()
