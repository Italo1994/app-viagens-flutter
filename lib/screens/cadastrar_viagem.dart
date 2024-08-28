import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:app_viagens/repository/viagem_repository.dart';
import 'package:app_viagens/services/viagem_service.dart';
import 'package:flutter/material.dart';
import '../models/viagem.dart';
import '../screens/homepage.dart';
import '../screens/viagem_list_screen.dart';

import '../database/database.dart' as database;

class PaginaCadastrarViagem extends StatefulWidget {
  const PaginaCadastrarViagem({super.key});

  @override
  State<PaginaCadastrarViagem> createState() => _PaginaCadastrarViagemState();
}

class _PaginaCadastrarViagemState extends State<PaginaCadastrarViagem> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ViagemService _viagemService = ViagemService(ViagemRepository());

  // configuração das rotas do BottomNavigationBar
  int _indexSelecionadoPagina = 0;
  final List<Widget> _routes = [
    Homepage(),
    TelaListaDeViagens(),
  ];
  
  String _destino = "";
  String _detalhes = "";
  String _img = "";
  int _avaliacao = 0;

  void _cadastrarViagem() async {
    
    final viagem = Viagem(
      id: Viagem.quantViagens.toString(),
      destino: _destino,
      dataCadastro: DateTime.now().toString(),
      detalhes: _detalhes,
      img: _img,
      avaliacao: _avaliacao,
    );
    
    try {
      await _viagemService.fetchCriarViagem(viagem);

      Navigator.pop(context);
    } catch(e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    // navegar entre as opções de páginas da BottomNavigationBar
    void _paginaSelecionada(int index) {
      setState(() {
        _indexSelecionadoPagina = index; // atualiza o index com base na opção clicada
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _routes[_indexSelecionadoPagina])
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Cadastro de viagem'),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children:[
            SizedBox(height: 10.0),

            Container(
              width: double.infinity,
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Align(child: Text('Preencher as informações sobre a viagem'),),
                  SizedBox(height: 15.0,),

                  Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 50.0,
                            width: double.infinity,
                            child:
                              TextFormField(
                                
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Local da viagem'
                                ),
                                validator: (String? value) {
                                  if(value == null || value.isEmpty) {
                                    return 'Por favor, informe o local da viagem';
                                  }
                                  return null;
                                },
                                onChanged: (value) => _destino = value,
                              ),
                          ),
                          SizedBox(height: 10.0,),

                          SizedBox(
                            height: 50.0,
                            width: double.infinity,
                            child:
                              TextFormField(
                                
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nota para a viagem entre 0 e 10',
                                ),
                                validator: (String? value) {
                                  if(value == null || value.isEmpty) {
                                    return 'Por favor, informe uma nota para a viagem';
                                  }
                                  return null;
                                },
                                onChanged: (value) => _avaliacao = int.parse(value),
                              ),
                          ),
                          SizedBox(height: 10.0,),

                          SizedBox(
                            height: 200.0,
                            width: double.infinity,
                            child:
                              TextField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Detalhes da viagem',
                                ),
                                onChanged: (value) => _detalhes = value,
                              )
                          ),
                          

                          SizedBox(
                            height: 20.0,
                            width: 120.0,
                            child: ElevatedButton(
                              child: const Text('Cadastrar'),
                              onPressed: () {
                                if(_formKey.currentState!.validate()) {
                                  _cadastrarViagem();

                                  //await database.LocalDatabase().gravarDadosLocalmente(dadosJson: viagens);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Viagem cadastrada')),
                                  );
                                }
                              }
                            ),
                          )
                        ]
                      )
                    ),
                  ),
                ],
              ),
            )
          ]
        )
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore),
            label: 'Viagens',
          ),

        ],
        currentIndex: _indexSelecionadoPagina,
        onTap: _paginaSelecionada,
      )
    );
  }
}