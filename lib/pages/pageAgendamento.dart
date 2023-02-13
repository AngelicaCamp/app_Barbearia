import 'package:app_barbearia/database/servicoDbHelper.dart';
import 'package:app_barbearia/model/servico.dart';
import 'package:flutter/material.dart';

class PageAgendamento extends StatefulWidget {
  const PageAgendamento({Key? key}) : super(key: key);

  @override
  State<PageAgendamento> createState() => _PageAgendamentoState();
}

class _PageAgendamentoState extends State<PageAgendamento> {
  final ServicoDbHelper servicoDbHelper = ServicoDbHelper();
  List<Servico> listServices = [];

  _updateListServices() async {
    List<Servico> services = await servicoDbHelper.listServices();
    setState(() {
      listServices = services;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateListServices();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: listServices.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.amber,
            child: Text('${listServices[index]}'),
          );
        });
  }
}
