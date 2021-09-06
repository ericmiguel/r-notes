########################################################################################
# Definindo funções
########################################################################################

# Em R, a declaração "return" é opcional.
mysum <- function(a, b) {
	a + b
}

mysum  # para ver o código da função, execute o nome dela
is.function(mysum)  # para verificar se um objeto é uma função
class(mysum)  # a classe do objeto é "function" wtf

# para checar se a função recebeu um parâmetro, existe a função missing.
# Note que "return" é uma função e precisa receber o retorno como argumento
funcaoMissing <- function(a) {
	saida <- missing(a)
	return(saida)
}; funcaoMissing()

formals(mysum)  # obtém os argumentos formais (nomeados) de uma função
formals(matrix)  # naturalmente, também funciona para os nativos

# Funções aninhadas podem ser utilizadas
makePower <- function(n) {
	return(function(x) {x^n})
}

square <- makePower(2)
cube <- makePower(3)

# Argumentos também podem ter valores padrões. São utilizados caso
# outros valores não sejam passados para os mesmos.
subvector <- function(vector, begin = 1, end = length(vector)) {
	return(vector[begin:end])
}

# função para calcular a distância euclidiana entre dois pontos
mydist <- function(x = c(0, 0), y = c(0, 0)) {
	sqrt((x[1] - y[1])^2 + (x[2] - y[2])^2)
}; mydist(x = c(4, 3))

# trunca valores
truncd <- function(n, digits = 0) {
	trunc(n * 10^digits) / 10^digits
}; truncd(123.456, digits=2)

# R também tem um "args" para funções com a declaração de elípse
# Argumentos declarados após elípses precisam ser, obrigatóriamente, nomeados
ell <- function(..., b="último arg"){
	return(c(..., b))
}; ell(1, 2, 3)

# O escopo da linguagem é bem padrão: variáveis recebidas por funções só existem
# em escopo global. Nomes de variáveis, funções e outras são buscados pela linguagem
# na seguinte ordem:
search()

# Note que a base da linguagem é o último local a ser consultado. Dessa forma, 
# podemos substituir as funções do namespace. Exemplo: 
length <- rev
length(c(4:9))
# Para usar a função length base que foi substituída
base::length(c(4:9))

########################################################################################
# Condicionais
########################################################################################

odd <- function(x) {
	if (x %% 2 == 1) {
		TRUE
	} else {
		FALSE
	}
}

# expressões lógicas são avaliadas e retornam um bool
odd <- function(x) {
	x %% 2 == 1
}

# condicionais simples podem ser declarados horizontalmente
mymin <- function(a, b) {
	if (a < b) return(a)
	else return(b)
}

# a linguagem possui um shothand para if/else
# ifelse(teste, retorno caso verdadeiro, retorno caso falso)
mymin <- function(a, b) {
	ifelse(a < b, a, b)
}

# o uso de chaves ({}) para delimitar os blocos é opcional.
# Mas é recomendado em caso de condicionais aninhados
myabs <- function(a) {
	if (a < 0)
		return(-a)
	else
		return(a)
}

bhaskara <- function(a = 0, b = 0, c = 0) {
	if (a != 0) {
		delta <- as.complex(b^2 - 4*a*c)
		if (delta != 0) {
			return(c((-b + sqrt(delta)) / (2 * a), 
					 (-b - sqrt(delta)) / (2 * a)))
		} else {
			return(-b / (2 * a))
		}
	} else {
		return(-c / b)
	}
}

########################################################################################
# Repetição
########################################################################################

printVector <- function(v) {
	i <- 1
	while (i <= length(v)) {
		print(v[i])
		i <- i + 1
	}
}

printVector <- function(v) {
	for (i in v) {
		print(i)
	}
}

mysum <-function(...) {
	x <- 0
	for (i in c(...)) {
		x <- x + i
	}
	return(x)
}

mylength <- function(vector) {
	k <- 0
	for (i in vector) {
		k <- k + 1
	}
	return(k)
}

mylength <- function(...) {
	k <- 0
	for (i in c(...)) {
		k <- k + 1
	}
	return(k)
}; mylength(1, 2, 3)

multlength <- function(...) {
	result <- NULL
	for (i in list(...)) {
		result <- c(result, length(i))
	}
	return(result)
}

multlength(25:30, matrix(1:12, 3, 4), 
		   rnorm(5), sample(10))

# retorna o menor valor de um conjunto de argumentos
mymin <- function(...) {
	min <- Inf
	for (i in c(...)) {
		if (i < min) {
			min <- i
		}
	}
	return(min)
}

mymin <- function(...) {
	min <- Inf
	if (missing(...)) {
		warning("missing arguments; returning Inf")
	} else {
		for (i in c(...)) {
			if (i < min) {
				min <- i
			}
		}
	}
	return(min)
}

subset <- function(set1, set2) {
	all(is.element(set1, set2))
}

subset <- function(set1, set2) {
	for (elem in set1) {
		if (!is.element(elem, set2)) {
			return(FALSE)
		}
	}
	return(TRUE)
}

index <- function(vector, element) {
	n <- length(vector)
	result <- NULL
	for (i in 1:n) {
		if (vector[i] == element) {
			result <- c(result, i)
		}
	}
	return(result)
}

index <- function(vector, element) {
	(1:length(vector))[vector == element] 
}

gcd2 <- function(x, y) {
	if (y == 0) {
		return(x)
	} else {
		return(gcd2(y, x %% y))
	}
}

gcd2(21, 15)

gcd2 <- Vectorize(gcd2)

gcd2(15:20, 21:26)

########################################################################################
# lapply
########################################################################################
# lapply aplica uma função F a cada elemento passado à função.
# Loops for e while são tipicamente mais rápidos que lapply,
# porém muito mais verbosos.

L <- list(a = 25:30, 
		  b = matrix(1:12, 3, 4), 
		  c = rnorm(100), 
		  d = sample(10))
lapply(L, mean)

# equivale à função multilenght implementada mais acima no código
lapply(L, length)

lapply(2:4, runif)
# os argumentos da função mapeada podem ser passado à função lapply
lapply(2:4, runif, min = 0, max = 10)

# dataframes sofrem as alterações coluna a coluna
lapply(datasets::faithful, max)

# também é possível passar funções anônimas
lapply(datasets::faithful, function(x) {
	max(x) - min(x)
})

########################################################################################
# sapply
########################################################################################
# o sapply é similar ao lapply, mas o resultado será simplificado (se possível).
# Se o resultado for uma lista, onde cada elemento possui 1, então um vetor único
# é retornado. Se o resultado for uma lista, onde cada elemento possui o mesmo
# tamanho (>1), então uma matriz é retornada. Se não for possível simplificar o
# resultado usando uma das duas regras acima, então uma lista é retornada.

# lapply retornaria 4 vetores com um valor cada, enquanto sapply retorna um vetor
# unidimensional com 4 elementos.
sapply(L, mean)

sapply(L, range)

lapply(faithful, range)

lapply(faithful, quantile)

sapply(faithful, quantile)

sapply(faithful, quantile, c(0, 1/3, 2/3, 1))

sapply(faithful, quantile, seq(0, 1, 0.1))

########################################################################################
# apply
########################################################################################
# Aplica funções a estruturas tabulares.
# Se dimensão = 1, a função é aplicada para todas as linhas
# Se dimensão = 2, a função é aplicada para todas as colunas 

m <- matrix(sample(12), nrow = 3, ncol = 4); m

apply(m, 1, min)

apply(m, 2, max)

m <- matrix(sample(8))
dim(m) <- c(2, 2, 2); m

apply(m, 1, mean)

apply(m[ , , 1], 1, mean)

apply(m, 2, mean)

apply(m[ , , 2], 2, mean)

total <- sum(datasets::HairEyeColor); total

apply(HairEyeColor, 1, sum) / total
apply(HairEyeColor, 2, sum) / total
apply(HairEyeColor, 3, sum) / total

########################################################################################
# mapply
########################################################################################
# mapply é uma versão multivariada de sapply
# a função é aplicada a todos os primeiros elementos, todos os segundos elementos
# e assim por diante.

mapply(rep, 1:3, 5:3)
mapply(log, 2:5, 2:3)

tipo1 <- sample(10:99, 10); tipo1
tipo2 <- sample(10:99, 10); tipo2
tipo3 <- sample(10:99, 10); tipo3
tipo4 <- sample(10:99, 10); tipo4

mapply(min, tipo1, tipo2, tipo3, tipo4)
mapply(max, tipo1, tipo2, tipo3, tipo4)
mapply(function (...) {mean(c(...))}, 
	   tipo1, tipo2, tipo3, tipo4)

(tipo1 <- tipo1 >= 50)
(tipo2 <- tipo2 >= 50)
(tipo3 <- tipo3 >= 50)
(tipo4 <- tipo4 >= 50)

mapply(all, tipo1, tipo2, tipo3, tipo4)
mapply(any, tipo1, tipo2, tipo3, tipo4)

########################################################################################
# tapply
########################################################################################
# tapply recebe um vetor, um de fatores e uma função: a função é aplicada a cada 
# subconjunto do vetor de valores agregado pelos fatores. 
# É o mesmo princípio de uma "groupby" ou "bin".

x <- c(rnorm(100), runif(100), sample(100))
f <- gl(n = 3, k = 100, 
		labels = c("norm", "unif", "sample"))

df <- data.frame(x, f)
tapply(df$x, df$f, range)

df <- df[sample(nrow(df)), ]
tapply(df$x, df$f, range)
tapply(df$x, df$f, mean)

tapply(datasets::mtcars$mpg,
	   datasets::mtcars$cyl, mean)
tapply(mtcars$qsec, mtcars$cyl, mean)
tapply(mtcars$hp, mtcars$vs, mean)

tapply(row.names(mtcars), mtcars$gear, c)
tapply(mtcars$hp, mtcars$gear, c)
tapply(mtcars$hp, mtcars$gear, length)

qfactor <- function(vector) {
	q <- quantile(vector)
	result <- NULL
	for (i in vector)
		if (i <= q["25%"])
			result <- c(result, "q1")
	else if (i <= q["50%"])
		result <- c(result, "q2")
	else if (i <= q["75%"])
		result <- c(result, "q3")
	else result <- c(result, "q4")
	return(as.factor(result))
}

tapply(mtcars$mpg, qfactor(mtcars$hp), mean)
tapply(mtcars$mpg, qfactor(mtcars$qsec), max)
tapply(mtcars$hp, qfactor(mtcars$mpg), mean)

tapply(datasets::Loblolly$height,
	   datasets::Loblolly$age, min)
tapply(Loblolly$height, Loblolly$age, mean)
tapply(Loblolly$height, Loblolly$age, max)

tapply(datasets::airquality$Temp,
	   datasets::airquality$Month, mean)
tapply(airquality$Solar.R, airquality$Month, 
	   mean, na.rm = TRUE)
tapply(airquality$Ozone, airquality$Month, 
	   mean, na.rm = TRUE)
tapply(airquality$Temp, airquality$Wind > 10,
	   mean)
tapply(airquality$Temp, 
	   ifelse(airquality$Wind > 10, 
	   	   "Windy", "Not Windy"), mean)

tapply(datasets::iris$Petal.Length,
	   datasets::iris$Species, mean)
tapply(iris$Petal.Width, iris$Species, mean)
tapply(iris$Petal.Length / iris$Petal.Width, 
	   iris$Species, mean)

tapply(iris$Petal.Length, iris$Species, summary)
simplify2array(tapply(iris$Petal.Length, 
					  iris$Species, summary))

tapply(esoph$ncases, esoph$agegp, sum)
tapply(esoph$ncontrols, esoph$agegp, sum)
tapply(esoph$ncases, esoph$agegp, sum) / tapply(esoph$ncontrols, esoph$agegp, sum)
tapply(esoph$ncases, esoph$alcgp, sum) / tapply(esoph$ncontrols, esoph$alcgp, sum)
tapply(esoph$ncases, esoph$tobgp, sum) / tapply(esoph$ncontrols, esoph$tobgp, sum)