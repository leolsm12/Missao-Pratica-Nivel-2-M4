import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'classes/lugar.dart';
import 'pages/home_page.dart';
import 'pages/destinos_page.dart';
import 'pages/pacotes_page.dart';
import 'pages/contato_page.dart';
import 'pages/sobre_page.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TabBarDemo());
  Future<List<Lugar>> fetchLugares() async {
    final response =
        await http.get(Uri.parse('http://192.168.100.114:8084/lugares'));
    if (response.statusCode == 200) {
      List<dynamic> lugaresJson = jsonDecode(response.body);
      List<Lugar> lugares =
          lugaresJson.map((json) => Lugar.fromJson(json)).toList();

      // Adicione os prints para verificar os dados
      lugares.forEach((lugar) {
        print('Nome: ${lugar.nome}');
        print('Localização: ${lugar.localizacao}');
        print('Preço Mais Barato: ${lugar.preco}');
        print('---------------------');
      });

      return lugares;
    } else {
      throw Exception('Failed to load lugares');
    }
  }
}

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        // Cor de fundo do aplicativo
        scaffoldBackgroundColor: Colors.grey[900],

        // Cor de fundo da AppBar
        appBarTheme: AppBarTheme(
          color: Colors.grey[800],
        ),

        // Cor do indicador da TabBar
        tabBarTheme: TabBarTheme(
          indicator: BoxDecoration(),
        ),

        // Cor do texto da AppBar
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 20.0, // Tamanho do texto
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.explore)),
                Tab(icon: Icon(Icons.card_travel)),
                Tab(icon: Icon(Icons.contact_phone)),
                Tab(icon: Icon(Icons.info_outline)),
              ],
            ),
            title: const Text('Explore Mundo'),
          ),
          body: TabBarView(
            children: [
              HomePage(),
              DestinosPage(),
              PacotesPage(),
              ContatoPage(),
              SobreNosPage(),
            ],
          ),
        ),
      ),
    );
  }
}
