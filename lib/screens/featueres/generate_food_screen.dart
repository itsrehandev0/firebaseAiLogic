import 'dart:developer';

import 'package:firebase_ai_logic/utilities/app_color.dart';
import 'package:firebase_ai_logic/widgets/primary_button.dart';
import 'package:firebase_ai_logic/widgets/primary_card.dart';
import 'package:firebase_ai_logic/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';

class GenerateFoodScreen extends StatelessWidget {
  static String routeName = 'generateFood';
  static String routeLocation = '/$routeName';
  
  const GenerateFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              PrimaryTextField(title: 'Title', hintText: 'Enter food name'),
              SizedBox(height: 8),
              PrimaryTextField(
                title: 'Description',
                hintText: 'Enter food Descriptoin',
              ),
              SizedBox(height: 16),
              PrimaryButton(
                text: 'Generate',
                onTap: () {
                  log('message');
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

class _ResultCard extends StatelessWidget {
  const _ResultCard();

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      borderColor: AppColor.backgroundColor,
      width: 2,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Once upon a time, there was a poor woodcutter who lived in a small village near a forest. Every day, he went into the forest to cut wood and sell it to earn money for his family. One day, while cutting a tree near a river, his axe slipped from his hands and fell into the deep water. He became very sad because he could not afford to buy another axe.\n\nSuddenly, a fairy appeared and asked him why he was crying. After hearing his story, the fairy dived into the river and brought out a golden axe. The woodcutter honestly said that it was not his. The fairy then brought a silver axe, but he again refused it. Finally, she brought his old iron axe. The woodcutter happily said that it was his.\n\nThe fairy was pleased with his honesty and rewarded him with all three axes. The woodcutter thanked the fairy and returned home happily.',
          ),
        ],
      ),
    );
  }
}
