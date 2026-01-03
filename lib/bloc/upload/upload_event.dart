abstract class UploadEvent {}

class UploadTextEvent extends UploadEvent {
  final String title;
  final String content;

  UploadTextEvent({required this.title, required this.content});
}

class UploadFileEvent extends UploadEvent {
  final String title;
  final String filePath;

  UploadFileEvent({required this.title, required this.filePath});
}
