import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// FirebaseAuthのインスタンスを提供するProvider
final firebaseProvider = Provider((ref) => FirebaseAuth.instance);

// ログイン状態を管理するStreamProvider
final authStateChangesProvider =
    StreamProvider((ref) => ref.watch(firebaseProvider).authStateChanges());

// uidを提供するProvider
final uidProvider =
    Provider((ref) => ref.watch(firebaseProvider).currentUser?.uid);
