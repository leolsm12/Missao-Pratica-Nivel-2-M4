import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../classes/lugar.dart';

class LugarPage extends StatefulWidget {
  final Lugar lugar;
  const LugarPage({required this.lugar});

  @override
  _LugarPageState createState() => _LugarPageState();
}

class _LugarPageState extends State<LugarPage> {
  late int estrelas; // Use "late" para indicar que inicializaremos mais tarde

  @override
  void initState() {
    super.initState();
    estrelas = widget
        .lugar.estrelas; // Inicialize estrelas com o valor do objeto Lugar
  }

  // Método para fazer a chamada à API para atualizar as estrelas
  Future<void> _atualizarEstrelas() async {
    final response = await http.put(
      Uri.parse("http://192.168.100.114:8084/lugares/${widget.lugar.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'estrelas': estrelas + 1,
      }),
    );

    if (response.statusCode == 200) {
      // A atualização foi bem-sucedida
      setState(() {
        estrelas = estrelas + 1;
      });
    } else {
      // Trate o erro aqui, se necessário
      throw Exception('Falha ao atualizar estrelas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lugar.nome),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 240,
              child: PageView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  String foto;
                  if (index == 0) {
                    foto = widget.lugar.foto;
                  } else if (index == 1) {
                    foto = widget.lugar.foto1;
                  } else {
                    foto = widget.lugar.foto2;
                  }

                  return Image.asset(
                    foto,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            widget.lugar.nome,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          widget.lugar.localizacao,
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _atualizarEstrelas();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.red[500],
                        ),
                        Text(estrelas.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButtonColumn(
                  Theme.of(context).primaryColorLight,
                  Icons.call,
                  'CHAMAR',
                ),
                _buildButtonColumn(
                  Theme.of(context).primaryColorLight,
                  Icons.near_me,
                  'ROTA',
                ),
                _buildButtonColumn(
                  Theme.of(context).primaryColorLight,
                  Icons.share,
                  'COMPARTILHAR',
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(32),
              child: Text(
                widget.lugar.descricao,
                softWrap: true,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
