import 'dart:developer';
import 'package:firebase_ai_logic/provider/ai_story_provider.dart';
import 'package:firebase_ai_logic/utilities/app_color.dart';
import 'package:firebase_ai_logic/widgets/primary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceAssistantSheet extends StatelessWidget {
  const VoiceAssistantSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 45,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          _VoiceAssitantTile(),
          Spacer(),
          _CenterMicIcon(),
          Spacer(),
          _PrivacyCard(),
        ],
      ),
    );
  }

  static void show(BuildContext context) async {
    final height = MediaQuery.of(context).size.height * 0.95;
    showModalBottomSheet(
      backgroundColor: AppColor.whiteColor,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          height: height,
          child: VoiceAssistantSheet(),
        );
      },
    );
  }
}

class _CenterMicIcon extends HookConsumerWidget {
  const _CenterMicIcon();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speech = useMemoized(() => SpeechToText());
    final isListening = useState(false);
    final recognizedText = useState('');
    Future<void> startListening() async {
      final available = await speech.initialize();
      if (!available) {
        return;
      }
      isListening.value = true;
      speech.listen(
        onResult: (result) {
          recognizedText.value = result.recognizedWords;
        },
      );
    }

    Future<void> stopListening() async {
      await speech.stop();
      isListening.value = false;
    }

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );

    final text = isListening.value ? 'Tap to stop' : 'Tap to speak';
    Future<void> animateMic() async {
      final aiStory = ref.read(aiStoryProvider.notifier);
      isListening.value = !isListening.value;
      if (isListening.value) {
        animationController.repeat(reverse: true);
        await startListening();
        await Future.delayed(const Duration(seconds: 6));
        await stopListening();
        animationController.stop();
        animationController.reset();
        // Now speech should have been recognized
        log('final prompt: ${recognizedText.value}');

        if (recognizedText.value.isNotEmpty) {
          await aiStory.generateAiStory(recognizedText.value, '');
          if (!context.mounted) return;
          context.pop();
        }
      } else {
        await stopListening();
        animationController.stop();
        animationController.reset();
      }
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () async => await animateMic(),
          child: CircleAvatar(
            backgroundColor: AppColor.backgroundColor.withValues(alpha: 0.08),
            radius: 80,
            child: CircleAvatar(
              backgroundColor: AppColor.backgroundColor.withValues(alpha: 0.2),
              radius: 65,
              child: CircleAvatar(
                backgroundColor: AppColor.backgroundColor.withValues(
                  alpha: 0.4,
                ),
                radius: 55,
                child: CircleAvatar(
                  backgroundColor: AppColor.whiteColor,
                  radius: 40,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.85, end: 1.15).animate(
                      CurvedAnimation(
                        parent: animationController,
                        curve: Curves.easeInOut,
                      ),
                    ),

                    child: Icon(
                      Icons.mic,
                      size: 55,
                      color: AppColor.backgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(text, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        if (isListening.value)
          Text(
            'I\'m listening...',
            style: TextStyle(color: AppColor.backgroundColor),
          ),
        Text(
          recognizedText.value,
          style: TextStyle(color: AppColor.backgroundColor),
        ),
      ],
    );
  }
}

class _PrivacyCard extends StatelessWidget {
  const _PrivacyCard();

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      borderRadius: 16,
      backgroundColor: AppColor.cardColor.withValues(alpha: 0.05),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.gpp_good_outlined,
              size: 20,
              color: AppColor.backgroundColor,
            ),
            SizedBox(width: 4),
            Text(
              'Your conservations are private and secure',
              style: TextStyle(
                color: AppColor.cardColor.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VoiceAssitantTile extends StatelessWidget {
  const _VoiceAssitantTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 3,
        child: CircleAvatar(
          backgroundColor: AppColor.backgroundColor.withValues(alpha: 0.1),
          child: Icon(Icons.graphic_eq, color: AppColor.backgroundColor),
        ),
      ),
      title: Row(
        children: [
          Text(
            'Voice Assistant',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          Spacer(),
          CircleAvatar(
            backgroundColor: AppColor.cardColor.withValues(alpha: 0.1),
            child: IconButton(
              padding: EdgeInsets.all(4),
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.close),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      subtitle: Text(
        "I'm here to help. How can I assist you today?",
        style: TextStyle(fontSize: 12, color: AppColor.cardColor),
      ),
    );
  }
}
