import 'package:dartz/dartz.dart';
import 'package:post_app/core/error/failure.dart';

import '../entities/post_entities.dart';
import '../repositories/post_repository.dart';

class CreatePost{
  final PostRepository repository;

 const CreatePost(this.repository);

  Future<Either<Failure,Unit>> call(PostEntities post)async{
    return await repository.createPost(post);
  }
}