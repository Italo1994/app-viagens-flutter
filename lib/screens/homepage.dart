import 'package:app_viagens/models/viagem.dart';
import 'package:app_viagens/screens/cadastrar_viagem.dart';
import 'package:app_viagens/screens/viagem_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  //final String title;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  /*
  late Future<List<Viagem>> imgViagens;
  String url = "http://localhost:3000/viagens";
  */

  int _indexSelecionadoPagina = 0;
  final List<Widget> _routes = [
    Homepage(),
    TelaListaDeViagens(),
  ];

/*
  Future<List<Viagem>> fetchImagensCarousel() async {
      final response = await http.get(
        Uri.parse(
          url,
        )
      );

      if(response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        List<Viagem> imgViagensCarousel = data
        .where((json) => json['img'] != null)
        .take(2)
        .map((json) => Viagem.fromJson(json))
        .toList();

        return imgViagensCarousel;
      } else {
        throw Exception('Falha ao carregar imagens');
      }
  }

  @override
  void initState() {
    super.initState();
    imgViagens = fetchImagensCarousel();
  }

*/
  
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
        title: Align(child: Text('Diário de viagens'))
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 10.0),

/*
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

*/
            
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
                            MaterialPageRoute(builder: (context) => PaginaCadastrarViagem()),
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

        ],
        currentIndex: _indexSelecionadoPagina,
        onTap: _paginaSelecionada,
      )
    );
  }
}