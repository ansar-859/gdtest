import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final String title;
  final String imagePath;
  final List<String> comments;
  bool isCommentAllowed;

  Movie({
    required this.title,
    required this.imagePath,
    required this.comments,
    this.isCommentAllowed = true, // Provide a default value
  });

  @override
  List<Object?> get props => [title, imagePath, comments, isCommentAllowed];

  @override
  bool get stringify => true;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          imagePath == other.imagePath &&
          comments == other.comments &&
          isCommentAllowed == other.isCommentAllowed;

  @override
  int get hashCode =>
      title.hashCode ^
      imagePath.hashCode ^
      comments.hashCode ^
      isCommentAllowed.hashCode;
}
