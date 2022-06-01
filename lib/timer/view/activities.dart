import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../timer.dart';

class Activities extends StatelessWidget {
  const Activities({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (state is TimerInitial) ...[
              FloatingActionButton(
                child: const Icon(Icons.play_arrow),
                onPressed: () =>
                    _callBack(TimerStarted(duration: state.duration), context),
              ),
            ],
            if (state is TimerRunInProgress) ...[
              FloatingActionButton(
                child: const Icon(Icons.pause),
                onPressed: () => _callBack(const TimerPaused(), context),
              ),
              FloatingActionButton(
                child: const Icon(Icons.replay),
                onPressed: () => _callBack(const TimerReset(), context),
              ),
            ],
            if (state is TimerRunPause) ...[
              FloatingActionButton(
                child: const Icon(Icons.play_arrow),
                onPressed: () => _callBack(const TimerResumed(), context),
              ),
              FloatingActionButton(
                child: const Icon(Icons.replay),
                onPressed: () => _callBack(const TimerReset(), context),
              ),
            ],
            if (state is TimerRunComplete) ...[
              FloatingActionButton(
                child: const Icon(Icons.replay),
                onPressed: () => _callBack(const TimerReset(), context),
              ),
            ]
          ],
        );
      },
    );
  }

  void _callBack(TimerEvent event, BuildContext context) {
    context.read<TimerBloc>().add(event);
  }
}
