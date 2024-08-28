import 'package:app_viagens/repository/viagem_repository.dart';
import 'package:app_viagens/screens/editar_viagem.dart';
import 'package:flutter/material.dart';
import '../models/viagem.dart';
import '../services/viagem_service.dart';

class ViagemCard extends StatefulWidget {
  final Viagem viagem;

  const ViagemCard({super.key, required this.viagem});

  @override
  State<ViagemCard> createState() => _ViagemCardState();
}

class _ViagemCardState extends State<ViagemCard> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    width: 70.0,
    child: 
    Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Local: ${widget.viagem.destino}'),
                SizedBox(height: 4.0,),
                Text('Data de cadastro: ${widget.viagem.dataCadastro}'),
                SizedBox(height: 4.0,),
                Text('Detalhes: ${widget.viagem.detalhes}'),
                SizedBox(height: 4.0),
                Text('Avaliação: ${widget.viagem.avaliacao}'),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                TextButton(
                  onPressed: () {

                  },
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaginaEditarViagem(viagem: widget.viagem))
                      );
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Editar'),
                  )
                ),
                TextButton(
                  onPressed: () {
                    
                  },
                  child: TextButton.icon(
                    onPressed: () async {
                      try {
                        ViagemService viagemService = ViagemService(ViagemRepository());
                        await viagemService.fetchDeletarViagem(widget.viagem.id);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Viagem excluída da lista')),
                        );
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      } catch(e) {
                        throw Exception(e.toString());
                      }
                    },
                    icon: Icon(Icons.delete),
                    label: Text('Excluir'),
                  )
                )
                  ]
                ),
              ],
            ),
          )
        ],
      ),
    ),
    );
  }
}