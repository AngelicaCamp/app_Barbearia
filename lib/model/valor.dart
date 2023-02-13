enum Valor {
  valorCorte(valor: 45.00),
  valorBarba(valor: 45.00),
  valorCorteEndBarba(valor: 80.00),
  valorColoracao(valor: 55.00);

  const Valor({required this.valor});

  final double valor;
}
