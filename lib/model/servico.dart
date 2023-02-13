import 'package:app_barbearia/model/tipoServico.dart';
import 'package:app_barbearia/model/valor.dart';

class Servico {
  int? id;
  String nomeCliente;
  DateTime data;
  DateTime hora;
  TipoServico tipoServico;
  Valor? valor;

  Servico(
      {this.id,
      required this.nomeCliente,
      required this.data,
      required this.hora,
      required this.tipoServico,
      this.valor});

  factory Servico.fromMap(Map<String, dynamic> json) => Servico(
      id: json['id'],
      nomeCliente: json['nomeCliente'],
      data: DateTime.parse(json['data']),
      hora: DateTime.parse(json['hora']),
      tipoServico:
          TipoServico.values.firstWhere((s) => s.value == json['tipoServico']));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeCliente': nomeCliente,
      'data': data.toIso8601String(),
      'hora': hora.toIso8601String(),
      'tipoServico': tipoServico.value,
    };
  }
}
