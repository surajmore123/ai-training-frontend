import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'upload_event.dart';
import 'upload_state.dart';
import '../../repository/upload_repository.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UploadRepository repository;

  UploadBloc(this.repository) : super(UploadInitial()) {
    on<UploadTextEvent>(_onUploadText);
  }

  Future<void> _onUploadText(
    UploadTextEvent event,
    Emitter<UploadState> emit,
  ) async {
    emit(UploadLoading());

    try {
     
      debugPrint('Upload started');
      debugPrint('Title: ${event.title}');
      debugPrint('Content length: ${event.content.length}');

      final msg = await repository.uploadText(
        title: event.title,
        content: event.content,
      );


      debugPrint(' API upload success');
      debugPrint(' API Response: $msg');

      emit(UploadSuccess(msg));
    } catch (e) {

      debugPrint(' API upload failed');
      debugPrint(' Error: $e');

      emit(UploadFailure(e.toString()));
    }
  }
}
