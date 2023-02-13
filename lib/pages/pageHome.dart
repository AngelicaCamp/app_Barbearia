import 'package:app_barbearia/pages/pageAgendamento.dart';
import 'package:app_barbearia/pages/pageContato.dart';
import 'package:app_barbearia/pages/pageServico.dart';
import 'package:flutter/material.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
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
          backgroundColor: const Color(0xff191B1A),
          title: Image.asset(
            'assets/images/logo.png',
            height: 40.0,
            width: 50.0,
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
              icon: const Icon(Icons.info, color: Color(0xffFE7C3F)),
            ),
          ],
        ),
        body: Column(
          children: const [
            TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'SERVIÇOS'),
                Tab(text: 'AGENDAMENTOS'),
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
