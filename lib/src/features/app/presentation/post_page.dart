import 'package:architecture_app/src/features/app/application/post_notifier.dart';
import 'package:architecture_app/src/features/app/data/post_provider.dart';
import 'package:architecture_app/src/features/app/domain/post/post.dart';
import 'package:architecture_app/src/features/auth/application/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [ログイン後のページ]ここで、投稿と表示をする
class PostPage extends ConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bodyController = TextEditingController();
    ref.listen<AsyncValue<void>>(
      postNotifierProvider,
      (prev, next) {
        if (next is AsyncError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.error.toString())),
          );
        }
      },
    );

    final postAsyncValue = ref.watch(postStreamProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.lock),
            onPressed: () async {
              await ref.read(authNotifierProvider.notifier).signOut();
            },
          ),
        ],
        title: const Text('Post'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 300,
              height: 50,
              child: TextFormField(
                controller: bodyController,
                decoration: const InputDecoration(
                  hintText: '本文',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  final post = Post(
                    body: bodyController.text,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );
                  await ref.read(postNotifierProvider.notifier).sendPost(post);
                },
                child: const Text('投稿')),
            Expanded(
              child: postAsyncValue.when(
                data: (posts) {
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return ListTile(
                        title: Text(post.body),
                        subtitle: Text(post.createdAt.toString()),
                        leading: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            final postId = posts[index].id;
                            // await ref
                            //     .read(fireStoreProvider)
                            //     .collection('post')
                            //     .doc(postId)
                            //     .delete();
                            await ref
                                .read(postNotifierProvider.notifier)
                                .deletePost(postId);
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
