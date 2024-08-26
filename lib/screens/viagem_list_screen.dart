/*

import 'package:app_viagens/repository/viagem_repository.dart';
import 'package:app_viagens/services/viagem_service.dart';
import 'package:flutter/material.dart';

class TelaListaDeViagens extends StatefulWidget {
  const TelaListaDeViagens({super.key});

  State<TelaListaDeViagens> createState() => _TelaListaDeViagensState();
}

class _TelaListaDeViagensState extends State<TelaListaDeViagens> {
  // passando um objeto da classe ViagemRepository para o serviço ViagemService
  final ViagemService viagemService = ViagemService(ViagemRepository());

  @override
  Widget build(BuildContext context) {
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

            Container(
              width: double.infinity,
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                      FutureBuilder(
                        future: imgViagens,
                        builder: (context, snapshot) {
                          
                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } 
                          else if(snapshot.hasData) {
                            final imagens = snapshot.data!;
                            return CarouselSlider(
                                    options: CarouselOptions(
                                    height: 250.0,
                                    autoPlay: true,
                                    ),
                                items: imagens.map((image) { 
                                  
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration: BoxDecoration(
                                        color: Colors.green
                                        ),
                                        child: Image.network(
                                          //'${url}/${image.id}${image.img}',
                                          '',
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }
                                  );
                                }).toList()
                            );
                          } 
                          else if(snapshot.hasError) {
                            return Text('As imagens não foram carregadas');
                          } else {
                            return Text('Não há imagens a serem carregadas');
                          }
                        }
                      ),
                      ]
                    ),
                    
                  ),
                ],
              ),
            ),
            
            Container(
              child: SizedBox(
                width: double.infinity,
                height: 150.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Deseja Cadastrar uma viagem?"),
                      SizedBox(height: 20.0,),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PaginaAdicionarEditar()),
                          );
                        },
                        child: Text('CADASTRAR VIAGEM'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                      )
                    ],
                  )
                ),
              )
            ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Informações',
          )
        ]
      )
    );
  }
}

*/