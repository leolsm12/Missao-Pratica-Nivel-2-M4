import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'lugar_page.dart';
import '../classes/lugar.dart'; // Certifique-se de importar a classe Lugar

class DestinosPage extends StatefulWidget {
  @override
  _DestinosPageState createState() => _DestinosPageState();
}

class _DestinosPageState extends State<DestinosPage> {
  late Future<List<Lugar>> futureLugares; // Altere o tipo para List<Lugar>

  @override
  void initState() {
    super.initState();
    futureLugares = fetchLugares();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destinos'),
      ),
      body: FutureBuilder<List<Lugar>>(
        // Altere o tipo para List<Lugar>
        future: futureLugares,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<Lugar> lugares = snapshot.data!;
            return ListView.builder(
              itemCount: lugares.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(lugares[index].nome),
                  subtitle: Text('Local: ${lugares[index].localizacao}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LugarPage(lugar: lugares[index]),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
