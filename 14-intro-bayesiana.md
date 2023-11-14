# Introducción a inferencia bayesiana



Para esta sección seguiremos principalmente @Kruschke. Adicionalmente
puedes ver la sección correspondiente de @Chihara.

En las secciones anteriores estudiamos el método de máxima verosimilitud y
métodos de remuestreo. Esto lo hemos hecho para estimar parámetros, y
cuantificar la incertidumbre qué tenemos acerca de valores poblacionales. La
inferencia bayesiana tiene objetivos similares.

- Igual que en máxima verosimilitud, la inferencia bayesiana comienza con
modelos probabilísticos y observaciones.
- En contraste con máxima verosimilitud, la inferencia bayesiana está diseñada
para incorporar información previa o de expertos que tengamos acerca de los
parámetros de interés.
- La inferencia bayesiana cubre como caso particular métodos basados en máxima
verosimilitud.

El concepto probabilístico básico que utilizamos para construir estos modelos y
la inferencia es el de probabilidad condicional: la probabilidad de que ocurran
ciertos eventos dada la información disponible del fenómeno que nos interesa.

## Un primer ejemplo completo de inferencia bayesiana {-}

Consideremos el siguiente problema: Nos dan una moneda, y solo sabemos
que la moneda puede tener probabilidad $3/5$ de tirar sol (está cargada a sol)
o puede ser una moneda cargada a águila, con probabilidad $2/5$ de tirar sol.

Vamos a lanzar la moneda dos veces y observamos su resultado (águila o sol).
Queremos decir algo acerca de qué tan probable es que hayamos tirado la moneda
cargada a sol o la moneda cargada a águila.

En este caso, tenemos dos variables: $X$, que cuenta el número
de soles obtenidos en el experimento aleatorio, y $\theta$, que da la probabilidad
de que un volado resulte en sol (por ejemplo, si la moneda es justa
entonces $\theta = 0.5$).

¿Qué cantidades podríamos usar para evaluar
qué moneda es la que estamos usando? Si hacemos el experimento,
y tiramos la moneda 2 veces, podríamos considerar la probabilidad
$$P(\theta = 0.4 | X = x)$$
donde $x$ es el número de soles que obtuvimos en el experimento. Esta es la probabilidad
condicional de que estemos tirando la moneda con probabilidad de sol 2/5 dado
que observamos $x$ soles. Por ejemplo, si tiramos 2 soles, deberíamos calcular
$$P(\theta=0.4|X=2).$$

¿Cómo calculamos esta probabilidad? ¿Qué sentido tiene?

Usando reglas de probabildad (regla de Bayes en particular), podríamos calcular
$$P(\theta=0.4|X=2) = \frac{P(X=2 | \theta = 0.4) P(\theta =0.4)}{P(X=2)}$$

Nota que en el numerador uno de los factores, $P(X=2 | \theta = 0.4),$ es la
verosimilitud. Así que primero necesitamos la verosimilitud:
$$P(X=2|\theta = 0.4) = (0.4)^2 = 0.16.$$

La novedad es que ahora tenemos que considerar la probabilidad $P(\theta =
0.4)$. Esta cantidad no la habíamos encontrado antes. Tenemos que pensar
entonces que este parámetro es una *cantidad aleatoria*, y puede tomar dos
valores $\theta=0.4$ ó $\theta = 0.6$.

Considerar esta cantidad como aleatoria requiere pensar, en este caso, en cómo
se escogió la moneda, o qué sabemos acerca de las monedas que se usan para este
experimento. Supongamos que en este caso, nos dicen que la moneda se escoge al
azar de una bolsa donde hay una proporción similar de los dos tipos de moneda
(0.4 ó 0.6). Es decir el espacio parametral es $\Theta = \{0.4, 0.6\},$  y las
probabilidades asociadas a cada posibilidad son las mismas. Es decir, tenemos
$$P(\theta = 0.4) = P(\theta = 0.6) =0.5,$$
que representa la probabilidad de escoger de manera aleatoria la moneda con
una carga en particular.

Ahora queremos calcular $P(X=2)$, pero con el trabajo que hicimos esto es fácil.
Pues requiere usar reglas de probabilidad usuales para hacerlo. Podemos utilizar
probabilidad total
\begin{align}
P(X) &= \sum_{\theta \in \Theta} P(X, \theta)\\
&= \sum_{\theta \in \Theta} P(X\, |\, \theta) P(\theta),
\end{align}
lo cual en nuestro ejemplo se traduce en escribir

$$ P(X=2) = P(X=2|\theta = 0.4)P(\theta = 0.4) + P(X=2|\theta=0.6)P(\theta =0.6),$$
por lo que obtenemos
$$P(X=2) = 0.16(0.5) + 0.36(0.5) = 0.26.$$

Finalmente la probabilidad de haber escogido la moneda con carga $2/5$ dado que
observamos dos soles en el lanzamiento es

$$P(\theta=0.4|X=2) = \frac{0.16(0.5)}{0.26} \approx  0.31.$$

Es decir, la **probabilidad posterior** de que estemos tirando la moneda $2/5$
baja de 0.5 (nuestra información inicial) a 0.31.

Este es un ejemplo completo, aunque muy simple, de inferencia bayesiana. La
estrategia de **inferencia bayesiana implica tomar decisiones basadas en las
probabilidades posteriores.**

<div class="ejercicio">
<p>¿Cuál sería la estimación de máxima verosimilitud para este problema?
¿Cómo cuantificaríamos la incertidumbre en la estimación de máxima
verosimilitud?</p>
</div>

Finalmente, podríamos hacer predicciones usando la **posterior predictiva**.
Si ${X}_{nv}$ es una nueva tirada adicional de la moneda que estamos usando, nos
interesaría saber:
$$P({X}_{nv}=\mathsf{sol}\, | \, X=2)$$
Notemos que un volado adicional es un resultado binario. Por lo que podemos
calcular observando que $P({X}_{nv}|X=2, \theta)$ es una variable Bernoulli con
probabilidad $\theta$, que puede valer 0.4 ó 0.6. Como tenemos las
probabilidades posteriores $P(\theta|X=2)$ podemos usar probabilidad total,
condicionado en $X=2$:
\begin{align*}
P({X}_{nv}=\mathsf{sol}\, | \, X=2) & = \sum_{\theta \in \Theta} P({X}_{nv}=\mathsf{sol}, \theta \, | \, X=2) & \text{(probabilidad total)}\\
&= \sum_{\theta \in \Theta} P({X}_{nv}=\mathsf{sol}\, | \theta , X=2) P(\theta \, | \, X=2) & \text{(probabilidad condicional)}\\
&= \sum_{\theta \in \Theta} P({X}_{nv}=\mathsf{sol}\, | \theta ) P(\theta \, | \, X=2), & \text{(independencia condicional)}
\end{align*}

lo que nos da el siguiente cálculo
$$P(X_{nv}=\mathsf{sol}\, |\, \theta=0.4) \,  P(\theta=0.4|X=2) \,  +\, P(X_{nv}=\mathsf{sol}|\theta = 0.6) \, P(\theta =0.6|X=2)$$
Es decir, promediamos ponderando con las probabilidades posteriores.
Por lo tanto obtenemos
$$P(X_{nv} = \mathsf{sol}|X=2) =  0.4 ( 0.31) + 0.6 (0.69) = 0.538.$$

#### Observación 0 {-}

Nótese que en contraste con máxima verosimilitud, en este ejemplo *cuantificamos
con probabilidad condicional la incertidumbre de los parámetros que no
conocemos*. En máxima verosimilitud esta probabilidad no tiene mucho sentido,
pues nunca consideramos el parámetro desconocido como una cantidad aleatoria.

#### Observación 1 {-}

Nótese el factor $P(X=2)$ en la probabilidad posterior puede entenderse como un
factor de normalización. Notemos que los denominadores en la distribución
posterior son
$$P(X=2 | \theta = 0.4) P(\theta =0.4) = 0.16(0.5) = 0.08,$$
y
$$P(X=2 | \theta = 0.6) P(\theta =0.6) = 0.36(0.5) = 0.18.$$
Las probabilidades posteriores son proporcionales a estas dos cantidades,
y como deben sumar uno, entonces normalizando estos dos números (dividiendo
entre su suma) obtenemos las probabilidades.

#### Observación 2 {-}

La nomenclatura que usamos es la siguiente:

- Como $X$ son los datos observados, llamamos a $P(X|\theta)$ la *verosimilitud*,
o modelo de los datos.
- A $P(\theta)$ le llamamos la distribución *inicial* o *previa*.
- La distribución que usamos para hacer inferencia $P(\theta|X)$ es la
distribución *final* o *posterior.*

Para utilizar inferencia bayesiana, hay que hacer supuestos para definir las
primeras dos partes del modelo. La parte de iniciales o previas está ausente de
enfoques como máxima verosimlitud usual.

#### Observación 3 {-}

¿Cómo decidimos las probabilidades iniciales, por ejemplo $P(\theta=0.4)$ ?

Quizá es un supuesto y no tenemos razón para pensar que se hace de otra manera.
O quizá conocemos el mecanismo concreto con el que se selecciona la moneda.
Discutiremos esto más adelante.

#### Observación 4 {-}

¿Cómo decidimos el modelo de los datos? Aquí típicamente también tenemos que
hacer algunos supuestos, aunque algunos de estos pueden estar basados en el
diseño del estudio, por ejemplo. Igual que cuando usamos máxima verosimilitud,
es necesario checar que nuestro modelo ajusta razonablemente a los datos.

#### Ejercicio {-}

Cambia distintos parámetros del número de soles observados, las probabilidades
de sol de las monedas, y las probabilidades iniciales de selección de las
monedas.


```r
n_volados <- 2
# posible valores del parámetro desconocido
theta = c(0.4, 0.6)
# probabilidades iniciales
probs_inicial <- tibble(moneda = c(1, 2),
                        theta = theta,
                        prob_inicial = c(0.5, 0.5))
probs_inicial
```

```
## # A tibble: 2 × 3
##   moneda theta prob_inicial
##    <dbl> <dbl>        <dbl>
## 1      1   0.4          0.5
## 2      2   0.6          0.5
```

```r
# verosimilitud
crear_verosim <- function(no_soles){
    verosim <- function(theta){
      # prob de observar no_soles en 2 volados con probabilidad de sol theta
      dbinom(no_soles, n_volados, theta)
    }
    verosim
}
# evaluar verosimilitud
verosim <- crear_verosim(2)
# ahora usamos regla de bayes para hacer tabla de probabilidades
tabla_inferencia <- probs_inicial %>%
  mutate(verosimilitud = map_dbl(theta, verosim)) %>%
  mutate(inicial_x_verosim = prob_inicial * verosimilitud) %>%
  # normalizar
  mutate(prob_posterior = inicial_x_verosim / sum(inicial_x_verosim))

tabla_inferencia %>%
  mutate(moneda_obs = moneda) %>%
  select(moneda_obs, theta, prob_inicial, verosimilitud, prob_posterior)
```

```
## # A tibble: 2 × 5
##   moneda_obs theta prob_inicial verosimilitud prob_posterior
##        <dbl> <dbl>        <dbl>         <dbl>          <dbl>
## 1          1   0.4          0.5          0.16          0.308
## 2          2   0.6          0.5          0.36          0.692
```

<div class="ejercicio">
<ul>
<li>¿Qué pasa cuando el número de soles es 0? ¿Cómo cambian las
probabilidades posteriores de cada moneda?</li>
<li>Incrementa el número de volados, por ejemplo a 10. ¿Qué pasa si
observaste 8 soles, por ejemplo? ¿Y si observaste 0?</li>
<li>¿Qué pasa si cambias las probabilidades iniciales (por ejemplo
incrementas la probabilidad inicial de la moneda 1 a 0.9)?</li>
</ul>
</div>



Justifica las siguientes aseveraciones (para este ejemplo):

<div class="ejercicio">
<ul>
<li>Las probabilidades posteriores o finales son una especie de punto
intermedio entre verosimilitud y probablidades iniciales.</li>
<li>Si tenemos pocas observaciones, las probabilidades posteriores son
similares a las iniciales.</li>
<li>Cuando tenemos muchos datos, las probabilidades posteriores están
más concentradas, y no es tan importante la inicial.</li>
<li>Si la inicial está muy concentrada en algún valor, la posterior
requiere de muchas observaciones para que se pueda concentrar en otros
valores diferentes a los de la inicial.</li>
</ul>
</div>

Ahora resumimos los elementos básicos de la inferencia bayesiana, que son
relativamente simples:

<div class="mathblock">
<p><strong>Inferencia bayesiana.</strong> Con la notación de arriba:</p>
<ul>
<li>Como <span class="math inline">\(X\)</span> son los datos
observados, llamamos a <span class="math inline">\(P(X|\theta)\)</span>
la <em>verosimilitud</em>, proceso generador de datos o modelo de los
datos.</li>
<li>El factor <span class="math inline">\(P(\theta)\)</span> le llamamos
la distribución <em>inicial</em> o <em>previa</em>.</li>
<li>La distribución que usamos para hacer inferencia <span
class="math inline">\(P(\theta|X)\)</span> es la distribución
<em>final</em> o <em>posterior</em></li>
</ul>
<p>Hacemos inferencia usando la ecuación</p>
<p><span class="math display">\[P(\theta | X) = \frac{P(X | \theta)
P(\theta)}{P(X)}\]</span></p>
<p>que también escribimos:</p>
<p><span class="math display">\[P(\theta | X) \propto P(X | \theta)
P(\theta)\]</span> donde <span class="math inline">\(\propto\)</span>
significa “proporcional a”. No ponemos <span
class="math inline">\(P(X)\)</span> pues como vimos arriba, es una
constante de normalización.</p>
</div>


En estadística Bayesiana, las probablidades posteriores $P(\theta|X)$ dan toda
la información que necesitamos para hacer inferencia. 

¿Cuándo damos probablidad
alta a un parámetro particular $\theta$? Cuando su verosimilitud es alta y/o
cuando su probabilidad inicial es alta. De este modo, la posterior combina la
información inicial que tenemos acerca de los parámetros con la información en
la muestra acerca de los parámetros (verosimilitud). Podemos ilustrar como
sigue:

<img src="images/perros.png" style="display: block; margin: auto;" />


## Ejemplo: estimando una proporción {-}

Consideremos ahora el problema de estimar una proporción $\theta$ de una
población dada usando una muestra iid $X_1,X_2,\ldots, X_n$ de variables
Bernoulli.  Ya sabemos calcular la
verosimilitud (el modelo de los datos):

$$P(X_1=x_1,X_2 =x_2,\ldots, X_n=x_n|\theta) = \theta^k(1-\theta)^{n-k},$$

donde $k = x_1 + x_2 +\cdots + x_k$ es el número de éxitos que observamos.

Ahora necesitamos una distribución inicial o previa $P(\theta)$. Aunque esta
distribución puede tener cualquier forma, supongamos que nuestro conocimiento
actual podemos resumirlo con una distribución $\mathsf{Beta}(3, 3)$:

$$P(\theta) \propto \theta^2(1-\theta)^2.$$
La constante de normalización es 1/30, pero no la requerimos. Podemos simular para examinar su forma:


```r
sim_inicial <- tibble(theta = rbeta(10000, 3, 3))
ggplot(sim_inicial) + geom_histogram(aes(x = theta, y = ..density..), bins = 15)
```

<img src="14-intro-bayesiana_files/figure-html/unnamed-chunk-7-1.png" width="480" style="display: block; margin: auto;" />
De modo que nuestra información inicial es que la proporción puede tomar
cualquier valor entre 0 y 1, pero es probable que tome un
valor no tan lejano de 0.5. Por ejemplo, con probabilidad 0.95 creemos
que $\theta$ está en el intervalo

```r
quantile(sim_inicial$theta, c(0.025, 0.975)) %>% round(2)
```

```
##  2.5% 97.5% 
##  0.15  0.85
```

Es difícil justificar en abstracto por qué escogeriamos una inicial con esta
forma. *Aunque esto los detallaremos más adelante*, puedes pensar, por el
momento, que alguien observó algunos casos de esta población, y quizá vio tres éxitos y tres fracasos. Esto sugeriría que es poco probable que la probablidad
$\theta$ sea muy cercana a 0 o muy cercana a 1.

Ahora podemos construir nuestra posterior. Tenemos que

$$P(\theta| X_1=x_1, \ldots, X_n=x_n) \propto P(X_1 = x_1,\ldots X_n=x_n | \theta)P(\theta) = \theta^{k+2}(1-\theta)^{n-k + 2}$$
donde la constante de normalización no depende de $\theta$. Como $\theta$ es un
parámetro continuo, la expresión de la derecha nos debe dar una densidad posterior.

Supongamos entonces que hicimos la prueba con $n = 30$ (número de prueba) y observamos
19 éxitos. Tendríamos entonces

$$P(\theta | S_n = 19) \propto \theta^{19 + 2} (1-\theta)^{30-19 +2} = \theta^{21}(1-\theta)^{13}$$

La cantidad de la derecha, una vez que normalizemos por el número $P(X=19)$, nos
dará una densidad posterior (tal cual, esta expresion no integra a 1). Podemos
obtenerla usando cálculo, pero recordamos que una distribución
$\mathsf{\mathsf{Beta}}(a,b)$ tiene como fórmula
$$\frac{1}{B(a,b)} \theta^{a-1}(1-\theta)^{b-1}$$
Concluimos entonces que la posterior tiene una distribución $\mathsf{Beta}(22,
14)$. Podemos simular de la posterior usando código estándar para ver cómo luce:


```r
sim_inicial <- sim_inicial %>% mutate(dist = "inicial")
sim_posterior <- tibble(theta = rbeta(10000, 22, 14)) %>% mutate(dist = "posterior")
sims <- bind_rows(sim_inicial, sim_posterior)
ggplot(sims, aes(x = theta, fill = dist)) +
  geom_histogram(aes(x = theta), bins = 30, alpha = 0.5, position = "identity")
```

<img src="14-intro-bayesiana_files/figure-html/unnamed-chunk-9-1.png" width="480" style="display: block; margin: auto;" />

La posterior nos dice cuáles son las *posibilidades* de dónde puede estar
el parámetro $\theta$. Nótese que ahora excluye prácticamente valores más chicos
que 0.25 o mayores que 0.9. Esta distribución posterior es el objeto con el
que hacemos inferencia: nos dice dónde es creíble que esté el parámetro $\theta$.

Podemos resumir de varias maneras. Por ejemplo, si queremos un estimador puntual
usamos la media posterior:


```r
sims %>% group_by(dist) %>%
  summarise(theta_hat = mean(theta) %>% round(3))
```

```
## # A tibble: 2 × 2
##   dist      theta_hat
##   <chr>         <dbl>
## 1 inicial       0.501
## 2 posterior     0.612
```
Nota que el estimador de máxima verosimilitud es $\hat{p} = 19/30 = 0.63$, que
es ligeramente diferente de la media posterior. ¿Por qué?

Y podemos construir intervalos de percentiles, que en esta situación
suelen llamarse *intervalos de credibilidad*, por ejemplo:


```r
f <- c(0.025, 0.975)
sims %>% group_by(dist) %>%
  summarise(cuantiles = quantile(theta, f) %>% round(2), f = f) %>%
  pivot_wider(names_from = f, values_from = cuantiles)
```

```
## # A tibble: 2 × 3
## # Groups:   dist [2]
##   dist      `0.025` `0.975`
##   <chr>       <dbl>   <dbl>
## 1 inicial      0.15    0.85
## 2 posterior    0.45    0.77
```
El segundo renglón nos da un intervalo posterior para $\theta$ de *credibilidad*
95\%. En inferencia bayesiana esto sustituye a los intervalos de confianza.

- El intervalo de la inicial expresa nuestras creencias a priori acerca de $\theta$. Este
intervalo es muy amplio (va de 0.15 a 0.85)
- El **intervalo de la posterior** actualiza nuestras creencias acerca de $\theta$
una vez que observamos los datos, y es considerablemente más angosto y por lo tanto
informativo.


Puedes experimentar en esta [shiny app](https://tereom.shinyapps.io/app_bernoulli/) con diferentes iniciales, número de volados y observación de éxitos.


**Observaciones**:

- Nótese que escogimos una forma analítica fácil para la inicial, pues resultó
así que la posterior es una distribución beta. No siempre es así, y veremos qué
hacer cuando nuestra inicial no es de un tipo "conveniente".
- Como tenemos la forma analítica de la posterior, es posible hacer los cálculos
de la media posterior, por ejemplo, **integrando** la densidad posterior a mano. Esto
generalmente no es factible, y en este ejemplo preferimos hacer una aproximación numérica. En este caso
particular es posible usando cálculo, y sabemos que la media de una $\mathsf{\mathsf{Beta}}(a,b)$ es
$a/(a+b)$, de modo que nuestra media posterior es

$$\hat{\mu} = (19 + 2)/(30 + 4) = 21/34 = 0.617 $$
que podemos interpretar como sigue: para calcular la media posterior, a nuestras
$n$ pruebas iniciales agregamos
4 pruebas adicionales fijas, con 2 éxitos y 2 fracasos, y calculamos la proporción
usual de éxitos.

<div class="ejercicio">
<p>Repite el análisis considerando en general <span
class="math inline">\(n\)</span> pruebas, con <span
class="math inline">\(k\)</span> éxitos. Utiliza la misma distribución
inicial.</p>
</div>
- Lo mismo aplica para el intervalo de 95% (¿cómo se calcularía integrando?). También
puedes usar la aproximación de R, por ejemplo:


```r
qbeta(0.025, shape1 = 22, shape2 = 14) %>% round(2)
```

```
## [1] 0.45
```

```r
qbeta(0.975, shape1 = 22, shape2 = 14) %>% round(2)
```

```
## [1] 0.76
```




## Ejemplo: observaciones uniformes {-}

Ahora regresamos al problema de estimación del máximo de una distribución uniforme.
En este caso, consideraremos un problema más concreto. Supongamos que hay una lotería
(tipo tradicional)
en México y no sabemos cuántos números hay. Obtendremos una muestra iid de $n$ números,
y haremos una aproximación continua, suponiendo que

$$X_i \sim U[0,\theta]$$

La verosimilitud es entonces
$$P(X_1,\ldots, X_n|\theta) = \theta^{-n},$$
cuando $\theta$ es mayor que todas las $X_i$, y cero en otro caso. Necesitaremos
una inicial $P(\theta)$.

Por la forma que tiene la verosimilitud, podemos intentar una 
[distribución Pareto](https://en.wikipedia.org/wiki/Pareto_distribution),
que tiene la forma

$$P(\theta) = \frac{\alpha \theta_0^\alpha}{\theta^{\alpha + 1}}$$
con soporte en $[\theta_0,\infty]$. Tenemos que escoger entonces el mínimo $\theta_0$ y
el parámetro $\alpha$. En primer lugar, como sabemos que es una lotería nacional,
creemos que no puede haber menos de unos 300 mil números, así que $\theta_0 = 300$.
La función acumulada de la pareto es $1- (300/\theta)^\alpha$, así que el cuantil 99% es


```r
alpha <- 1.1
(300/(0.01)^(1/alpha))
```

```
## [1] 19738
```
es decir, alrededor de 20 millones de números.  Creemos que es un poco probable
que el número de boletos sea mayor a esta cota.
Nótese ahora que la posterior cumple (multiplicando verosimilitud por inicial):

$$P(\theta|X_1,\ldots, X_n |\theta) \propto \theta^{-(n + 2.1)}$$

para $\theta$ mayor que el máximo de las $X_n$'s y 300, y cero en otro caso. Esta distribución
es pareto con $\theta_0' = \max\{300, X_1,\ldots, X_n\}$ y $\alpha' = n + 1.1$

Una vez planteado nuestro modelo, veamos los datos. Obtuvimos la siguiente
muestra de números:



```r
loteria_tbl <- read_csv("data/nums_loteria_avion.csv", col_names = c("id", "numero")) %>%
  mutate(numero = as.integer(numero))
set.seed(334)
muestra_loteria <- sample_n(loteria_tbl, 25) %>%
  mutate(numero = numero/1000)
muestra_loteria %>% as.data.frame %>% head
```

```
##   id   numero
## 1 87  348.341
## 2  5 5851.982
## 3 40 1891.786
## 4 51 1815.455
## 5 14 5732.907
## 6 48 3158.414
```

Podemos simular de una Pareto como sigue:


```r
rpareto <- function(n, theta_0, alpha){
  # usar el método de inverso de distribución acumulada
  u <- runif(n, 0, 1)
  theta_0 / (1 - u)^(1/alpha)
}
```

Simulamos de la inicial:


```r
sims_pareto_inicial <- tibble(
  theta = rpareto(20000, 300, 1.1 ),
  dist = "inicial")
```

Y con los datos de la muestra, simulamos de la posterior:


```r
sims_pareto_posterior <- tibble(
  theta = rpareto(20000,
                  max(c(300, muestra_loteria$numero)),
                  nrow(muestra_loteria) + 1.1),
  dist = "posterior")
sims_theta <- bind_rows(sims_pareto_inicial, sims_pareto_posterior)
ggplot(sims_theta) +
  geom_histogram(aes(x = theta, fill = dist),
                 bins = 70, alpha = 0.5, position = "identity",
                 boundary = max(muestra_loteria$numero))  +
  xlim(0, 15000) + scale_y_sqrt() +
  geom_rug(data = muestra_loteria, aes(x = numero))
```

<img src="14-intro-bayesiana_files/figure-html/unnamed-chunk-18-1.png" width="480" style="display: block; margin: auto;" />
Nótese que cortamos algunos valores de la inicial en la cola derecha: un defecto
de esta distribución inicial, con una cola tan larga a la derecha, es que
pone cierto peso en valores que son poco creíbles y la vuelve poco apropiada para
este problema. Regresamos más adelante a este problema.

Si obtenemos percentiles,
obtenemos el intervalo


```r
f <- c(0.025, 0.5, 0.975)
sims_theta %>% group_by(dist) %>%
  summarise(cuantiles = quantile(theta, f) %>% round(2), f = f) %>%
  pivot_wider(names_from = f, values_from = cuantiles)
```

```
## # A tibble: 2 × 4
## # Groups:   dist [2]
##   dist      `0.025` `0.5` `0.975`
##   <chr>       <dbl> <dbl>   <dbl>
## 1 inicial      307.  569.   8449.
## 2 posterior   5858. 6010.   6732.
```
Estimamos entre 5.8 millones y 6.7 millones de boletos. El máximo en la muestra
es de

```r
max(muestra_loteria$numero)
```

```
## [1] 5851.982
```

Escoger la distribución pareto como inicial es conveniente y nos permitió
resolver el problema sin dificultad, pero por su forma vemos que no
necesariamente es apropiada para el problema por lo que señalamos arriba.
Nos gustaría, por ejemplo, poner una inicial como
la siguiente


```r
qplot(rgamma(2000, 5, 0.001), geom="histogram", bins = 20) +
  scale_x_continuous(breaks = seq(1000, 15000, by = 2000))
```

<img src="14-intro-bayesiana_files/figure-html/unnamed-chunk-21-1.png" width="480" style="display: block; margin: auto;" />

Sin embargo, los cálculos no son tan simples en este caso, pues la posterior
no tiene un forma reconocible. Tendremos que usar otras estrategias de simulación
para ejemplos como este (Monte Carlo por medio de Cadenas de Markov, que veremos más adelante).

## Probabilidad a priori {-}

La inferencia bayesiana es conceptualmente simple: siempre hay que calcular
la posterior a partir de verosimilitud (modelo de datos) y distribución inicial
o a priori. Sin embargo, una crítica usual que se hace de la inferencia bayesiana
es precisamente que hay que tener esa información inicial, y que distintos analistas
llegan a distintos resultados si tienen información inicial distinta.

Eso realmente no es un defecto, es una ventaja de la inferencia bayesiana. Los datos
y los problemas que queremos resolver no viven en un vacío donde podemos creer
que la estatura de las personas, por ejemplo, puede variar de 0 a mil kilómetros,
el número de boletos de una lotería puede ir de 2 o 3 boletos o también quizá 500 millones
de boletos, o la proporción de personas infectadas de una enfermedad puede ser de unos cuantos
hasta miles de millones.

- En todos estos casos tenemos cierta información
inicial que podemos usar para informar nuestras estimaciones. Esta información debe
usarse.
- Antes de tener datos, las probabilidades iniciales deben ser examinadas
en términos del conocimiento de expertos.
- Las probabilidades iniciales son supuestos que hacemos acerca del problema de
interés, y también están sujetas a críticas y confrontación con datos.

## Análisis conjugado {-}

Los dos ejemplos que hemos visto arriba son ejemplos de análisis conjugado:


- (Beta-bernoulli) Si las observaciones $X_i$ son $\mathsf{Bernoulli}(p)$ ($n$ fija)
 queremos estimar $p$, y tomamos como distribución inicial para $p$ una $\mathsf{Beta}(a,b)$,
entonces la posterior para $p$ cuando $S_n=k$ es $\mathsf{Beta}(k + a, n - k + b)$,
donde $S_n = X_1 + X_2 +\cdots +X_n$.

Y más en general:

- (Beta-binomial) Si las observaciones $X_i, i=1,2,\ldots, m$
son $\mathsf{Binomial}(n_i, p)$ ($n_i$'s fijas) independientes,
 queremos estimar $p$, y tomamos como distribución inicial para $p$ una $\mathsf{Beta}(a,b)$,
entonces la posterior para $p$ cuando $S_m=k$ es $\mathsf{Beta}(k + a, n - k + b)$,
donde $S_m = X_1 + X_2 +\cdots +X_m$ y $n= n_1+n_2+\cdots+n_m$

También aplicamos:

- (Uniforme-Pareto) Si el modelo de datos $X_i$ es uniforme $\mathsf{U}[0,\theta]$ ($n$ fija),
queremos estimar $\theta$, y tomamos como distribución inicial para $\theta$ una
Pareto $(\theta_0, \alpha)$, entonces la posterior para $p$ si el máximo de las $X_i$'s
es igual a $M$ es Pareto con parámetros $(\max\{\theta_0, M\}, \alpha + n)$.

Nótese que en estos casos, dada una forma de la verosimilitud, tenemos una
familia conocida de iniciales tales que las posteriores están en la misma
familia. Estos modelos son convenientes porque podemos hacer simulaciones de la
posterior de manera fácil, o usar sus propiedades teóricas.

Otro ejemplo típico es el modelo normal-normal:

- (Normal-normal) Si $X_i\sim \mathsf{N}(\mu,\sigma)$, con $\sigma$ conocida, y tomamos
como distribución inicial para $\mu \sim \mathsf{N}(\mu_0,\sigma_0)$, y definimos
la *precisión* $\tau$ como el inverso de la varianza $\sigma^2$, entonces la posterior
de $\mu$ es Normal con media $(1-\lambda) \mu_0 + \lambda\overline{x}$, 
y precisión $\tau_0 + n\tau$, donde $\lambda = \frac{n\tau}{\tau_0 + n\tau}$

\BeginKnitrBlock{ejercicio}<div class="ejercicio">Completa cuadrados para mostrar las fórmulas del modelo normal-normal con
varianza conocida.</div>\EndKnitrBlock{ejercicio}

Más útil es el siguiente modelo:

- (Normal-Gamma inverso) Sean $X_i\sim \mathsf{N}(\mu, \sigma)$. Queremos estimar $\mu$ y $\sigma$. Tomamos
como distribuciones iniciales (dadas por 4 parámetros: $\mu_0, n_0, \alpha,\beta$):

  - $\tau = \frac{1}{\sigma^2} \sim \mathsf{Gamma}(\alpha,\beta)$
  - $\mu|\sigma$ es normal con media $\mu_0$ y varianza $\sigma^2 / {n_0}$ , y
  - $p(\mu, \sigma) = p(\mu|\sigma)p(\sigma)$  

- Entonces la posterior es:
  - $\tau|x$ es $\mathsf{Gamma}(\alpha', \beta')$, con $\alpha' = \alpha + n/2$,
  $\beta' = \beta + \frac{1}{2}\sum_{i=1}^{n}(x_{i} - \bar{x})^2 + \frac{nn_0}{n+n_0}\frac{({\bar{x}}-\mu_{0})^2}{2}$
  - $\mu|\sigma,x$ es normal con media $\mu' = \frac{n_0\mu_{0}+n{\bar{x}}}{n_0 +n}$ y varianza $\sigma^2/({n_0 +n})$.

  - $p(\mu,\sigma|x) = p(\mu|x,\sigma)p(\sigma|x)$


**Observaciones**

1. Nótese que este último ejemplo tiene más de un parámetro. En estos casos,
el objeto de interés es la **posterior conjunta** de los parámetros $p(\theta_1,\theta_2,\cdots, \theta_p|x)$.
Este último ejemplo es relativamente simple pues por la selección de iniciales,
para simular de la conjunta de $\mu$ y $\tau$ podemos simular primero $\tau$ (o $\sigma$), y después
usar este valor para simular de $\mu$: el par de valores resultantes son una simulación
de la conjunta.

2. Los parámetros $\alpha,\beta$ para la inicial de $\tau$ pueden interpretarse como sigue: $\sqrt{\beta/\alpha}$ es
un valor "típico" a priori para la varianza poblacional, y $a$ indica qué tan seguros estamos de
este valor típico.

3. Nótese que para que funcionen las fórmulas de la manera más simple,
escogimos una dependencia a priori
entre la media y la precisión: $\tau = \sigma^{-2}$ indica la escala de variabilidad que hay en la
población, la incial de la media tiene varianza $\sigma^2/n_0$. Si la escala
de variabilidad de la población es más grande, tenemos más incertidumbre acerca de la localización
de la media.

4. Aunque esto tiene sentido en algunas aplicaciones, y por convenviencia usamos esta familia
conjugada, muchas veces es preferible otro tipo de especificaciones para las iniciales: por ejemplo,
la media normal y la desviación estándar uniforme, o media normal, con iniciales
independientes. Sin embargo, estos casos
no son tratables con análisis conjugado (veremos más adelante cómo tratarlos con MCMC).


### Ejemplo {-}
Supongamos que queremos estimar la estatura de los cantantes de tesitura tenor con
una muestra iid de tenores de Estados Unidos. Usaremos el modelo normal de forma que $X_i\sim \mathsf{N}(\mu, \sigma^2)$.

Una vez decidido el modelo, tenemos que poner distribución inicial para los parámetros
$(\mu, \sigma^2)$.

Comenzamos con $\sigma^2$. Como está el modelo,
esta inicial debe estar dada para la precisión $\tau$, pero podemos simular para ver cómo
se ve nuestra inicial para la desviación estándar. En la población general la desviación
estándar es alrededor de 7 centímetros


```r
# Comenzamos seleccionando un valor que creemos típico para la desviación estándar
sigma_0 <- 7
# seleccionamos un valor para a, por ejemplo: si es más chico sigma tendrá más
# disperisón
a <- 3
# ponemos 7 = sqrt(b/a) -> b = a * 64
b <- a * sigma_0^2
c(a = a, b = b)
```

```
##   a   b 
##   3 147
```

Ahora simulamos para calcular cuantiles


```r
tau <- rgamma(1000, a, b)
quantile(tau, c(0.05, 0.95))
```

```
##          5%         95% 
## 0.005781607 0.042170161
```

```r
sigma <- 1 / sqrt(tau)
mean(sigma)
```

```
## [1] 8.002706
```

```r
quantile(sigma, c(0.05, 0.95))
```

```
##        5%       95% 
##  4.869653 13.151520
```
Que es dispersión considerable: con poca probabilidad la desviación estándar
es menor a 4 centímetros, y también creemos que es poco creíble la desviación
estándar sea de más de 13 centímetros.


Comenzamos con $\mu$. Sabemos, por ejemplo, que
con alta probabilidad la media debe ser algún número entre 1.60 y 1.80. Podemos investigar: la media
nacional en estados unidos está alrededor de 1.75, y el percentil 90% es 1.82.
Esto es *variabilidad en la población*: debe ser muy poco probable, por ejemplo, que la
media de tenores sea 1.82
Quizá los
cantantes tienden a ser un poco más altos o bajos que la población general, así que
podríamos agregar algo de dispersión.

Podemos establecer parámetros y simular de la marginal a partir
de las fórmulas de arriba para entender
cómo se ve la inicial de $\mu$:



```r
mu_0 <- 175 # valor medio de inicial
n_0 <- 5 # cuánta concentración en la inicial
tau <- rgamma(1000, a,b)
sigma <- 1/sqrt(tau)
mu <- map_dbl(sigma, ~ rnorm(1, mu_0, .x / sqrt(n_0)))
quantile(mu, c(0.05, 0.5, 0.95))
```

```
##       5%      50%      95% 
## 168.7275 174.8412 180.7905
```
Que consideramos un rango en el que con alta probabilidad debe estar
la media poblacional de los cantantes.

Podemos checar nuestros supuestos simulando posibles muestras usando
sólo nuestra información previa:


```r
simular_normal_invgamma <- function(n, pars){
  mu_0 <- pars[1]
  n_0 <- pars[2]
  a <- pars[3]
  b <- pars[4]
  # simular media
  tau <- rgamma(1, a, b)
  sigma <- 1 / sqrt(tau)
  mu <- rnorm(1, mu_0, sigma/sqrt(n_0))
  # simular sigma
  rnorm(n, mu, sigma)
}
set.seed(3461)
sims_tbl <- tibble(rep = 1:20) %>%
  mutate(estatura = map(rep, ~ simular_normal_invgamma(500, c(mu_0, n_0, a, b)))) %>%
  unnest(cols = c(estatura))
ggplot(sims_tbl, aes(x = estatura)) + geom_histogram() +
  facet_wrap(~ rep) +
  geom_vline(xintercept = c(150, 180), colour = "red")
```

<img src="14-intro-bayesiana_files/figure-html/unnamed-chunk-26-1.png" width="672" style="display: block; margin: auto;" />

Pusimos líneas de referencia en 150 y 180. Vemos que nuestras iniciales no producen
simulaciones totalmente fuera del contexto, y parecen cubrir apropiadamente el
espacio de posiblidades para estaturas de los tenores. Quizá hay algunas realizaciones
poco creíbles, pero no extremadamente. En este punto, podemos regresar y ajustar
la inicial para $\sigma$, que parece tomar valores demasiado grandes (produciendo
por ejemplo una simulación con estatura de 220 y 140, que deberían ser menos probables).


Ahora podemos usar los datos para calcular nuestras posteriores.


```r
set.seed(3413)
cantantes <- lattice::singer %>%
  mutate(estatura_cm = round(2.54 * height)) %>%
  filter(str_detect(voice.part, "Tenor")) %>%
  sample_n(20)
cantantes
```

```
##     height voice.part estatura_cm
## 139     70    Tenor 1         178
## 150     68    Tenor 2         173
## 140     65    Tenor 1         165
## 132     66    Tenor 1         168
## 152     69    Tenor 2         175
## 141     72    Tenor 1         183
## 161     71    Tenor 2         180
## 156     71    Tenor 2         180
## 158     71    Tenor 2         180
## 164     69    Tenor 2         175
## 147     68    Tenor 1         173
## 130     72    Tenor 1         183
## 162     71    Tenor 2         180
## 134     74    Tenor 1         188
## 170     69    Tenor 2         175
## 167     68    Tenor 2         173
## 149     64    Tenor 1         163
## 143     68    Tenor 1         173
## 157     69    Tenor 2         175
## 153     71    Tenor 2         180
```

Los cálculos son un poco tediosos, pero podemos construir una función apropiada:


```r
calcular_pars_posterior <- function(x, pars_inicial){
  # iniciales
  mu_0 <- pars_inicial[1]
  n_0 <- pars_inicial[2]
  a_0 <- pars_inicial[3]
  b_0 <- pars_inicial[4]
  # muestra
  n <- length(x)
  media <- mean(x)
  S2 <- sum((x - media)^2)
  # sigma post
  a_1 <- a_0 + 0.5 * n
  b_1 <- b_0 + 0.5 * S2 + 0.5 * (n * n_0) / (n + n_0) * (media - mu_0)^2
  # posterior mu
  mu_1 <- (n_0 * mu_0 + n * media) / (n + n_0)
  n_1 <- n + n_0
  c(mu_1, n_1, a_1, b_1)
}
pars_posterior <- calcular_pars_posterior(cantantes$estatura_cm, c(mu_0, n_0, a, b))
pars_posterior
```

```
## [1] 175.8  25.0  13.0 509.0
```

¿Cómo se ve nuestra posterior comparada con la inicial? Podemos hacer simulaciones:


```r
sim_params <- function(m, pars){
  mu_0 <- pars[1]
  n_0 <- pars[2]
  a <- pars[3]
  b <- pars[4]
  # simular sigmas
  sims <- tibble(tau = rgamma(m, a, b)) %>%
    mutate(sigma = 1 / sqrt(tau))
  # simular mu
  sims <- sims %>% mutate(mu = rnorm(m, mu_0, sigma / sqrt(n_0)))
  sims
}
sims_inicial <- sim_params(5000, c(mu_0, n_0, a, b)) %>%
  mutate(dist = "inicial")
sims_posterior <- sim_params(5000, pars_posterior) %>%
  mutate(dist = "posterior")
sims <- bind_rows(sims_inicial, sims_posterior)
ggplot(sims, aes(x = mu, y = sigma, colour = dist)) +
  geom_point()
```

<img src="14-intro-bayesiana_files/figure-html/unnamed-chunk-29-1.png" width="480" style="display: block; margin: auto;" />

Y vemos que nuestra posterior es consistente con la información inicial
que usamos, hemos aprendido considerablemente de la muestra. La posterior se
ve como sigue. Hemos marcado también las medias posteriores de cada parámetro:
media y desviación estándar.


```r
medias_post <- sims %>% filter(dist == "posterior") %>%
  select(-dist) %>%
  summarise(across(everything(), mean))
ggplot(sims %>% filter(dist == "posterior"),
    aes(x = mu, y = sigma)) +
  geom_point(colour = "#00BFC4") +
  geom_point(data = medias_post, size = 5, colour = "black") +
  coord_equal()
```

<img src="14-intro-bayesiana_files/figure-html/unnamed-chunk-30-1.png" width="480" style="display: block; margin: auto;" />
Podemos construir intervalos creíbles del 90% para estos dos parámetros, por ejemplo
haciendo intervalos de percentiles:


```r
f <- c(0.05, 0.5, 0.95)
sims %>%
  pivot_longer(cols = mu:sigma, names_to = "parametro") %>%
  group_by(dist, parametro) %>%
  summarise(cuantil = quantile(value, f) %>% round(1), f= f) %>%
  pivot_wider(names_from = f, values_from = cuantil)
```

```
## # A tibble: 4 × 5
## # Groups:   dist, parametro [4]
##   dist      parametro `0.05` `0.5` `0.95`
##   <chr>     <chr>      <dbl> <dbl>  <dbl>
## 1 inicial   mu         169.  175.   181. 
## 2 inicial   sigma        4.8   7.4   13.3
## 3 posterior mu         174.  176.   178. 
## 4 posterior sigma        5.1   6.3    8.2
```

Como comparación, los estimadores de máxima verosimlitud son


```r
media_mv <- mean(cantantes$estatura_cm)
sigma_mv <- mean((cantantes$estatura_cm - media_mv)^2) %>% sqrt
c(media_mv, sigma_mv)
```

```
## [1] 176   6
```

Ahora solo resta checar que el modelo es razonable. Veremos más adelante cómo hacer esto,
usando la distribución predictiva posterior.



## Pasos de un análisis de datos bayesiano {-}

<div class="comentario">
<p>Como vimos en los ejemplos, en general un análisis de datos bayesiano
sigue los siguientes pasos:</p>
<ul>
<li><p>Identificar los datos releventes a nuestra pregunta de
investigación, el tipo de datos que vamos a describir, que variables
queremos estimar.</p></li>
<li><p>Definir el modelo descriptivo para los datos. La forma matemática
y los parámetros deben ser apropiados para los objetivos del
análisis.</p></li>
<li><p>Especificar la distribución inicial de los parámetros.</p></li>
<li><p>Utilizar inferencia bayesiana para reubicar la credibilidad a lo
largo de los posibles valores de los parámetros.</p></li>
<li><p>Verificar que la distribución posterior replique los datos de
manera razonable, de no ser el caso considerar otros modelos
descriptivos para los datos.</p></li>
</ul>
</div>



#### Elicitando probablidades subjetivas (opcional) {-}

No siempre es fácil elicitar probabilidades subjetivas de manera que capturemos
el verdadero conocimiento de dominio que tenemos. Una manera clásica de hacerlo
es con apuestas

Considera una pregunta sencilla que puede afectar a un viajero: ¿Qué tanto
crees que habrá una tormenta que ocasionará el cierre de la autopista
México-Acapulco en el puente del $20$ de noviembre? Como respuesta debes dar
un número entre $0$ y $1$ que refleje tus creencias. Una manera de seleccionar
dicho número es calibrar las creencias en relación a otros eventos cuyas
probabilidades son claras.

Como evento de comparación considera una experimento donde hay canicas en una
urna: $5$ rojas y $5$ blancas. Seleccionamos una canica al azar. Usaremos esta urna
como comparación para considerar la tormenta en la autopista. Ahora, considera
el siguiente par de apuestas de las cuales puedes elegir una:

* A. Obtienes $\$1000$ si hay una tormenta que ocasiona el cierre de la autopista
el próximo $20$ de noviembre.

* B. Obtienes $\$1000$ si seleccionas una canica roja de la urna que contiene
$5$ canicas rojas y $5$ blancas.

Si prefieres la apuesta B, quiere decir que consideras que la probabilidad de
tormenta es menor a $0.5$, por lo que al menos sabes que tu creencia subjetiva de
una la probabilidad de tormenta es menor a $0.5$. Podemos continuar con el proceso
para tener una mejor estimación de la creencia subjetiva.

* A. Obtienes $\$1000$ si hay una tormenta que ocasiona el cierre de la autopista
el próximo $20$ de noviembre.

* C. Obtienes $\$1000$ si seleccionas una canica roja de la urna que contiene
$1$ canica roja y $9$ blancas.

Si ahora seleccionas la apuesta $A$, esto querría decir que consideras que la
probabilidad de que ocurra una tormenta es mayor a $0.10$. Si consideramos ambas
comparaciones tenemos que tu probabilidad subjetiva se ubica entre $0.1$ y $0.5$.

## Verificación predictiva posterior {-}

Una vez que ajustamos un modelo bayesiano, podemos simular nuevas observaciones
a partir del modelo. Esto tiene dos utilidades:

- Hacer predicciones acerca de datos no observados.
- Confirmar que nuevas observaciones, producidas simulando con el modelo son similares a las
que de hecho observamos. Esto nos permite confirmar la calidad del ajuste del
modelo, y se llama **verificación predictiva posterior**.

Supongamos que tenemos la posterior $p(\theta | x)$. Podemos generar una nueva
*replicación* de los datos como sigue:

<div class="mathblock">
<p>La distribución <strong>predictiva posterior</strong> genera nuevas
observaciones a partir de la información observada. La denotamos como
<span class="math inline">\(p(\tilde{x}|x)\)</span>.</p>
<p>Para simular de ella:</p>
<ul>
<li>Muestreamos un valor <span
class="math inline">\(\tilde{\theta}\)</span> de la posterior <span
class="math inline">\(p(\theta|x)\)</span>.</li>
<li>Simulamos del modelo de las observaciones <span
class="math inline">\(\tilde{x} \sim
p(\tilde{x}|\tilde{\theta})\)</span>.</li>
<li>Repetimos el proceso hasta obtener una muestra grande.</li>
<li>Usamos este método para producir, por ejemplo, <strong>intervalos de
predicción</strong> para nuevos datos.</li>
</ul>
<p>Si queremos una replicación de las observaciones de la predictiva
posterior,</p>
<ul>
<li>Muestreamos un valor <span
class="math inline">\(\tilde{\theta}\)</span> de la posterior <span
class="math inline">\(p(\theta|x)\)</span>.</li>
<li>Simulamos del modelo de las observaciones <span
class="math inline">\(\tilde{x}_1, \tilde{x}_2,\ldots, \tilde{x}_n \sim
p(\tilde{x}|\tilde{\theta})\)</span>, done <span
class="math inline">\(n\)</span> es el tamaño de muestra de la muestra
original <span class="math inline">\(x\)</span>.</li>
<li>Usamos este método para producir conjuntos de datos simulados que
comparamos con los observados para verificar nuestro modelo.</li>
</ul>
</div>


### Ejemplo: estaturas de tenores {-}

En este ejemplo, usaremos la posterior predictiva para checar nuestro modelo.
Vamos a crear varias muestras, del mismo tamaño que la original, según nuestra predictiva posterior, y compararemos estas muestras con la observada.

Y ahora simulamos otra muestra


```r
muestra_sim <- simular_normal_invgamma(20, pars_posterior)
muestra_sim %>% round(0)
```

```
##  [1] 167 181 184 181 167 167 172 170 177 172 169 174 182 184 176 171 175 176 168
## [20] 181
```

Podemos simular varias muestras y hacer una prueba de lineup:


```r
library(nullabor)
set.seed(9921)
sims_obs <- tibble(.n = 1:19) %>%
  mutate(estatura_cm = map(.n, ~ simular_normal_invgamma(20, pars_posterior))) %>%
  unnest(estatura_cm)
pos <- sample(1:20, 1)
lineup_tbl <- lineup(true = cantantes %>% select(estatura_cm),
                     samples = sims_obs, pos = pos)
ggplot(lineup_tbl, aes(x = estatura_cm)) + geom_histogram(binwidth = 2.5) +
  facet_wrap(~.sample)
```

<img src="14-intro-bayesiana_files/figure-html/unnamed-chunk-36-1.png" width="480" style="display: block; margin: auto;" />
Con este tipo de gráficas podemos checar desajustes potenciales de nuestro modelo.

<div class="ejercicio">
<ul>
<li>¿Puedes encontrar los datos verdaderos? ¿Cuántos seleccionaron los
datos correctos?</li>
<li>Prueba hacer pruebas con una gráfica de cuantiles. ¿Qué problema ves
y cómo lo resolverías?</li>
</ul>
</div>


### Ejemplo: modelo Poisson {-}

Supongamos que pensamos el modelo para las observaciones es
Poisson con parámetro $\lambda$. Pondremos como inicial para $\lambda$ una exponencial
con media 10.

Nótese que la posterior está dada por

$$p(\lambda|x_1,\ldots, x_n) \propto e^{-n\lambda}\lambda^{\sum_i x_i} e^{-0.1\lambda} = \lambda^{n\overline{x}}e^{-\lambda(n + 0.1)}$$
que es una distribución gamma con parámetros $(n\overline{x} + 1, n+0.1)$

Ahora supongamos que observamos la siguiente muestra, ajustamos nuestro modelo
y hacemos replicaciones posteriores de los datos observados:


```r
x <- rnbinom(250, mu = 20, size = 3)
crear_sim_rep <- function(x){
  n <- length(x)
  suma <- sum(x)
  sim_rep <- function(rep){
    lambda <- rgamma(1, sum(x) + 1, n + 0.1)
    x_rep <- rpois(n, lambda)
    tibble(rep = rep, x_rep = x_rep)
  }
}
sim_rep <- crear_sim_rep(x)
lineup_tbl <- map(1:5, ~ sim_rep(.x)) %>%
  bind_rows() %>%
  bind_rows(tibble(rep = 6, x_rep = x))
ggplot(lineup_tbl, aes(x = x_rep)) +
  geom_histogram(bins = 15) +
  facet_wrap(~rep)
```

<img src="14-intro-bayesiana_files/figure-html/unnamed-chunk-38-1.png" width="480" style="display: block; margin: auto;" />
Y vemos claramente que nuestro modelo no explica apropiadamente la variación
de los datos observados. Contrasta con:


```r
set.seed(223)
x <- rpois(250, 15)
crear_sim_rep <- function(x){
  n <- length(x)
  suma <- sum(x)
  sim_rep <- function(rep){
    lambda <- rgamma(1, sum(x) + 1, n + 0.1)
    x_rep <- rpois(n, lambda)
    tibble(rep = rep, x_rep = x_rep)
  }
}
sim_rep <- crear_sim_rep(x)
lineup_tbl <- map(1:5, ~ sim_rep(.x)) %>%
  bind_rows() %>%
  bind_rows(tibble(rep = 6, x_rep = x))
ggplot(lineup_tbl, aes(x = x_rep)) +
  geom_histogram(bins = 15) +
  facet_wrap(~rep)
```

<img src="14-intro-bayesiana_files/figure-html/unnamed-chunk-39-1.png" width="480" style="display: block; margin: auto;" />
Y verificamos que en este caso el ajuste del modelo es apropiado.




## Predicción {-}

Cuando queremos hacer predicciones particulares acerca de datos
que observemos en el futuro, también podemos usar la
posterior predictiva. En este caso, tenemos que considerar

1. La variabilidad que produce la incertidumbre en la estimación de los parámetros
2. La variabilidad de las observaciones dados los parámetros.

Es decir, tenemos que simular sobre todos las combinaciones factibles de los
parámetros.

### Ejemplo: cantantes {-}

Si un nuevo tenor llega a un coro, ¿cómo hacemos una predicción de su estatura? Como
siempre, quisiéramos obtener un intervalo que exprese nuestra incertidumbre acerca
del valor que vamos a observar. Entonces haríamos:


```r
sims_posterior <- sim_params(50000, pars_posterior) %>%
  mutate(y_pred = rnorm(n(), mu, sigma))
sims_posterior %>% head
```

```
## # A tibble: 6 × 4
##      tau sigma    mu y_pred
##    <dbl> <dbl> <dbl>  <dbl>
## 1 0.0286  5.91  175.   181.
## 2 0.0200  7.07  177.   178.
## 3 0.0257  6.23  176.   170.
## 4 0.0344  5.39  176.   174.
## 5 0.0297  5.80  175.   169.
## 6 0.0282  5.96  177.   170.
```

```r
f <- c(0.025, 0.5, 0.975)
sims_posterior %>% summarise(f = f, y_pred = quantile(y_pred, f))
```

```
## # A tibble: 3 × 2
##       f y_pred
##   <dbl>  <dbl>
## 1 0.025   163.
## 2 0.5     176.
## 3 0.975   189.
```

Y con esto obtenemos el intervalo (163, 189), al 95%, para una nueva observación. Nótese
que este intervalo no puede construirse con una simulación particular de la posterior de los parámetros,
pues sería demasiado corto.

Es posible demostrar que en este caso, la posterior predictiva tiene una forma conocida:

- La posterior predictiva para el modelo normal-gamma inverso es una distribución
$t$ con $2\alpha'$ grados de libertad, centrada en $\mu'$, y con escala $s^2 = \frac{\beta'}{\alpha'}\frac{n + n_0 + 1}{n +n_0}$


```r
mu_post <- pars_posterior[1]
n_post <- pars_posterior[2]
alpha_post <- pars_posterior[3]
beta_post <- pars_posterior[4]
s <- sqrt(beta_post/alpha_post) * sqrt((n_post + 1)/n_post)
qt(c(0.025, 0.5, 0.975), 2 * alpha_post) * s + mu_post
```

```
## [1] 162.6832 175.8000 188.9168
```




\BeginKnitrBlock{ejercicio}<div class="ejercicio">- Calcula la posterior predictiva del modelo Beta-Bernoulli y Beta-Binomial.
- (Más difícil) Calcula la posterior predictiva del modelo Poisson-Gamma.</div>\EndKnitrBlock{ejercicio}



### Ejemplo: posterior predictiva de Pareto-Uniforme. {-}

 La posterior predictiva del modelo Pareto-Uniforme no tiene un nombre estándar, pero
 podemos aproximarla usando simulación. Usando los mismos datos del ejercicio de la lotería, haríamos:


```r
rpareto <- function(n, theta_0, alpha){
  # usar el método de inverso de distribución acumulada
  u <- runif(n, 0, 1)
  theta_0 / (1 - u)^(1/alpha)
}
# Simulamos de la posterior de los parámetros
lim_inf_post <- max(c(300, muestra_loteria$numero))
k_posterior <- nrow(muestra_loteria) + 1.1
sims_pareto_posterior <- tibble(
  theta = rpareto(100000, lim_inf_post, k_posterior))
# Simulamos una observación para cada una de las anteriores:
sims_post_pred <- sims_pareto_posterior %>%
  mutate(x_pred = map_dbl(theta, ~ runif(1, 0, .x)))
# Graficamos
ggplot(sims_post_pred, aes(x = x_pred)) +
  geom_histogram(binwidth = 50) +
  geom_vline(xintercept = lim_inf_post, colour = "red")
```

<img src="14-intro-bayesiana_files/figure-html/unnamed-chunk-44-1.png" width="480" style="display: block; margin: auto;" />

Que es una mezcla de una uniforme con una Pareto.