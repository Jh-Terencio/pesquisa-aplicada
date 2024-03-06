# Leitura do CSV com os dados dos vinhos
wines <- read.csv("/home/aluno/pesquisa-aplicada/prova-1-r/wine.data")

# Renomeação das colunas para melhor visualização
colnames(wines) <- c('Type', 'Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids', 'Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline')

# Cálculo da média de todos os vinhos, desconsiderando a primeira coluna dos tipos
media <- apply(wines[,-1], 2, mean)
media

# Cálculo o desvio padrão de todos os vinhos, desconsiderando a primeira coluna dos tipos
desvio_padrao <- apply(wines[,-1], 2, sd)
desvio_padrao

