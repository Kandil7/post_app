import 'package:dartz/dartz.dart';
import 'package:post_app/Feature/domain/entities/post_entities.dart';

import '../../../core/error/failure.dart';
import '../repositories/post_repository.dart';

class DeletePost {
  final PostRepository repository;

  const DeletePost(this.repository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}