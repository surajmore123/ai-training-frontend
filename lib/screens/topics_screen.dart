import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/bloc/process_api/process_ai_bloc.dart';
import 'package:training/bloc/process_api/process_ai_event.dart';
import 'package:training/bloc/process_api/process_ai_state.dart';
import 'package:training/screens/module_screen.dart';

import '../repository/process_ai_repository.dart';


import 'package:training/bloc/topics/topics_bloc.dart';
import 'package:training/bloc/topics/topics_event.dart';
import 'package:training/bloc/topics/topics_state.dart';
import '../repository/topics_repository.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProcessAIBloc(ProcessAIRepository()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Generated Training Topics')),
        body: BlocBuilder<ProcessAIBloc, ProcessAIState>(
          builder: (context, aiState) {
      
            if (aiState is ProcessAIInitial) {
              context.read<ProcessAIBloc>().add(StartProcessAI());
              return const _LoadingView(
                text: 'Generating training modules using AI...',
              );
            }

            if (aiState is ProcessAILoading) {
              return const _LoadingView(
                text: 'Generating training modules using AI...',
              );
            }

       
            if (aiState is ProcessAISuccess) {
              return BlocProvider(
                create:
                    (_) => TopicsBloc(TopicsRepository())..add(FetchTopics()),
                child: BlocBuilder<TopicsBloc, TopicsState>(
                  builder: (context, topicState) {
                    if (topicState is TopicsLoading) {
                      return const _LoadingView(
                        text: 'Loading generated topics...',
                      );
                    }

                    if (topicState is TopicsLoaded) {
                      if (topicState.topics.isEmpty) {
                        return const Center(child: Text('No topics found'));
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: topicState.topics.length,
                        itemBuilder: (context, index) {
                          final topic = topicState.topics[index];
                          return GestureDetector(
                            onTap: () {
                               Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) =>
                                              ModuleScreen(topic: topic['topic']),
                                    ),
                                  );
                            },
                            child: Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(
                                  topic['topic'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text('Version ${topic['version']}'),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) =>
                                              ModuleScreen(topic: topic['topic']),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }

                    if (topicState is TopicsFailure) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Failed to load topics'),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                context.read<TopicsBloc>().add(FetchTopics());
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              );
            }


            if (aiState is ProcessAIFailure) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('AI processing failed'),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProcessAIBloc>().add(StartProcessAI());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return const _LoadingView();
          },
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  final String text;
  const _LoadingView({this.text = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(text),
        ],
      ),
    );
  }
}
