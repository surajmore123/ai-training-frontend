abstract class ProcessAIState {}

class ProcessAIInitial extends ProcessAIState {}

class ProcessAILoading extends ProcessAIState {}

class ProcessAISuccess extends ProcessAIState {
  final String message;
  ProcessAISuccess(this.message);
}

class ProcessAIFailure extends ProcessAIState {
  final String error;
  ProcessAIFailure(this.error);
}
