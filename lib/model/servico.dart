import 'package:app_barbearia/model/tipoServico.dart';
import 'package:app_barbearia/model/valor.dart';

class Servico {
  int? id;
  String nomeCliente;
  DateTime data_hora;
  TipoServico tipoServico;
  Valor? valor;

  Servico(
      {this.id,
      required this.nomeCliente,
      required this.data_hora,
      required this.tipoServico,
      this.valor});

  factory Servico.fromMap(Map<String, dynamic> json) {
    TipoServico tipoServico =
        TipoServico.values.firstWhere((s) => s.value == json['tipoServicos']);

    return Servico(
        id: json['id'],
        nomeCliente: json['nome'],
        data_hora: DateTime.parse(json['data_hora']),
        tipoServico: tipoServico);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nomeCliente,
      'data_hora': data_hora.toIso8601String(),
      'tipoServicos': tipoServico.value,
    };
  }
}
