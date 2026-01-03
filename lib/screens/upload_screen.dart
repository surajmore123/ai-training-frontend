import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/upload/upload_bloc.dart';
import '../bloc/upload/upload_event.dart';
import '../bloc/upload/upload_state.dart';
import '../repository/upload_repository.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UploadBloc(UploadRepository()),
      child: Scaffold(
        body: BlocConsumer<UploadBloc, UploadState>(
          listener: (context, state) {
            if (state is UploadSuccess) {
              SnackBar(
                content: const Text('✅ Meeting notes uploaded successfully'),
                backgroundColor: Colors.green,
              );

              Navigator.pushNamed(context, '/topics');
            }

            if (state is UploadFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            return _buildUI(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildUI(BuildContext context, UploadState state) {
    return Center(
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(24),
        child: Container(
          width: 650,
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'AI Training Module Generator',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Convert recurring meeting notes into structured training using AI',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 32),

              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Meeting Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: contentController,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Paste meeting notes (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              OutlinedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload .txt file'),
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['txt'],
                    withData: true,
                  );

                  if (result == null) return;

                  final Uint8List? fileBytes = result.files.single.bytes;
                  final String fileName = result.files.single.name;

                  if (fileBytes == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Unable to read file')),
                    );
                    return;
                  }

                  final String fileContent = utf8.decode(fileBytes);

                  if (titleController.text.isEmpty) {
                    titleController.text = fileName.replaceAll('.txt', '');
                  }

                  final title = titleController.text.trim();
                  final content = fileContent.trim();

                  // DEBUG LOGS
                  debugPrint('📄 Upload Source: FILE');
                  debugPrint('📌 Title: $title');
                  debugPrint('📝 Content length: ${content.length}');

                  context.read<UploadBloc>().add(
                    UploadTextEvent(title: title, content: content),
                  );
                },
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.auto_awesome),
                  label:
                      state is UploadLoading
                          ? const Text('Uploading...')
                          : const Text('Generate Training Modules'),
                  onPressed:
                      state is UploadLoading
                          ? null
                          : () {
                            final title = titleController.text.trim();
                            final content = contentController.text.trim();

                            if (title.isEmpty || content.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Title and content are required',
                                  ),
                                ),
                              );
                              return;
                            }

                            // DEBUG LOGS
                            debugPrint('⌨️ Upload Source: MANUAL TEXT');
                            debugPrint('📌 Title: $title');
                            debugPrint('📝 Content length: ${content.length}');

                            context.read<UploadBloc>().add(
                              UploadTextEvent(title: title, content: content),
                            );
                          },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
