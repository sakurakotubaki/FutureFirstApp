import 'dart:async';

import 'package:architecture_app/src/features/auth/data/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, void>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // 戻り値がない場合は何も書かない
  }

  // 匿名ログインをするメソッド
  Future<void> signInAnonymously() async {
    final authRef = ref.read(firebaseAuthProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await authRef.signInAnonymously();
    });
    final logger = ref.read(authLogger)..i(state.toString());
  }

  // ログアウトをするメソッド
  Future<void> signOut() async {
    final authRef = ref.read(firebaseAuthProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await authRef.signOut();
    });
    final logger = ref.read(authLogger)..i(state.toString());
  }
}
