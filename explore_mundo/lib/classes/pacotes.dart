class Pacote {
  final String nome;
  final String pacote1;
  final String pacote1preco;
  final String pacote2;
  final String pacote2preco;
  final String pacote3;
  final String pacote3preco;
  final int preco;
  final String localizacao;

  Pacote({
    required this.nome,
    required this.pacote1,
    required this.pacote1preco,
    required this.pacote2,
    required this.pacote2preco,
    required this.pacote3,
    required this.pacote3preco,
    required this.preco,
    required this.localizacao,
  });

  factory Pacote.fromJson(Map<String, dynamic> json) {
    return Pacote(
      nome: json['nome'],
      pacote1: json['pacote1'],
      pacote1preco: json['pacote1preco'],
      pacote2: json['pacote2'],
      pacote2preco: json['pacote2preco'],
      pacote3: json['pacote3'],
      pacote3preco: json['pacote3preco'],
      preco: json['preco'],
      localizacao: json['localizacao'] as String? ?? '',
    );
  }
}
