import 'package:firebase_ai/firebase_ai.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final aiLogicRepositoryProvider = Provider<FirebaseAiLogicRepository>((ref) {
  return FirebaseAiLogicRepository(aiLogic: FirebaseAI.googleAI());
});

class FirebaseAiLogicRepository {
  final FirebaseAI aiLogic;

  FirebaseAiLogicRepository({required this.aiLogic});

  Future<String> generateFood(String title, String description) async {
    const modelName = 'gemini-3.5-flash-lite';
    final model = aiLogic.generativeModel(model: modelName);
    final prompt =
        ''' Crate a detail food recipe.
        before generating check if its a food or not 
        a also check its  descriptoin random text like "skldjweio"
        than shown in response "Please Enter a valid food name or description"

    Title: $title,
    Description: $description

     Return the response in Markdown.
        Use:
        # Recipe Title
        ## Ingredients
        ## Step-by-step Cooking Instructions
        ## Cooking Time
        ## Serving Size
     ''';

    final food = await model.generateContent([Content.text(prompt)]);
    final response = food.text ?? 'failed to generate food';
    return response;
  }
}
