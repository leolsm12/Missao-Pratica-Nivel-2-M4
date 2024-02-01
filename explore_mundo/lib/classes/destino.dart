class Destino {
  final String nome;
  final String localizacao;
  final String pacote1preco;

  Destino({
    required this.nome,
    required this.localizacao,
    required this.pacote1preco,
  });

  factory Destino.fromJson(Map<String, dynamic> json) {
    return Destino(
      nome: json['nome'],
      localizacao: json['localizacao'],
      pacote1preco: json['pacote1preco'],
    );
  }
}
