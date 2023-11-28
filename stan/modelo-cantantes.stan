// Ejemplo de modelo normal para estaturas de cantantes
data {
  int n; // número de observaciones
  array[n] real y; //datos observados
}

parameters {
  real mu;
  real<lower=2, upper=20> sigma;
}

model {
  // inicial
  mu ~ normal(175, 3);
  sigma ~ uniform(2, 20);
  y ~ normal(mu, sigma);
}

generated quantities {
  array[n] real y_sim;  
  for(i in 1:n){
    y_sim[i] = normal_rng(mu, sigma);
  }

}
