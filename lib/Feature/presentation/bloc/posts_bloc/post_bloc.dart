import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:post_app/Feature/domain/entities/post_entities.dart';
import 'package:post_app/core/strings/failure_message.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/use_cases/get_post.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  GetAllPosts getAllPosts;
  PostBloc({required this.getAllPosts}) : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is GetPostsEvent||event is RefreshPostEvent) {
        emit(PostLoadingState());
        final  posts= await getAllPosts();
        emit(await _mapFailureOrPostsTostate(posts));
      }
      
    });
  }

  _mapFailureOrPostsTostate(
      Either<Failure, List<PostEntities>> failureOrPosts) async {
   return failureOrPosts.fold((failure) => PostErrorState(message: _mapFailureToState(failure))
    , (posts) =>PostLoadedState(posts: posts));
  }

  String _mapFailureToState(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case EmptyCacheFailure:
        return CACHE_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return 'Unexpected error';
    }
  }
}
