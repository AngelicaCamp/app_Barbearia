import 'package:app_barbearia/pages/pageAgendamento.dart';
import 'package:app_barbearia/pages/pageContato.dart';
import 'package:app_barbearia/pages/pageServico.dart';
import 'package:flutter/material.dart';

import '../model/servico.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  Servico? servico;

  @override
  Widget build(BuildContext context) {
    return createDefaultTabController();
  }

  createDefaultTabController() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: const Color(0xff191B1A),
          title: Image.asset(
            'assets/images/logo.png',
            height: 70.0,
            width: 70.0,
            fit: BoxFit.cover,
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  pageContato();
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              },
              icon: const Icon(Icons.contact_page,
                  color: Color(0xffFE7C3F), size: 30),
            ),
          ],
        ),
        body: Column(
          children: const [
            TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'SERVIÇOS'),
                Tab(text: 'AGENDAMENTO'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PageServico(),
                  PageAgendamento(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void pageContato() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const PageContato()));
  }
}
