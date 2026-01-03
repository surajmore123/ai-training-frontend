abstract class ModuleState {}

class ModuleInitial extends ModuleState {}

class ModuleLoading extends ModuleState {}

class ModuleLoaded extends ModuleState {
  final String topic;
  final String content;

  ModuleLoaded({required this.topic, required this.content});
}

class ModuleFailure extends ModuleState {
  final String error;
  ModuleFailure(this.error);
}
