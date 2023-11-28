// Ejemplo de estimación del máximo de uniforme
data {
  int n; // número de observaciones
  array[n] real y; //datos observados
}

transformed data{
  real y_max;
  y_max = max(y);
}
parameters {
  real<lower=y_max> theta;
}

model {
  // inicial
  theta ~ pareto(300, 1.1);
  y ~ uniform(0, theta);
}

