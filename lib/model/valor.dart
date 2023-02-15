import 'package:app_barbearia/model/tipoServico.dart';

enum Valor {
  valorCorte(valor: 45.00),
  valorBarba(valor: 45.00),
  valorCorteEndBarba(valor: 80.00),
  valorColoracao(valor: 55.00);

  const Valor({required this.valor});

  final double valor;

  static Valor getValor(TipoServico tipoServico) {
    switch (tipoServico) {
      case TipoServico.corte:
        return Valor.valorCorte;
        break;
      case TipoServico.corte_end_barba:
        return Valor.valorCorteEndBarba;
        break;
      case TipoServico.coloracao:
        return Valor.valorColoracao;
        break;
      case TipoServico.barba:
        return Valor.valorBarba;
        break;
    }
  }
}
