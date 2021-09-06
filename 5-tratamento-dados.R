########################################################################################
# Leitura e Escrita
########################################################################################
library(help = "datasets")

getwd()  # retorna o diretório atual
# setwd("/home/user/data/")

write.table(Titanic, "teste.txt")
x <- read.table("teste.txt")
head(x)  # retorna as 6 primeiras linhas
tail(x)  # retorna as 6 últimas linhas  
rm(x)  # remove a variável X da memória

# A função "file" é um "gerenciador" de contexto em R. Ele cria uma conexão duradoura
# com algum arquivo ou fonte. É necessário fechar a conexão após executar as
# funções de interesse.
con <- file("teste.csv", "w")
write.csv(airquality, con)
close(con)

con <- bzfile("teste.bz2", "w")
write.csv(airquality, con)
close(con)

con <- bzfile("teste.bz2", "r")
x <- read.csv(con)
close(con)

names <- c("horario", "temp", "vento", "umid", "sensa")
con <- url("http://ic.unicamp.br/~zanoni/cepagri/sample.csv")
cepagri <- read.csv(con, header = FALSE, sep = ";", col.names = names)
head(cepagri)
rm(cepagri)

########################################################################################
# Tratamento de dados
########################################################################################

# esse comando de leitura retornará um erro, pois os dados estão com falhas
con <- url("https://ic.unicamp.br/~zanoni/cepagri/cepagri.csv")
cepagri <- read.table(con, header = FALSE, sep = ";")

# adicionar fill TRUE permite a leitura
names <- c("horario", "temp", "vento", "umid", "sensa")
con <- url("https://ic.unicamp.br/~zanoni/cepagri/cepagri.csv")
cepagri <- read.table(con,
  header = FALSE,
  fill = TRUE,
  sep = ";",
  col.names = names
); cepagri[26490:26492, ]

tail(cepagri)

l1 <- nrow(cepagri); l1
# filtra o que não é NA
cepagri <- cepagri[!is.na(cepagri$sensa), ]
l2 <- nrow(cepagri); l2

l1 - l2
(l1 - l2) / l1

# checa o tipo de valor de cada coluna
sapply(cepagri, class)

class(cepagri$temp)
# converte a coluna temp para numérico
cepagri$temp <- as.numeric(cepagri$temp)
class(cepagri$temp)
summary(cepagri$temp)

class(cepagri$horario)
# converte a coluna horario para objeto de tempo
cepagri$horario <- as.POSIXct(cepagri$horario,
  format = "%d/%m/%Y-%H:%M",
  tz = "America/Sao_Paulo"
)
class(cepagri$horario)

# sumário de estatísticas descritivas da coluna sensa (sensação térmica)
summary(cepagri$sensa)

# A sensação térmica varia em função da temperatura, umidade e vento
# Dessa forma, valores menores que zero (em Campinas) são, certamente, errados.
# Da mesma maneira, um valor de 99.9 costuma ser uma flag de erro.
cepagri[cepagri$sensa < 0, ]
cepagri[cepagri$sensa == 99.9, ]
cepagri[cepagri$sensa == min(cepagri$sensa), ]
cepagri[cepagri$sensa == max(cepagri$sensa), ]
cepagri[cepagri$sensa == 99.9, 5] <- NA
summary(cepagri$sensa)

# Checar valores repetidos em sequência também é uma investigação importante.
# Estamos aqui lidando com medições de sensores. O sensor pode apresentar falhas,
# por exemplo, e repetir o mesmo valor por N tempo até que ele seja reparado.
consecutive <- function(vector, k = 1) {
  n <- length(vector)
  result <- logical(n)
  if (n < k + 1) {
    return(result)
  }
  for (i in (1 + k):n) {
    if (all(vector[(i - k):(i - 1)] == vector[i])) {
      result[i] <- TRUE
    }
  }
  return(result)
}

consecutive(rep(1, 10), 3)

consecutive <- function(vector, k = 1) {
  n <- length(vector)
  result <- logical(n)
  if (n < k + 1) {
    return(result)
  }
  for (i in (1 + k):n) {
    if (all(vector[(i - k):(i - 1)] == vector[i])) {
      result[i] <- TRUE
    }
  }
  for (i in 1:(n - k)) {
    if (all(vector[(i + 1):(i + k)] == vector[i])) {
      result[i] <- TRUE
    }
  }
  return(result)
}

consecutive(rep(1, 10), 3)
consecutive(rep(1, 10), 9)

consecutive <- function(vector, k = 2) {
  n <- length(vector)
  result <- logical(n)
  for (i in k:n) {
    if (all(vector[(i - k + 1):i] == vector[i])) {
      result[(i - k + 1):i] <- TRUE
    }
  }
  return(result)
}

consecutive(rep(1, 10), 10)

sum(consecutive(cepagri$temp))
sum(consecutive(cepagri$temp, 3))
sum(consecutive(cepagri$temp, 4))
sum(consecutive(cepagri$temp, 5))
sum(consecutive(cepagri$temp, 6))

sum(consecutive(cepagri$temp) &
  consecutive(cepagri$vento) &
  consecutive(cepagri$umid))

sum(consecutive(cepagri$temp, 6) &
  consecutive(cepagri$vento, 6) &
  consecutive(cepagri$umid, 6))

any(consecutive(cepagri$temp, 144)) # 01 dia
any(consecutive(cepagri$temp, 288)) # 02 dias
any(consecutive(cepagri$temp, 720)) # 05 dias
any(consecutive(cepagri$temp, 1440)) # 10 dias
any(consecutive(cepagri$temp, 2160)) # 15 dias
any(consecutive(cepagri$temp, 1584)) # 11 dias

filtro <- consecutive(cepagri$temp, 144)
unique(as.Date(cepagri[filtro, 1]))

# Exemplo de Analise de Dados

names <- c("horario", "temp", "vento", "umid", "sensa")
con <- url("https://ic.unicamp.br/~zanoni/cepagri/cepagri.csv")
cepagri <- read.table(con,
  header = FALSE,
  fill = TRUE, sep = ";",
  col.names = names
)
cepagri$horario <- as.POSIXct(cepagri$horario,
  format = "%d/%m/%Y-%H:%M",
  tz = "America/Sao_Paulo"
)
cepagri$OK <- !is.na(cepagri$sensa)

cepagri$horario <- as.POSIXlt(cepagri$horario)
cepagri$ano <- unclass(cepagri$horario)$year + 1900
cepagri$mes <- unclass(cepagri$horario)$mon + 1

tapply(cepagri$OK, cepagri$ano, mean)

tapply(cepagri$OK, list(cepagri$ano, cepagri$mes), mean)

cepagri <- cepagri[cepagri$OK, ]
cepagri$OK <- NULL
cepagri$temp <- as.numeric(cepagri$temp)

tapply(cepagri$temp, cepagri$ano, mean)
tapply(cepagri$temp, cepagri$mes, mean)
tapply(cepagri$umid, cepagri$mes, mean)

cepagri2017 <- cepagri[cepagri$ano == 2017, ]
cepagri2018 <- cepagri[cepagri$ano == 2018, ]

tapply(cepagri2017$temp, cepagri2017$mes, function(x) {
  mean(consecutive(x, 6))
})
tapply(cepagri2018$temp, cepagri2018$mes, function(x) {
  mean(consecutive(x, 6))
})

tapply(cepagri2017$temp, cepagri2017$mes, function(x) {
  length(unique(x))
})
tapply(cepagri2018$temp, cepagri2018$mes, function(x) {
  length(unique(x))
})

library(ggplot2)

cepagri2017$mes <- as.factor(cepagri2017$mes)
cepagri2018$mes <- as.factor(cepagri2018$mes)

ggplot(cepagri2017, aes(x = mes, y = temp, group = mes)) +
  geom_boxplot()
ggplot(cepagri2017, aes(x = mes, y = temp, group = mes)) +
  geom_violin()

ggplot(cepagri2018, aes(x = mes, y = temp, group = mes)) +
  geom_boxplot()
ggplot(cepagri2018, aes(x = mes, y = temp, group = mes)) +
  geom_violin()

ggplot(cepagri2017, aes(x = mes, y = temp)) +
  geom_point(alpha = 0.01)
ggplot(cepagri2018, aes(x = mes, y = temp)) +
  geom_point(alpha = 0.01)
