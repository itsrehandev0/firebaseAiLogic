import 'dart:async';

import 'package:firebase_ai_logic/repository/firebase_ai_logic_repositroy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final aiStoryProvider = AsyncNotifierProvider<AiStoryProvider, String>(
  AiStoryProvider.new,
);

class AiStoryProvider extends AsyncNotifier<String> {
  late final FirebaseAiLogicRepository _repository;
  @override
  Future<String> build() async {
    _repository = await ref.read(aiLogicRepositoryProvider);
    return '';
  }

  Future<void> generateAiStory(String title, String description) async {
    try {
      state = AsyncValue.loading();
      final response = await _repository.generateAiStory(title, description);
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
