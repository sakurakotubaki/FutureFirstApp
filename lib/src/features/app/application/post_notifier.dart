import 'dart:async';

import 'package:architecture_app/src/features/app/data/post_provider.dart';
import 'package:architecture_app/src/features/app/domain/post/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postNotifierProvider =
    AsyncNotifierProvider<PostNotifier, void>(PostNotifier.new);

class PostNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // 戻り値がなければ書かない。
  }

  Future<void> sendPost(Post post) async {
    final postRef = ref.read(fireStoreProvider);

    // 入力された値がnullだったら、ref.listenでエラーを表示する
    if (post.body.isEmpty) {
      state = const AsyncError<void>('投稿失敗: 本文が空です', StackTrace.empty);
    }
    // 入力された値がnullじゃなかったら、投稿する
    else {
      try {
        state = const AsyncLoading();
        await postRef.collection('post').add(post.toJson());
        state = AsyncValue<void>.data(null); // Successfully added
      // ignore: avoid_catches_without_on_clauses
      } catch (e, stackTrace) {
        state = AsyncError<void>('投稿失敗: ${e.toString()}', stackTrace);
      }
    }
  }
}
