import 'package:app_viagens/repository/viagem_repository.dart';
import 'package:app_viagens/screens/homepage.dart';
import 'package:app_viagens/services/viagem_service.dart';
import 'package:flutter/material.dart';
import '../models/viagem.dart';

class PaginaEditarViagem extends StatefulWidget {
  final Viagem viagem;

  const PaginaEditarViagem({super.key, required this.viagem});

  @override
  State<PaginaEditarViagem> createState() => _PaginaEditarViagemState();
}

class _PaginaEditarViagemState extends State<PaginaEditarViagem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ViagemService _viagemService = ViagemService(ViagemRepository());

  late String _destino;
  late int _avaliacao;
  late String _img;
  late String _detalhes;

  @override
  void initState() {
    super.initState();
    _destino = widget.viagem.destino;
    _avaliacao = widget.viagem.avaliacao;
    
    _detalhes = widget.viagem.detalhes;
  }

  void _atualizarViagem() async {
    final viagemAtualizada = Viagem(
      id: widget.viagem.id,
      destino: _destino,
      dataCadastro: widget.viagem.dataCadastro,
      detalhes: _detalhes,
      avaliacao: _avaliacao,
      img: widget.viagem.img,
    );

    //print(viagemAtualizada.id);

    try {
      await _viagemService.fetchEditarViagem(viagemAtualizada);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Viagem atualizada com sucesso')),
      );
      Navigator.popUntil(context, ModalRoute.withName('/'));
    } catch(e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Atualizar viagem'),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Align(child: Text('Atualizar as informações sobre a viagem')),
                  SizedBox(height: 15.0),
                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 50.0,
                            width: double.infinity,
                            child: TextFormField(
                              initialValue: _destino,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Local da viagem',
                              ),
                              
                              onChanged: (value) => _destino = value,
                            ),
                          ),
                          SizedBox(height: 10.0),

                          SizedBox(
                            height: 50.0,
                            width: double.infinity,
                            child: TextFormField(
                              initialValue: _avaliacao.toString(),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Nota para a viagem entre 0 e 10',
                              ),

                              onChanged: (value) => _avaliacao = int.parse(value),
                            ),
                          ),
                          SizedBox(height: 10.0),

                          SizedBox(
                            height: 200.0,
                            width: double.infinity,
                            child: TextField(
                              maxLines: 5,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Detalhes da viagem',
                              ),
                              
                              onChanged: (value) => _detalhes = value,
                            ),
                          ),
                          SizedBox(height: 10.0),

                          ElevatedButton(
                            child: const Text('Atualizar'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _atualizarViagem();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ],
        ),
      ),
    );
  }
}