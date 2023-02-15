import 'package:app_barbearia/database/servicoDbHelper.dart';
import 'package:app_barbearia/model/servico.dart';
import 'package:app_barbearia/model/tipoServico.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/valor.dart';

class PageAgendamento extends StatefulWidget {
  const PageAgendamento({super.key});

  @override
  State<PageAgendamento> createState() => _PageAgendamentoState();
}

class _PageAgendamentoState extends State<PageAgendamento> {
  final ServicoDbHelper servicoDbHelper = ServicoDbHelper();
  List<Servico> listServices = [];
  SampleItem? selectedMenu;

  final _keyForm = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  var _dropdownValueService;
  final GlobalKey<FormFieldState> _keyDropdownValueService = GlobalKey();

  DateTime? date;
  DateTime? newTime;
  DateTime date_time = DateTime.now();

  List<TipoServico> tiposServicos = TipoServico.values;
  List<Valor> valores = Valor.values;

  Servico? _servico;

  final ServicoDbHelper _servicoDbHelper = ServicoDbHelper();

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
    return Column(
      children: [
        createForm(),
        createListViewServices(),
      ],
    );
  }

  getFieldData(Servico servico) {
    _servico = servico;
    _dropdownValueService = _servico!.tipoServico;
    _nameController.text = _servico!.nomeCliente;
    date_time = _servico!.data_hora;
    _dateController.text = DateFormat("dd/MM/yyyy").format(date_time);
    _timeController.text = DateFormat("HH:mm").format(date_time);
  }

  createForm() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Form(
        key: _keyForm,
        child: Column(
          children: [
            // SERVICE
            createDropdownButtonFormFieldService(),
            // NAME
            createTextFormFieldName(),
            // DATE e TIME
            createDateTimeField(),
            // BUTTONS
            createElevationButtons(),
          ],
        ),
      ),
    );
  }

  createDropdownButtonFormFieldService() {
    return DropdownButtonFormField<dynamic>(
        decoration: InputDecoration(
          hintText: 'Serviço',
          suffixIcon: IconButton(
            icon: const Icon(Icons.notes_outlined),
            onPressed: () {
              _dropdownValueService = null;
              _keyDropdownValueService.currentState?.reset();
            },
          ),
        ),
        key: _keyDropdownValueService,
        value: _dropdownValueService,
        items: [
          for (var servico in tiposServicos) ...[
            DropdownMenuItem(value: servico, child: Text(servico.value))
          ]
        ],
        onChanged: (dynamic? value) {
          _dropdownValueService = value;
        });
  }

  createTextFormFieldName() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(labelText: 'Cliente:'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Necessário preenchimento - Campo nome obrigatório';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _servico!.nomeCliente = value!;
        });
      },
    );
  }

  createDateTimeField() {
    return Row(
      children: [
        // DATE
        Expanded(
          child: TextFormField(
            controller: _dateController,
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today),
              labelText: 'Data',
            ),
            readOnly: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Necessário preenchimento - Campo data obrigatório';
              } else {
                return null;
              }
            },
            onTap: () {
              createShowDatePicker(context);
            },
          ),
        ),
        // TIME
        Expanded(
          child: TextFormField(
            controller: _timeController,
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today),
              labelText: 'Hora',
            ),
            readOnly: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Necessário preenchimento - Campo data obrigatório';
              } else {
                return null;
              }
            },
            onTap: () {
              createShowTimePicker(context);
            },
          ),
        ),
      ],
    );
  }

  void createShowDatePicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
      locale: Localizations.localeOf(context),
    );

    if (date != null) {
      if (mounted) {
        setState(() {
          _dateController.text = DateFormat("dd/MM/yyyy").format(date);
          date_time = DateTime(date.year, date.month, date.day, date_time.hour,
              date_time.minute);
        });
      }
    }
  }

  void createShowTimePicker(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (newTime != null) {
      if (mounted) {
        setState(() {
          date_time = DateTime(date_time.year, date_time.month, date_time.day,
              newTime.hour, newTime.minute);
          _timeController.text = DateFormat("HH:mm").format(date_time);
        });
      }
    }
  }

  createElevationButtons() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffB1672E)),
              onPressed: () {
                var form = _keyForm.currentState;
                if (form?.validate() ?? false) {
                  addService();
                }
              },
              child: const Text(
                'Agendar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffDCDCDC),
              ),
              child: const Text('Cancelar',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              onPressed: () {
                _resetForm();
              },
            ),
          ),
        ),
      ],
    );
  }

  createService() {
    return Servico(
        id: _servico != null ? _servico!.id : null,
        nomeCliente: _nameController.text,
        data_hora: date_time,
        tipoServico: _dropdownValueService);
  }

  addService() async {
    final service = createService();

    if (service.id == null) {
      await _servicoDbHelper.insertService(service);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Serviço foi agendado!"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      await _servicoDbHelper.updateService(service);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Seu agendamento foi atualizado!"),
          duration: Duration(seconds: 2),
        ),
      );
    }
    _resetForm();
    await updateListServices();
  }

  _resetForm() {
    setState(() {
      _keyForm.currentState?.reset();
      _dropdownValueService = null;
      _nameController.clear();
      _dateController.clear();
      _timeController.clear();
    });
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
              var valor =
                  Valor.getValor(item.tipoServico).valor.toStringAsFixed(2);
              return Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.access_time_filled,
                      size: 40,
                      color: Colors.blueGrey,
                    ),

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
                              style: const TextStyle(
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
                            text: (item.tipoServico.value),
                          ),
                          // VALOR SERVIÇO
                          const TextSpan(
                              text: '\nValor: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                          TextSpan(
                              text: ('R\$ ${valor}'),
                              style: const TextStyle(
                                color: Colors.black,
                              )),
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
              setState(() {
                getFieldData(servico);
              });
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
