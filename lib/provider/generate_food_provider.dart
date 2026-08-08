import 'package:firebase_ai_logic/repository/firebase_ai_logic_repositroy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final aiLogicProvider =
    AsyncNotifierProvider.autoDispose<GenerateFoodProvider, String>(
      GenerateFoodProvider.new,
    );

class GenerateFoodProvider extends AsyncNotifier<String> {
  late final FirebaseAiLogicRepository _repository;

  @override
  Future<String> build() async {
    _repository = ref.read(aiLogicRepositoryProvider);

    // Initial state
    return '';
  }

  Future<void> generateFood(String title, String description) async {
    try {
      state = AsyncValue.loading();
      final response = await _repository.generateFood(title, description);
      state = AsyncValue.data(response);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
