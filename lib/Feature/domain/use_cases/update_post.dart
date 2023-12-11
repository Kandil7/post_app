import 'package:dartz/dartz.dart';
import 'package:post_app/Feature/domain/entities/post_entities.dart';

import '../../../core/error/failure.dart';
import '../repositories/post_repository.dart';

class UpdatePost {
  final PostRepository repository;

  const UpdatePost(this.repository);

  Future<Either<Failure, Unit>> call(PostEntities post) async {
    return await repository.updatePost(post);
  }
}