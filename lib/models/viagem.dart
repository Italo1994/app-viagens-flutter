import 'package:json_annotation/json_annotation.dart';

class Viagem {
  String id = "1";
  String destino = "";
  String dataCadastro = "";
  String detalhes = "";
  String? img = "";
  int avaliacao = 0;

  static int quantViagens = 0;

  Viagem({
    required this.id,
    required this.destino, 
    required this.dataCadastro,  
    required this.detalhes, 
    this.img, 
    required this.avaliacao,
  });

  factory Viagem.fromJson(Map<dynamic, dynamic> viagem) {
    return Viagem(
      id: viagem['id'],
      destino: viagem['destino'],
      dataCadastro: viagem['dataCadastro'],
      detalhes: viagem['detalhes'],
      img: viagem['img'],
      avaliacao: viagem['avaliacao'],
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