import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../classes/pacotes.dart';

class PacotesPage extends StatefulWidget {
  @override
  _PacotesPageState createState() => _PacotesPageState();
}

class _PacotesPageState extends State<PacotesPage> {
  double _precoMinimo = 0.0;
  double _precoMaximo = 20000.0;

  late Future<List<Pacote>> futurePacotes;

  @override
  void initState() {
    super.initState();
    futurePacotes = fetchPacotes();
  }

  Future<List<Pacote>> fetchPacotes() async {
    final response =
        await http.get(Uri.parse('http://192.168.100.114:8084/lugares'));
    if (response.statusCode == 200) {
      List<dynamic> pacotesJson = jsonDecode(response.body);
      List<Pacote> pacotes =
          pacotesJson.map((json) => Pacote.fromJson(json)).toList();

      // Filtrar os pacotes com base nos preços
      List<Pacote> pacotesFiltrados = pacotes.where((pacote) {
        return pacote.preco >= _precoMinimo && pacote.preco <= _precoMaximo;
      }).toList();

      return pacotesFiltrados;
    } else {
      throw Exception('Failed to load pacotes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacotes'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Filtrar por preço:'),
              Slider(
                value: _precoMinimo,
                min: 0.0,
                max: _precoMaximo,
                onChanged: (value) {
                  setState(() {
                    _precoMinimo = value;
                  });
                },
              ),
              Text(_precoMinimo.toStringAsFixed(2)),
              Text('até'),
              Text(_precoMaximo.toStringAsFixed(2)),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Pacote>>(
              future: futurePacotes,
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
                  List<Pacote> pacotesFiltrados = snapshot.data!;
                  return ListView.builder(
                    itemCount: pacotesFiltrados.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(pacotesFiltrados[index].nome),
                        subtitle: Text(
                            'Destino: ${pacotesFiltrados[index].localizacao}'),
                        trailing: Text(
                            'Preço: \$${pacotesFiltrados[index].preco.toStringAsFixed(2)}'),
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
          ),
        ],
      ),
    );
  }
}
