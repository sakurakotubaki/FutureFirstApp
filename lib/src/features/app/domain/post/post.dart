import 'package:architecture_app/src/features/app/domain/converter/timestamp_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

// flutter pub run build_runner watch --delete-conflicting-outputs

@freezed
class Post with _$Post {
  const factory Post({
    String? id,
    @Default('') String body,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);
}