import 'package:flutter_bloc/flutter_bloc.dart';
import 'process_ai_event.dart';
import 'process_ai_state.dart';
import '../../repository/process_ai_repository.dart';
import 'package:flutter/foundation.dart';

class ProcessAIBloc extends Bloc<ProcessAIEvent, ProcessAIState> {
  final ProcessAIRepository repository;

  ProcessAIBloc(this.repository) : super(ProcessAIInitial()) {
    on<StartProcessAI>(_onStartProcessAI);
  }

  Future<void> _onStartProcessAI(
    StartProcessAI event,
    Emitter<ProcessAIState> emit,
  ) async {
    emit(ProcessAILoading());

    try {
      debugPrint(' AI processing started');

      final msg = await repository.processAI();

      debugPrint(' AI processing success');
      debugPrint(' API Response: $msg');

      emit(ProcessAISuccess(msg));
    } catch (e) {
      debugPrint(' AI processing failed');
      debugPrint(' Error: $e');

      emit(ProcessAIFailure(e.toString()));
    }
  }
}
