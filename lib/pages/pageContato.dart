import 'package:flutter/material.dart';

import '../widgets/googleMap.dart';

class PageContato extends StatefulWidget {
  const PageContato({super.key});

  @override
  State<PageContato> createState() => _PageContatoState();
}

class _PageContatoState extends State<PageContato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: const Color(0xff191B1A),
        title: const Text('Contato'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 120,
                    width: 120,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.access_time,
                  color: Color(0xffB1672E),
                ),
                const SizedBox(width: 16, height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Horário de atendimento',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10, height: 7),
                    Text('Segunda - Sábado: 09h00 as 19h00',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ],
                )
              ],
            ),
          ),
          // EMAIL
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.email_outlined,
                  color: Color(0xffB1672E),
                ),
                const SizedBox(width: 16, height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'E-mail',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10, height: 7),
                    Text('barbearia.b@gmail.com',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ],
                )
              ],
            ),
          ),
          // WHATSAPP
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 110),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/whatsapp.png'),
                const SizedBox(width: 16, height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'WhatsApp',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10, height: 7),
                    Text('(45) 99999-9999)',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 60),
          // ENDEREÇO
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.map_outlined,
                color: Color(0xffB1672E),
              ),
              SizedBox(width: 10),
              Text(
                'Como chegar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Encontre nosso estabelecimento no mapa',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 200,
            width: 320,
            child: const PageMap(),
          )
        ],
      ),
    );
  }

  void pageMap() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => const PageMap()));
  }
}
