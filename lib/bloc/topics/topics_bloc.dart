import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

import 'topics_event.dart';
import 'topics_state.dart';
import '../../repository/topics_repository.dart';

class TopicsBloc extends Bloc<TopicsEvent, TopicsState> {
  final TopicsRepository repository;

  TopicsBloc(this.repository) : super(TopicsInitial()) {
    on<FetchTopics>(_onFetchTopics);
  }

  Future<void> _onFetchTopics(
    FetchTopics event,
    Emitter<TopicsState> emit,
  ) async {
    emit(TopicsLoading());

    try {
      debugPrint('📚 Fetching topics from API');

      final topics = await repository.fetchTopics();

      debugPrint('✅ Topics fetched successfully');
      debugPrint('📦 Topics count: ${topics.length}');

      emit(TopicsLoaded(topics));
    } catch (e) {
      debugPrint('❌ Failed to fetch topics');
      debugPrint('🔥 Error: $e');

      emit(TopicsFailure(e.toString()));
    }
  }
}
