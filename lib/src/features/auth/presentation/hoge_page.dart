import 'package:architecture_app/src/features/auth/application/auth_notifier.dart';
import 'package:architecture_app/src/features/auth/presentation/widget/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HogePage extends ConsumerWidget {
  const HogePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('HogePage')),
      body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthButton(
                      text: 'ログアウト',
                      onPressed: () => ref
                          .read(authNotifierProvider.notifier)
                          .signOut()),
                ],
              ),
            ),
    );
  }
}
