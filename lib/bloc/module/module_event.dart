abstract class ModuleEvent {}

class FetchModule extends ModuleEvent {
  final String topic;
  FetchModule(this.topic);
}
