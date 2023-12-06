import 'package:flutter/material.dart';
import 'controllers/treino_controller.dart';
import 'count_down.dart';
import 'end_event.dart';
import 'exercicio_event.dart';
import 'start_event.dart';
import 'treino.dart';
import 'treino_event.dart';

class TreinoPage extends StatefulWidget {
  const TreinoPage({super.key});

  @override
  State<TreinoPage> createState() => _TreinoPageState();
}

class _TreinoPageState extends State<TreinoPage> {
  bool showStartButton = true;
  late final TreinoController controller;
  late final Stream<TreinoEvent> treinoStream;

  start() {
    controller = TreinoController(treinoTimers: [
      Treino(seconds: 10, name: 'Abdominal'),
      Treino(seconds: 5, name: 'Descanso'),
      Treino(seconds: 10, name: 'Prancha'),
    ]);
    setState(() {
      treinoStream = controller.start();
      showStartButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: showStartButton
              ? ElevatedButton(
                  onPressed: start,
                  child: const Text('Iniciar Treino'),
                )
              : StreamBuilder(
                  stream: treinoStream,
                  builder: (context, AsyncSnapshot<TreinoEvent> snapshot) {
                    TreinoEvent? event = snapshot.data;

                    if (snapshot.hasError) {
                      return const Text('Erro ao carregar o treino');
                    } else if (event is StartEvent) {
                      return const Text('Inciiando o Treino ...');
                    } else if (event is EndEvent) {
                    } else if (event is ExercicioEvent) {
                      return CountDown(event: event);
                    }
                    return Container();
                  })),
    );
  }
}
