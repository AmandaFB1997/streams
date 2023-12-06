import 'treino.dart';
import 'treino_event.dart';

class ExercicioEvent implements TreinoEvent {
  final Treino treino;
  final int now;
  ExercicioEvent({required this.treino, required this.now});
}
