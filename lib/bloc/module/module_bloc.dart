import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import 'module_event.dart';
import 'module_state.dart';
import '../../repository/module_repository.dart';

class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  final ModuleRepository repository;

  ModuleBloc(this.repository) : super(ModuleInitial()) {
    on<FetchModule>(_onFetchModule);
  }

  Future<void> _onFetchModule(
    FetchModule event,
    Emitter<ModuleState> emit,
  ) async {
    emit(ModuleLoading());

    try {
      debugPrint('📄 Fetching module: ${event.topic}');

      final data = await repository.fetchModule(event.topic);

      debugPrint('✅ Module loaded');

      emit(
        ModuleLoaded(
          topic: data['topic'],
          content: data['content'],
        ),
      );
    } catch (e) {
      debugPrint('❌ Module load failed');
      debugPrint('🔥 Error: $e');

      emit(ModuleFailure(e.toString()));
    }
  }
}
