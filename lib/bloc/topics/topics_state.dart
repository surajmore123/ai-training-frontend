abstract class TopicsState {}

class TopicsInitial extends TopicsState {}

class TopicsLoading extends TopicsState {}

class TopicsLoaded extends TopicsState {
  final List<dynamic> topics;
  TopicsLoaded(this.topics);
}

class TopicsFailure extends TopicsState {
  final String error;
  TopicsFailure(this.error);
}
