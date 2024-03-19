# Leitura do CSV com os dados dos vinhos
wines <- read.table('http://www.archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data',sep = ',', col.names = c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline'))

# Cálculo da média de todos os vinhos, desconsiderando a primeira coluna dos tipos
media <- apply(wines[,-1], 2, mean)
media

# Cálculo o desvio padrão de todos os vinhos, desconsiderando a primeira coluna dos tipos
desvio_padrao <- apply(wines[,-1], 2, sd)
desvio_padrao