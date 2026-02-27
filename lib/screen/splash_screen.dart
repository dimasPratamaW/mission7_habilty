import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mission7_habitly/screen/dashboard/main_dashboard.dart';
import 'package:mission7_habitly/screen/login.dart';
import 'package:mission7_habitly/style/app_color.dart';

import '../presentation/providers/auth_providers.dart';

class SplashScreen extends ConsumerWidget {
  static const routeName = '/';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);

    final authState = ref.watch(authNotifierProvider);

    authState.whenData((user){
      if(user != null){
       WidgetsBinding.instance.addPostFrameCallback((_){
         Navigator.pushReplacementNamed(context, MainDashboard.routeName);
       });
      }
    });

    return Scaffold(
      backgroundColor: colors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo_app.png', height: 320, width: 320),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 12,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Keep up your Health!'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(18),
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.black),
              ),
              child: Image.asset(
                'assets/right_arrow.png',
                width: 18,
                height: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
