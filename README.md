# Cluster Analysis

## 1 - O que é?

**Cluster (Agrupamento)** refere-se a uma técnica de aprendizado não supervisionado utilizada para organizar dados em grupos baseados em similaridades. Em um cluster, os objetos dentro do mesmo grupo são mais semelhantes entre si do que com objetos de outros grupos.

Na análise de agrupamento, o objetivo é identificar e explorar padrões de similaridade entre dados, agrupando-os com base em características comuns que os tornem semelhantes dentro dos grupos e distintos entre os grupos.

## 2 - Passos Básicos para Desenvolver um Cluster

1. **Seleção dos Grupos**: Definir quais variáveis ou características serão usadas para formar os grupos.
2. **Medida de Similaridade**: Escolher o método para avaliar a semelhança entre os objetos (por exemplo, distância euclidiana, similaridade de cosseno).
3. **Critérios de Agrupamento**: Estabelecer os critérios que determinarão como os objetos serão agrupados (por exemplo, densidade, conectividade).
4. **Algoritmo de Agrupamento**: Selecionar o algoritmo apropriado para a tarefa (por exemplo, K-means, Hierárquico, DBSCAN).
5. **Validação e Interpretação dos Resultados**: Avaliar a qualidade dos clusters formados e interpretar os resultados para extrair insights.

### 2.1 - Considerações para Análises de Cluster

- **Critério de Partição**: Definir se a partição é rígida (um objeto pertence exclusivamente a um grupo) ou suave (um objeto pode pertencer a múltiplos grupos com diferentes graus de pertença).
- **Separação dos Agrupamentos**: Avaliar a exclusividade dos objetos em relação aos grupos (se um objeto é atribuído a um grupo, ele deve ser exclusivamente desse grupo).
- **Medida de Similaridade**: Escolher entre métodos baseados em distância (como a distância euclidiana) ou em conexão de dados (como a similaridade de Jaccard).

### 2.2 - Similaridade e Dissimilaridade

- **Similaridade**: É um valor numérico que avalia o quão próximos dois objetos são. Geralmente, utilizamos um valor de 0 para indicar pouca semelhança e 1 para indicar alta semelhança. O desafio está em definir precisamente o que representam os valores 0 e 1 no contexto específico.

- **Dissimilaridade**: Refere-se à distância entre as observações, medida por uma definição geral. Alguns métodos comuns para calcular a dissimilaridade incluem:
  - **Distância Euclidiana**: A medida padrão de distância entre dois pontos em um espaço euclidiano.
  - **Distância de Minkowski**: Uma generalização da distância euclidiana e da distância de Manhattan, que pode ser ajustada com um parâmetro para diferentes tipos de espaço.
  - **Distância de Cosseno**: Mede a diferença entre dois vetores com base no ângulo entre eles, frequentemente usada em análises de texto e outros dados vetoriais.

## 3 - Métodos de cluster

### 3.1 K-means