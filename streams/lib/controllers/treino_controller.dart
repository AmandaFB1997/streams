import '../end_event.dart';
import '../exercicio_event.dart';
import '../start_event.dart';
import '../treino.dart';
import '../treino_event.dart';

class TreinoController {
  final List<Treino> treinoTimers;

  TreinoController({required this.treinoTimers});

  Stream<TreinoEvent> start() async* {
    yield StartEvent();

    for (Treino treino in treinoTimers) {
      for (int seconds = treino.seconds; seconds > 0; seconds--) {
        await Future.delayed(const Duration(seconds: 1));
        yield ExercicioEvent(treino: treino, now: seconds);
      }
    }
    yield EndEvent();
  }
}
