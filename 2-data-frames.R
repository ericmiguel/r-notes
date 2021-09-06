########################################################################################
# Dataframes
########################################################################################
# Dataframes são listas de vetores

# criação de um dataframe
v1 <- data.frame(foo=6.8, bar=c(TRUE, FALSE, TRUE))

# colchete simples irá retornar um dataframe de coluna única
v1[2]

# colchete duplos irão retornar vetores com os valores da coluna
v1[["bar"]]

# seleção de linhas
# no caso: segunda linhas, todas as colunas
v1[2, ]

# seleção de colunas
# no caso: todas as linhas, segunda coluna
v1[, 2]

# também é possível passar um vetor de boleanos
v1[v1$bar, ]

# retorna um vetor com a lista de nomes do DF
names(v1)

# para renomear uma coluna, acesse o vetor de nomes do DF
names(v1)[1] <- "tmp"

# também é possível substituir o nome de todas as colunas ao informar um vetor
names(v1) <- c("coluna1", "coluna2")

# outra síntaxe possível para obter uma coluna
v1$quiz

# uma forma rápida de inserir colunas no DF é atribuir um vetor a uma coluna
# inexistente. Em R, dataframes são orientados por coluna. Para inserir linhas,
# podemos usar cbind
v1$quiz <- c("cat", "dog", "rat"); v1

# para remover uma coluna, atribua NULL
v1$bar <- NULL; v1


########################################################################################
# Datas e horários
########################################################################################


# Datas
# Datas são representadas pela classe Date
# Datas são representadas, internamente, pelo número de dias desde 01/0/1/1970.
# Uma data antes do "início dos tempos" é representada como valor negativo.
# Ou seja: R armazena as datas como timestamp, basicamente.

# R entende as datas exatamente no formato %Y-%m-%d
nascimento <- as.Date("1994-02-26")

# unclass irá retornar a representação em número de dias desde o início dos tempos
unclass(nascimento)
hoje <- Sys.Date()

# operações entre datas podem ser executadas de forma simples com operações
hoje - nascimento

# Como R representa datas em números de dias, somar um inteiro irá adicionar 7 dias.
hoje + 7

# Horários
# Os horários são representados pelas classes POSIXct e POSIXlt.
# POSIXct é, de fato, apenas um número de forma compacta, como um valor único.
# POSIXlt é, de fato, uma lista e armazena várias informações úteis como dia da semana,
# dia do ano, mês e afins

# Sys.time irá retornar uma data no padrão %Y-%m-%d %H:%M:%S TZN
instante <- Sys.time(); instante
unclass(instante)

# os horários representam o tempo em número de segundos
instante + 3600

instante_posixlt <- as.POSIXlt(instante); instante_posixlt

# o unclass irá exibir os diferentes campos do objeto de horário
unclass(instante_posixlt); names(unclass(instante_posixlt))

# para converter uma string de qualquer formato
# note que o R irá interpretar o total de segundos como zero e a timezone como
# a do sistema host (-3, no caso).
s1 <- "15/08/2015-17:10"
t1 <- strptime(s1, "%d/%m/%Y-%H:%M"); t1
# para mais detalhes sobre conversão, use ?strptime no Console


########################################################################################
# Operações vetorizadas
########################################################################################
# R tentará transformar os operandos em vetores
# 
# Operadores aritméticos
# %/% divisão inteira
# %% resto da divisão
# ** exponenciação (ou ^)
# 
# Operadores aritiméticos lazy
# || ou lógico lazy
# && e lógico lazy

# a linguagem irá somar o valor 10 em todos os elementos do vetor igual a Numpy
a <- 1: 5;
a + 10

# operações de checagem condicional com vetores podem ser realizadas tal como em Numpy
a != 3

# a operação pode ser executada com um vetor filtrado
# a > 2 irá retornar um vetor de boleanos para o índice e a operação será vetorizada
# sobre o vetor filtrado pela condição
a[a > 2] - 10

# operações com vetores serão feitas "element-wise"
# a posição de cada vetor será pareada para a operação
# v1 * v2 irá multiplicar 1 x 5, 2 x 6 e assim por diante
v1 <- c(1, 2, 3, 4)
v2 <- c(5, 6, 7, 8)
v3 <- c(2, 3, 4)

v1 * v2

# para uma operação entre vetores de tamanho distintos irá levantar um warning
# mas o broadcasting será feito "dando a volta" no vetor
# O último de v1, por exemplo, será operado com o primeiro de v3
v1 / v3


########################################################################################
# Funções pré-definidas
########################################################################################
# - funções matemáticas básicas
# - funções trigonométricas
# - funções para sequências, vetores, listas e fatores
# - funções para conjuntos
# - funções probabilísticas
# - funções estatísticas
# - funções para strings
# - funções lógicas

# Matemáticas básicas

# raiz quadrada
sqrt(1024)

# assim como todas as operações, R consegue lidar com vetores
sqrt(c(1024, 49, 225))

# exponencial (base natural)
# a constante neperiana "e" pode ser vista com exp(1)
exp(c(2, 3, 4))

# logaritmo
log(c(1, 1000, 1024)) # base e
log(1000, base=10)
# log2 e log10 são funções com bases prontas

# arredondamento para cima
ceiling(10.3)  # retornará 11

# arredondamento para baixo
floor(10.3)  # retornará 10

# truncamento (inteiro equivalente)
trunc(-2.2)  # retornará 2
trunc(-2.7)  # retornará 2

# arredondamento (com casas decimais)
# Em R, o padrão ISO é utilizado: pares são arredondados em direção ao zero
# ímpares são arredondados fugindo do zero: negativo par arredonda pra cima; positivo
# par arredonda para cima.
round(5.5, digits=3)  # por padrão, nenhuma casa decimal é usada

# arredondamento (com dígitos significativos)
signif(6.12345: 11, digits=4)

# valor absoluto
abs(-2.2:3)

# desafio da aula
# filtrar elementos inteiros de um vetor
# resposta:
x <- sample(seq(1.00, 6.75, 0.25)); x
x[x%%1==0]
# não usei nenhuma das funções de arredondamento para resolver xD


# Trigonométricas

# seno, coseno, tangente
sin(c(0, pi/4))
cos(c(0, pi/4))
tan(c(0, pi/4))

# arco (informa o valor e recebe o ângulo) coseno 
acos(c(1, 0, -1))


# Sequências, vetores e fatores (algumas já estão na aula passada)

# gera um vetor de fatores
g <- gl(3, 10, length=10)

# retorna o tamanho de um iterável
length(g)
length(g) <- 11
# é possível aumentar ou diminuir o tamanho de um vetor

# produto entre dois arrays
outer(1:10, 1:10, "*")
outer(1:10, 1:10, log)  # funções também podem ser aplicadas

# ordenação
f <- sample(seq(1.00, 6.75, 0.25))
sort(f, decreasing=TRUE)

# retorna a posição do menor elemento, segundo menor elemento e assim por diante
# o retorno, portanto, será a posição da classificação dos valores no vetor
# se um dos retornos for "9", significa que o elemento é o nono menor valor
order(f)

# retorna qual seria a posição dos valores em um vetor ordenado
rank(f)

# seria possível criar um equivalente a sort, por exemplo, usando order
f[order(f)]

# reverte a ordem dos elementos de um vetor
rev(f)

# retornar os valores únicos de um vetor
unique(f)

# retornar os valores duplicados de um vetor
duplicated(f)

# soma todos os valores de um vetor ou estrutura tabular
sum(f)

# rowSums soma das linhas de um df, matriz e etc
# colSums soma das colunas de um df, matriz e etc
m <- matrix(data=sample(60), nrow=5, ncol=6) 
rowSums(m)
colSums(m)

# produto dos elementos de um vetor
prod(f)


# Conjuntos

# Em R, conjuntos são armazenados em vetores
# conjuntos são vetores sem ordem específica
x <- c(1, 2, 3, 4, 5)
y <- c(3, 4, 5, 6, 7)

union(x, y)
intersect(x, y)
setdiff(x, y)
setdiff(y, x)
setequal(x, y)
is.element(x, y)

# desafio da aula
# encontrar valores não duplicados:
teste <- c(1, 1, 2, 3, 4, 5, 5, 4)
setdiff(teste, unique(teste[duplicated(teste)]))


# Probabilísticas

# números aleatórios, dado um intervalo, considerando uma distribuição uniforme
runif(10, min=0, max=10)

# números aleatórios em uma distribuição normal
rnorm(10, mean=0, sd=10)

# dado um vetor (ou inteiro), sorteia um número N de elementos
# se o valor for inteiro, será o intervalo de 1 a ao inteiro
sample(20:25)

# é possível especificar quantos elementos serão sorteados
sample(20:20, 2)

# Estatística
norm <- rnorm(10, mean=0, sd=1)
mean(norm)
min(norm)
max(norm)
range(norm)  # retorna o mínimo e máximo
median(norm)
quantile(norm)
var(norm)  # variância
sd(norm)  # desvio padrão
sqrt(var(norm))  # raiz da variância = sd
summary(norm)
cor(norm, norm+1)  # correlação entre dois vetores
