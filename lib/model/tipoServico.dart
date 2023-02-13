enum TipoServico {
  corte(value: "Corte"),
  barba(value: "Barba"),
  corte_end_barba(value: "Corte e Barba"),
  coloracao(value: "Coloração");

  const TipoServico({required this.value});

  final String value;
}
