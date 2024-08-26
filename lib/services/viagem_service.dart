import '../models/viagem.dart';
import '../repository/viagem_repository.dart';

class ViagemService {
   final ViagemRepository repository;

   ViagemService(this.repository);

   Future<List<Viagem>> fetchViagens() async {
    return await repository.buscarViagens();
   }

   Future<Viagem> fetchViagemById(String id) async {
    return await repository.buscarViagemById(id);
   }

   Future<void> fetchCriarViagem(Viagem viagem) async {
    return await repository.criarViagem(viagem);
   }

   Future<void> fetchEditarViagem(Viagem viagem) async {
    return await repository.editarViagem(viagem);
   }

   Future<void> fetchDeletarViagem(String id) async {
    return await repository.deletarViagem(id);
   }
}