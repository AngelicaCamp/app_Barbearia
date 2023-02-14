import 'package:app_barbearia/database/servicoDbHelper.dart';
import 'package:app_barbearia/model/servico.dart';
import 'package:app_barbearia/model/tipoServico.dart';
import 'package:flutter/material.dart';

class PageAgendamento extends StatefulWidget {
  const PageAgendamento({super.key});

  @override
  State<PageAgendamento> createState() => _PageAgendamentoState();
}

class _PageAgendamentoState extends State<PageAgendamento> {
  final ServicoDbHelper servicoDbHelper = ServicoDbHelper();
  List<Servico> listServices = [];
  SampleItem? selectedMenu;

  updateListServices() async {
    List<Servico> services = await servicoDbHelper.listServices();
    setState(() {
      listServices = services;
    });
  }

  @override
  void initState() {
    super.initState();
    updateListServices();
  }

  @override
  Widget build(BuildContext context) {
    return createListViewServices();
  }

  createListViewServices() {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
        child: Scrollbar(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              var item = listServices[index];
              return Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.access_time_filled,
                      size: 40,
                      color: Colors.blueGrey,
                    ),
                    // leading: Expanded(
                    //   child: IconButton(
                    //     iconSize: 60,
                    //     onPressed: null,
                    //     icon: Image.asset(
                    //       selectImage(item.tipoServico),
                    //     ),
                    //   ),
                    // ),
                    // NOME CLIENTE
                    title: Text(item.nomeCliente.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8),
                      child: RichText(
                        text: TextSpan(children: <TextSpan>[
                          // DATA
                          const TextSpan(
                              text: 'Data: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              text:
                                  ('${item.data_hora.day}/${item.data_hora.month}/${item.data_hora.year}')),
                          // HORA
                          const TextSpan(
                              text: '\nHora: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            text:
                                ('${item.data_hora.hour}:${item.data_hora.minute}'),
                          ),
                          // TIPO DE SERVIÇO
                          const TextSpan(
                              text: '\nServiço: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          TextSpan(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            text: ('${item.tipoServico.value}'),
                          ),
                          // VALOR SERVIÇO
                          const TextSpan(
                              text: '\nValor: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          TextSpan(
                            text: ('${item.valor}'),
                          ),
                        ]),
                      ),
                    ),
                    trailing: createPopupMenuButton(item),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: listServices.length,
          ),
        ),
      ),
    );
  }

  selectImage(TipoServico tipoServico) {
    Map<TipoServico, String> listImages = {
      TipoServico.corte: "assets/images/cabelo.jpg",
      TipoServico.barba: "assets/images/barba.jpg",
      TipoServico.corte_end_barba: "assets/images/cabelo+barba.jpg",
      TipoServico.coloracao: "assets/images/coloracao.png",
    };

    return listImages[tipoServico];
  }

  createPopupMenuButton(Servico servico) {
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          onTap: null,
          value: SampleItem.editar,
          child: Text('Editar'),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.excluir,
          onTap: null,
          child: Text('Excluir'),
        ),
      ],
      onSelected: (SampleItem item) {
        setState(() {
          //selectedMenu = item;
          switch (item) {
            case SampleItem.editar:
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) =>
              //             EditDocumentoPage(documento: widget.document)));
              break;
            case SampleItem.excluir:
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  elevation: 5.0,
                  title: Text("Deseja excluir ${servico.id} definitivamente?"),
                  actions: [
                    MaterialButton(
                      child: const Text("Sim"),
                      onPressed: () {
                        servicoDbHelper.removeService(servico.id!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "O agendamento do serviço foi excluido com sucesso!"),
                            duration: Duration(seconds: 4),
                          ),
                        );
                        Navigator.pop(context);
                        setState(() {
                          listServices.remove(servico);
                        });
                      },
                    ),
                    MaterialButton(
                      child: const Text('Não'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              );
              break;
          }
        });
      },
    );
  }
}

enum SampleItem {
  editar,
  excluir,
}
