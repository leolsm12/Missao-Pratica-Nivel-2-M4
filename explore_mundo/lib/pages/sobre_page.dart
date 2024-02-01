import 'package:flutter/material.dart';
import '../classes/sobre.dart';

class SobreNosPage extends StatelessWidget {
  final SobreNos sobreNos = SobreNos(
    historia:
        'Nossa empresa foi fundada em 2024 com o objetivo de proporcionar experiências de viagem únicas e inesquecíveis. Desde então, temos nos dedicado a oferecer destinos incríveis, pacotes personalizados e atendimento excepcional aos nossos clientes.',
    motivacao:
        'Acreditamos que viajar é mais do que visitar lugares; é uma jornada de descobertas, aprendizado e enriquecimento pessoal. Queremos inspirar pessoas a explorar o mundo, criar memórias duradouras e aproveitar ao máximo cada momento em suas viagens.',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre Nós'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('História:'),
            SizedBox(height: 8.0),
            Text(sobreNos.historia),
            SizedBox(height: 16.0),
            Text('Motivação para Viajar:'),
            SizedBox(height: 8.0),
            Text(sobreNos.motivacao),
          ],
        ),
      ),
    );
  }
}
