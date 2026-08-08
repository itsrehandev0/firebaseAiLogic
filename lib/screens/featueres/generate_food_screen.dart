import 'package:firebase_ai_logic/provider/generate_food_provider.dart';
import 'package:firebase_ai_logic/utilities/app_color.dart';
import 'package:firebase_ai_logic/widgets/primary_button.dart';
import 'package:firebase_ai_logic/widgets/primary_card.dart';
import 'package:firebase_ai_logic/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GenerateFoodScreen extends HookConsumerWidget {
  static String routeName = 'generateFood';
  static String routeLocation = '/$routeName';

  const GenerateFoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleContoller = useTextEditingController();
    final descContoller = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
        title: Text('Food'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PrimaryTextField(
                textInputAction: TextInputAction.next,
                controller: titleContoller,
                title: 'Title',
                hintText: 'Enter food name',
              ),
              SizedBox(height: 8),
              PrimaryTextField(
                textInputAction: TextInputAction.done,

                controller: descContoller,
                title: 'Description',
                hintText: 'Enter food Descriptoin',
              ),
              SizedBox(height: 16),
              PrimaryButton(
                text: 'Generate',
                onTap: () {
                  final aiLogic = ref.read(aiLogicProvider.notifier);
                  final title = titleContoller.text.trim();
                  final description = descContoller.text.trim();
                  if (title.isNotEmpty && description.isNotEmpty) {
                    aiLogic.generateFood(title, description);
                    titleContoller.clear();
                    descContoller.clear();
                  }
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
    final asyncAiLogic = ref.watch(aiLogicProvider);
    return asyncAiLogic.when(
      data: (recipe) {
        if (recipe.isEmpty) {
          return SizedBox();
        }
        return PrimaryCard(
          borderColor: AppColor.backgroundColor,
          width: 2,
          padding: const EdgeInsets.all(16),
          child: MarkdownBody(
            data: recipe,
            softLineBreak: true,
            styleSheet: MarkdownStyleSheet(
              h1: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              h2: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              p: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              listBullet: const TextStyle(fontSize: 16),
            ),
          ),
        );
      },
      error: (e, t) => Center(child: Text(e.toString())),
      loading: () =>
          Column(children: [SizedBox(height: 60), CircularProgressIndicator()]),
    );
  }
}
