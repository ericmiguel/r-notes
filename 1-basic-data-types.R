################################################################################
# Vetores
################################################################################

# a função c() cria um vetor
# vetores são formados por "elementos" ou "objetos"
# os objetos de um vetor devem ser todos do mesmo tipo
a <- c(0.5, 3.1, 0.6, 1.5); a

# para criar um vetor preenchido com um intervalo definido
b <- 1:10; b  # crescente
c <- 10:1; c  # decrescente
d <- 3.2:10; d  # decimal

# para criar sequências também é possível usar a função seq
e <- seq(from=1, to=10, by=1)

# cria uma sequência partindo de 1, avançando 2 por step
# a sequência será criada até o vetor possuir comprimento 10
f <- seq(from=1, by=2, length.out=10)

# repetir um elemento N vezes
g <- rep(x=1, times=2)

# repetir o vetor N vezes
h <- rep(x = c(1, 2, 3), times=2)

# repetir cada elemento do vetor N vezes
i <- rep(x = c(1, 2, 3), times=2, each=2)

# é possível usar a função c para concatenar valores
j <- c(a, b)

# ou adicionar valores no início ou fim do vetor
k <- c(a, 666)
l <- c(666, k)

# coerção implícita
# caso o vetor não possua o mesmo tipo de dados, a linguagem tentará converter
# com o exemplo abaixo fica bem claro que devemos evitar o comportamento
# a linguagem é bem inconsistente e ruim
m <- c(1, 2, 3, "a", 4)

# NA (Not Available) e NaN (Not a Number) são indicados para indicar valores
# desconhecidos. NA = "tentei colocar um valor e não deu"; NaN = "tentei fazer
# uma conta e não rolou".
# NA significa "explicitamente não disponível"
# NaN 
o <- c(1, 2, NaN, NA, 5)

# é possível usar as funções is.na e is.nan
is.na(o)
is.nan(o)


################################################################################
# Fatores
################################################################################

# Fatores são usados para representar categorias
# fatores são criados com a função factor
l <- factor(c("masc", "fem", "masc", "fem"))

# é possível criar categorias ordenadas
m <- factor(c("M", "G", "P", "G", "M"), levels=c("P", "M", "G"), ordered=TRUE)


################################################################################
# Matrizes
################################################################################

# Matrizes são vetores com um atributo especial dim (dimensões)
# O atributo dim é um vetor de tamanho mínimo 2
# Matrizes são criadas com a função matrix

# este exemplo irá criar uma matriz de NA
n <- matrix(nrow=2, ncol=3); dim(n); attributes(n)

# matrix preenche os valores coluna a coluna
o <- matrix(data=2, nrow=2, ncol=3)
p <- matrix(data=1:2, nrow=2, ncol=3)

# mas é possível especificar para preencher linha a linha
q <- matrix(data=1:2, nrow=2, ncol=3, byrow=TRUE)

# fornecer um vetor menor ou maior que a matriz, teremos apenas um warning.

# matrizes podem ser criadas ao unificar vetores

# rbind irá unificar os vatores horizontalmente
w <- rbind(1:4, 5:8, 3:6)

# cbind irá unificar os vetores verticalmente
x <- cbind(1:4, 5:8, 3:6)

################################################################################
# Listas
################################################################################

# Listas permitem armazenar objetos, vetores, matrizes ou outras listas
# Listas permitem, portanto, o armazenamento de objetos de natureza distinta
# Listas são criadas com a função list
z <- list("a", 2, 3, 4, FALSE, 1+2i, a)

################################################################################
# Data Frames
################################################################################

# dados tabulares
# Data frames são tipos especiais de listas onde cada um dos elementos são
# vetores, cada um representando uma coluna, todos com o mesmo número de
# subelementos. Data frames são criados com a função data.frame().
# Data frames podem ser formados a partir da leitura de arquivos externos com
# read.table() e read.csv()

a1 <- c("ca", "pi", "ro", "to", "to")
a2 <- c(663, 664, 665, 666, 666)
df1 <- data.frame(c1=a1, c2=a2)

# o parâmetro stringsAsFactor criará as colunas de strings como categoricos
df2 <- data.frame(c1=a1, c2=a2, stringsAsFactors=TRUE)

# os métodos cbind e rbind podem ser usados para acrescentar colunas ou
# linhas a um Data frame
df3 <- cbind(df1, nova=c(1, 2, 3, 4, 5))

# para manipular o nome das linhas, é possível utilizar o parâmetro
# row.names. Aqui, no caso, eu recriei o data frame
df4 <- data.frame(df3, row.names=c("a", "b", "c", "d", "e"))


################################################################################
# Nomes de objetos
################################################################################

# Objetos em R podem ser nomeados
# é possível nomear qualquer tipo de iterável

nomes <- c("eric1", "eric2", "eric3")
valores <- c(1, 2, 3)
names(valores) <- nomes; names(valores)


################################################################################
# Indexação de vetores
################################################################################

# Basicamente a mesma coisa de Python.

# Contudo, filtragens e operação são equivalentes aos arrays numpy:
a3 <- c(1:10)
a3 <- a3[a3 > 3]




