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
  theta ~ gamma(5, 0.0001);
  y ~ uniform(0, theta);
}

