import 'package:dartz/dartz.dart';
import 'package:post_app/Feature/domain/entities/post_entities.dart';


import '../../../core/error/failure.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntities>>> getPosts();
  Future<Either<Failure,Unit>> createPost(PostEntities post);
  Future<Either<Failure,Unit>> updatePost(PostEntities post);
  Future<Either<Failure,Unit>> deletePost(int postId);

}