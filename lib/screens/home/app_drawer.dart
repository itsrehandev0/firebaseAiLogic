import 'package:firebase_ai_logic/screens/featueres/generate_food_screen.dart';
import 'package:firebase_ai_logic/utilities/app_color.dart';
import 'package:firebase_ai_logic/utilities/app_images.dart';
import 'package:firebase_ai_logic/widgets/primary_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.whiteColor,
      child: SafeArea(
        child: Column(
          children: [_DrawerHeader(), SizedBox(height: 8), _AppFeatures()],
        ),
      ),
    );
  }
}

class _AppFeatures extends StatelessWidget {
  const _AppFeatures();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryTile(
          title: 'Food',
          subTitle: 'Generate food reciepe',
          icon: Icons.abc_sharp,
          onTap: () {
           context.pushNamed(GenerateFoodScreen.routeName);
          },
        ),
      ],
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        children: [
          Image.asset(AppImages.purpleLogo, height: 100, width: 100),
          SizedBox(height: 8),
          Text(
            'FIREBASE AI',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
