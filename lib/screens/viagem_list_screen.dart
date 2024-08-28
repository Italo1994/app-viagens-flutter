import 'package:app_viagens/repository/viagem_repository.dart';
import 'package:app_viagens/screens/editar_viagem.dart';
import 'package:app_viagens/services/viagem_service.dart';

import '../screens/homepage.dart';
import '../screens/viagem_list_screen.dart';

import 'package:flutter/material.dart';
import 'package:app_viagens/models/viagem.dart';

import '../widgets/viagem_card.dart';

class TelaListaDeViagens extends StatefulWidget {
  const TelaListaDeViagens({super.key});

  State<TelaListaDeViagens> createState() => _TelaListaDeViagensState();
}


class _TelaListaDeViagensState extends State<TelaListaDeViagens> {
  // passando um objeto da classe ViagemRepository para o serviço ViagemService
  final ViagemService _viagemService = ViagemService(ViagemRepository());

  int _indexSelecionadoPagina = 0;
  final List<Widget> _routes = [
    Homepage(),
    TelaListaDeViagens(),
  ];

  Future<List<Viagem>> _listarViagens() async {
    try {
      final viagens = await _viagemService.fetchViagens();
      
      return viagens;
    } catch(e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {

    void _paginaSelecionada(int index) {
      setState(() {
        _indexSelecionadoPagina = index;
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => _routes[_indexSelecionadoPagina])
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Align(child: Text('Sua lista de viagens'))
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 10.0),

            Expanded(
              child: FutureBuilder<dynamic>(
                future: _listarViagens(),
                builder: (context, snapshot) {
                  final viagens = snapshot.data!;

                  if(snapshot.hasData) {
                    return ListView.builder(
                      itemCount: viagens.length,
                      itemBuilder: (context, index) {
                        final viagem = viagens[index];
                        
                        return ListTile(
                          title: ViagemCard(viagem: viagem),
                          
                        );
                      }
                    );
                  } else {
                    if(snapshot.data.isEmpty) {
                      Center(child: Text('Nenhuma viagem cadastrada'));
                    }
                    return LinearProgressIndicator();
                  }
                }
              )
            )
          ],
        ),
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
