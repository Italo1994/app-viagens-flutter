class Viagem {
  String id = "1";
  String destino = "";
  String dataCadastro = "";
  String detalhes = "";
  String img = "";
  int avaliacao = 0;

  static int quantViagens = 0;

  Viagem({
    required this.id,
    required this.destino, 
    required dataCadastro,  
    required detalhes, 
    required img, 
    required avaliacao,
  });

  factory Viagem.fromJson(Map<String, dynamic> json) {
    return Viagem(
      id: json['id'],
      destino: json['destino'],
      dataCadastro: json['dataCadastro'],
      detalhes: json['detalhes'],
      img: json['img'],
      avaliacao: json['avaliacao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'destino': destino,
      'dataCadastro': dataCadastro,
      'detalhes': detalhes,
      'img': img,
      'avaliacao': avaliacao,
    };
  }
}