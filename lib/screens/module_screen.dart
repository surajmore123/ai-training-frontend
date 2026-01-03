import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/module/module_bloc.dart';
import '../bloc/module/module_event.dart';
import '../bloc/module/module_state.dart';
import '../repository/module_repository.dart';

class ModuleScreen extends StatelessWidget {
  final String topic;

  const ModuleScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ModuleBloc(ModuleRepository())
        ..add(FetchModule(topic)),
      child: Scaffold(
        appBar: AppBar(title: Text(topic)),
        body: BlocBuilder<ModuleBloc, ModuleState>(
          builder: (context, state) {
            if (state is ModuleLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ModuleLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Text(
                    state.content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ),
              );
            }

            if (state is ModuleFailure) {
              return Center(child: Text('Failed to load module'));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
