import 'package:flutter/material.dart';

import '../model/valor.dart';

class PageServico extends StatefulWidget {
  const PageServico({super.key});

  @override
  State<PageServico> createState() => _PageServicoState();
}

class _PageServicoState extends State<PageServico> {
  List<Valor> valores = Valor.values;

  @override
  Widget build(BuildContext context) {
    // checkEdit();
    return Column(
      children: [
        createGridView(),
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
}
