import 'package:app_barbearia/database/servicoDbHelper.dart';
import 'package:flutter/material.dart';

import '../model/servico.dart';
import '../model/tipoServico.dart';
import '../model/valor.dart';

class PageServico extends StatefulWidget {
  const PageServico({Key? key}) : super(key: key);

  @override
  State<PageServico> createState() => _PageServicoState();
}

class _PageServicoState extends State<PageServico> {
  final _keyForm = GlobalKey<FormState>();
  final _serviceController = TextEditingController();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  DateTime? date;
  DateTime? newTime;
  DateTime? dataTimeStamp;
  DateTime? horaTimeStamp;

  var _dropdownValueService;
  final GlobalKey<FormFieldState> _keyDropdownValueService = GlobalKey();

  List<TipoServico> tiposServicos = TipoServico.values;
  List<Valor> valores = Valor.values;

  late final Servico _servico;

  final ServicoDbHelper _servicoDbHelper = ServicoDbHelper();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        createGridView(),
        createForm(),
      ],
    );
  }

  createGridView() {
    return Flexible(
      child: GridView.count(
          crossAxisCount: 2,
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            // CARD CORTE
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5.0,
                    offset: Offset(0.0, 0.80),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              // color: Color.fromARGB(255, 174, 185, 184),
              child: Column(children: [
                const Text('Corte'),
                Image.asset(
                  'assets/images/cabelo.jpg',
                  height: 100.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                ),
                Text('R\$ ${valores[0].valor.toStringAsFixed(2)}'),
              ]),
            ),
            // CARD BARBA
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5.0,
                    offset: Offset(0.0, 0.80),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              // color: Color.fromARGB(255, 174, 185, 184),
              child: Column(children: [
                const Text('Barba'),
                Image.asset(
                  'assets/images/barba.jpg',
                  height: 100.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                ),
                Text('R\$ ${valores[1].valor.toStringAsFixed(2)}'),
              ]),
            ),
            //CARD CORTE + BARBA
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5.0,
                    offset: Offset(0.0, 0.80),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              // color: Color.fromARGB(255, 174, 185, 184),
              child: Column(children: [
                const Text('Corte + Barba'),
                Image.asset(
                  'assets/images/cabelo+barba.jpg',
                  height: 100.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                ),
                Text('R\$ ${valores[2].valor.toStringAsFixed(2)}'),
              ]),
            ),
            // CARD COLORAÇÃO
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5.0,
                    offset: Offset(0.0, 0.80),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              // color: Color.fromARGB(255, 174, 185, 184),
              child: Column(children: [
                const Text('Coloração'),
                Flexible(
                  child: Image.asset(
                    'assets/images/coloracao.png',
                    height: 100.0,
                    // width: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Text('R\$ ${valores[3].valor.toStringAsFixed(2)}'),
              ]),
            ),
          ]),
    );
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
    return DropdownButtonFormField<String>(
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
        value: null,
        items: [
          for (var servico in tiposServicos) ...[
            DropdownMenuItem(value: servico.value, child: Text(servico.value))
          ]
        ],
        onChanged: (String? value) {
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
          _servico.nomeCliente = value!;
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
          _dateController.text = '${date.day}/${date.month}/${date.year}';
          dataTimeStamp =
              DateTime.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch);
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
          _timeController.text = '${newTime.hour}:${newTime.minute}';
          horaTimeStamp =
              DateTime.fromMillisecondsSinceEpoch(newTime.hour, isUtc: true);
        });
      }
    }
  }

  createElevationButtons() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              onPressed: () async {
                addService();
              },
              child: const Text('Agendar'),
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              onPressed: null,
              child: Text('Cancelar'),
            ),
          ),
        ),
      ],
    );
  }

  addService() {
    final service = Servico(
        nomeCliente: _nameController.text,
        data: dataTimeStamp!,
        hora: horaTimeStamp!,
        tipoServico: _dropdownValueService);

    _servicoDbHelper.insertService(service);
  }
}
