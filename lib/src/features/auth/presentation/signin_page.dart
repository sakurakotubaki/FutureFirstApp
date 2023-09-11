import 'package:architecture_app/src/features/auth/application/auth_notifier.dart';
import 'package:architecture_app/src/features/auth/presentation/widget/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignInPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthButton(
                text: '登録せずに利用',
                onPressed: () => ref
                    .read(authNotifierProvider.notifier)
                    .signInAnonymously()),
          ],
        ),
      ),
    );
  }
}
