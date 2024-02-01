class Lugar {
  final int id;
  final String foto;
  final String foto1;
  final String foto2;
  final String nome;
  final String localizacao;
  final String telefone;
  final int estrelas;
  final String descricao;
  final String pacote1;
  final String pacote2;
  final String pacote3;
  final int preco;

  Lugar({
    required this.id,
    required this.foto,
    required this.foto1,
    required this.foto2,
    required this.nome,
    required this.localizacao,
    required this.telefone,
    required this.estrelas,
    required this.descricao,
    required this.pacote1,
    required this.pacote2,
    required this.pacote3,
    required this.preco,
  });

  factory Lugar.fromJson(Map<String, dynamic> json) {
    return Lugar(
      id: json['id'] as int,
      foto: json['foto'] as String? ?? '',
      foto1: json['foto1'] as String? ?? '',
      foto2: json['foto2'] as String? ?? '',
      nome: json['nome'] as String? ?? '',
      localizacao: json['localizacao'] as String? ?? '',
      telefone: json['telefone'] as String? ?? '',
      estrelas: json['estrelas'] as int? ?? 0,
      descricao: json['descricao'] as String? ?? '',
      pacote1: json['pacote1'] as String? ?? '',
      pacote2: json['pacote2'] as String? ?? '',
      pacote3: json['pacote3'] as String? ?? '',
      preco: json['preco'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'foto': foto,
      'fotoAdicional1': foto1,
      'fotoAdicional2': foto2,
      'nome': nome,
      'localizacao': localizacao,
      'telefone': telefone,
      'estrelas': estrelas,
      'descricao': descricao,
      'pacote1': pacote1,
      'pacote2': pacote2,
      'pacote3': pacote3,
      'preco': preco,
    };
  }

  @override
  String toString() {
    return 'Lugar{id: $id, nome: $nome, localizacao: $localizacao}';
  }
}
