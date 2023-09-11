// Listとモデルクラスを使った例
import 'package:architecture_app/src/features/app/domain/post/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// Firestoreのlogを出すためのloggerを作成する
final fireStoreLoggerProvider = Provider((ref) => Logger());

// FirebaseFirestoreのインスタンスを作成する
final fireStoreProvider = Provider((ref) => FirebaseFirestore.instance);

/*Listとモデルクラスを使った例
データを削除するには、documentIDを指定する必要がある。
なので、StreamProviderの中で取得する。コードで使うときは、モデルクラスのString型のidを使う。
autoDisposeを使うと、ページから離れたときに、状態を破棄する。
*/
final postStreamProvider = StreamProvider.autoDispose<List<Post>>((ref) {
  final fireStore = ref.read(fireStoreProvider);
  final logger = ref.read(fireStoreLoggerProvider);
  final postRef = fireStore.collection('post');
  final snapshots = postRef.snapshots();
  return snapshots.map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      final id = doc.id;
      logger.d(doc.data());
      return Post.fromJson(doc.data());
    }).toList();
  });
});
