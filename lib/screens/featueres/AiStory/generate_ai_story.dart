import 'package:firebase_ai_logic/provider/ai_story_provider.dart';
import 'package:firebase_ai_logic/screens/featueres/AiStory/voice_assistant_sheet.dart';
import 'package:firebase_ai_logic/utilities/app_color.dart';
import 'package:firebase_ai_logic/widgets/primary_button.dart';
import 'package:firebase_ai_logic/widgets/primary_card.dart';
import 'package:firebase_ai_logic/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GenerateAiStory extends HookConsumerWidget {
  static String routeName = 'ai-story';
  static String routeLocation = '/$routeName';
  const GenerateAiStory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleContoller = useTextEditingController();
    final descContoller = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
        title: Text('AI Story'),
        actions: [
          IconButton(onPressed: () {
            VoiceAssistantSheet.show(context);
          }, icon: Icon(Icons.mic)),
          SizedBox(width: 24),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              PrimaryTextField(
                controller: titleContoller,
                textInputAction: TextInputAction.next,
                title: 'Title',
                hintText: 'Story Name...',
              ),
              SizedBox(height: 8),
              PrimaryTextField(
                controller: descContoller,
                textInputAction: TextInputAction.done,
                title: 'Description',
                hintText: 'About Story....',
              ),
              SizedBox(height: 16),
              PrimaryButton(
                text: 'Genearte',
                onTap: () {
                  final aiLogic = ref.read(aiStoryProvider.notifier);
                  final title = titleContoller.text.trim();
                  final description = descContoller.text.trim();
                  aiLogic.generateAiStory(title, description);
                  titleContoller.clear();
                  descContoller.clear();
                },
              ),
              SizedBox(height: 16),
              _ResultCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultCard extends ConsumerWidget {
  const _ResultCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStory = ref.watch(aiStoryProvider);
    return asyncStory.when(
      data: (story) {
        if (story.isEmpty) {
          return SizedBox();
        }
        return PrimaryCard(
          padding: EdgeInsets.all(8),
          width: 2,
          borderColor: AppColor.backgroundColor,
          child: MarkdownBody(data: story),
        );
      },
      error: (e, t) => Text(e.toString()),
      loading: () =>
          Column(children: [SizedBox(height: 60), CircularProgressIndicator()]),
    );
  }
}
