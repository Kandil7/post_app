import 'package:dartz/dartz.dart';
import 'package:post_app/Feature/domain/entities/post_entities.dart';
import 'package:post_app/core/error/failure.dart';

import '../repositories/post_repository.dart';

class GetAllPosts{
  final PostRepository repository;
  const GetAllPosts(this.repository);
  Future<Either<Failure,List<PostEntities>>> call()async{
    return await repository.getPosts();
  }
}