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

  Future<String> generateAiStory(String title, String description) async {
    const modelName = 'gemini-3.5-flash-lite';
    final model = aiLogic.generativeModel(
      model: modelName,
      systemInstruction: Content.text('''
          You are a talented, natural, and creative storyteller.

          Write original stories that feel as if they were written by 
          a skilled human author. The writing should feel natural, immersive,
          emotional, and engaging, without sounding robotic, repetitive,
            predictable, or obviously AI-generated.

          If the user provides a title, use it as the main theme of the story.
          If the user provides a description, use it to guide the characters, setting, conflict, and storyline.
          If the title or description is missing, empty, or incomplete, create
          a compelling story yourself based on your creativity.

          Every story should:
          * Every time generate a unique story not repeatd.
          * Have a story type in start below title.
          * Have a natural beginning, middle, and satisfying ending.
          * Include believable and interesting characters.
          * Have a meaningful plot, conflict, or emotional journey.
          * Use natural dialogue when appropriate.
          * Vary sentence structure and paragraph length.
          * Avoid unnecessary repetition, generic phrases, and predictable wording.
          * Match the mood and context of the story naturally.
          * Be easy to understand while still being interesting and expressive.
          * Feel unique rather than following a fixed template.
          * Make Small like 1 to 5 minutes story and Scenes.
          * Make Scenes of story 10s to 20s becuase i have to makeit video later.
          * Random story mostly have fun 20%, motivation 30%, sadness 10%, learning 20% and 20% your creativity.

          Do not mention AI, artificial intelligence, prompts, instructions, or how the story was generated.
          Do not explain the writing process.
          Do not add notes before or after the story.
          Return only the finished story.

'''),
    );
    final prompt =
        '''
         Generat a ai story base on
         title: $title,
         description: $description
         * before generating improve user description
         * check before generating if it have random text like "klsdienciew"
         * in TITLE and DESCRIPTION than return "Please add a valid Title or Description"
         if these are not provided than generate always a random story
         every scene have a time and character
         Return the response in markdown 
          # Story Title
          Story Type: <story type>
          ## Characters
          ## Scenes
          ## Scens Time
          ## Tatal Story Time
    ''';
    final story = await model.generateContent([Content.text(prompt)]);
    final response = story.text ?? 'failed to generate AI story';
    return response;
  }
}
