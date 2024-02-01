import 'package:flutter/material.dart';
import '../classes/contato.dart';

class ContatoPage extends StatelessWidget {
  final Contato contato = Contato(
    email: 'contato@example.com',
    telefone: '(11) 1234-5678',
    paginaWeb: 'www.exemplo.com',
    endereco: 'Rua Exemplo, 123, Cidade, Estado',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('E-mail: ${contato.email}'),
            SizedBox(height: 8.0),
            Text('Telefone: ${contato.telefone}'),
            SizedBox(height: 8.0),
            Text('Página da Web: ${contato.paginaWeb}'),
            SizedBox(height: 8.0),
            Text('Endereço: ${contato.endereco}'),
          ],
        ),
      ),
    );
  }
}
