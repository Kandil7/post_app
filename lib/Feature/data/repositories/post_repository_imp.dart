import 'package:dartz/dartz.dart';
import 'package:post_app/Feature/domain/entities/post_entities.dart';
import 'package:post_app/Feature/domain/repositories/post_repository.dart';
import 'package:post_app/core/error/exception.dart';
import 'package:post_app/core/error/failure.dart';
import 'package:post_app/core/network_info/network_info.dart';

import '../data_sources/local/post_local_datasources.dart';
import '../data_sources/remote/post_remot_datasources.dart';
import '../model/post_model.dart';

class PostRepositoryImpl extends PostRepository {
  final LocalDataSources localDataSources;
  final RemoteDataSources remoteDataSources;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.localDataSources,
    required this.remoteDataSources,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Unit>> createPost(PostEntities post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
      
    );
    return _getMessage(() => remoteDataSources.createPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() => remoteDataSources.deletePost(postId));
  }

  @override
  Future<Either<Failure, List<PostEntities>>> getPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSources.getPosts();
        localDataSources.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSources.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntities post) {
    final PostModel postModel = PostModel(
      id: post.id!,
      title: post.title,
      body: post.body,
      
    );
    return _getMessage(() => remoteDataSources.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage(
      Future<Unit> Function() func) async {
    if (await networkInfo.isConnected) {
      try {
        await func();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
