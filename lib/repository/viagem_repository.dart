import '../models/viagem.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class ViagemRepository {
  final String url = "http://localhost:3000/viagens";

  Future<void> criarViagem(Viagem viagem) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(viagem.toJson()),
    );

    if(response.statusCode != 201) {
      throw Exception("Não foi possível criar a viagem");
    } else {
      Viagem.quantViagens++;
    }
  }

  Future<List<Viagem>> buscarViagens() async {
    try {
      final res = await http.get( Uri.parse(url,) );
      List<Viagem> viagensApp = [];

      if(res.statusCode == 200) {
        final data = jsonDecode(res.body);
        
        if(data is List) {
          final List<dynamic> listaViagens = data;
          List<Viagem> viagens = listaViagens.map((viagem) => Viagem.fromJson(viagem) ).toList();
          viagensApp = viagens;
        } else if(data is Map) {
          final Map<dynamic, dynamic> listaViagens = data;
        }
       
        return viagensApp;
      } else {
        throw "Erro ao buscar viagens";
      }
      
    } catch(exception) {
      print("Exceção na requisição");
      throw exception.toString();
    }
  }

  Future<Viagem> buscarViagemById(String id) async {
    try {
      final res = await http.get(
        Uri.parse(
          '$url/$id'
        )
      );

      if(res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data;
      } else {
        throw "Erro ao buscar viagem";
      }
    } catch(e) {
      throw e.toString();
    }
  }

  Future<void> editarViagem(Viagem viagem) async {
    print(viagem.id);
    final response = await http.put(
      Uri.parse(
        '$url/${viagem.id}',
      ),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(viagem.toJson()),
    );

    if(response.statusCode != 200) {
      throw Exception("Não foi possível editar a viagem");
    }
  }

  Future<void> deletarViagem(String id) async {
    final response = await http.delete(
      Uri.parse(
        '$url/$id'
      ),
    );
    
    if(response.statusCode != 200) {
      throw Exception("Não foi possível deletar a viagem");
    }
  }
}