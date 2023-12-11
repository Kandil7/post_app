import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:post_app/Feature/domain/use_cases/create_post.dart';
import 'package:post_app/Feature/domain/use_cases/delet_post.dart';
import 'package:post_app/Feature/domain/use_cases/update_post.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/strings/failure_message.dart';
import '../../../../core/strings/messages.dart';
import '../../../domain/entities/post_entities.dart';

part 'add_update_delete_post_event.dart';
part 'add_update_delete_post_state.dart';

class AddUpdateDeletePostBloc
    extends Bloc<AddUpdateDeletePostEvent, AddUpdateDeletePostState> {
  CreatePost addPost;
  DeletePost deletePost;
  UpdatePost updatePost;
  AddUpdateDeletePostBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(AddUpdateDeletePostInitial()) {
    on<AddUpdateDeletePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(AddUpdateDeletePostLoadingState());
        final result = await addPost(event.post);
        emit(_mapFailureOrPostsTostate(result, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        final result = await updatePost(event.post);
        emit(_mapFailureOrPostsTostate(result, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        final result = await deletePost(event.postId);
        emit(_mapFailureOrPostsTostate(result, DELETE_SUCCESS_MESSAGE));
      }
    });
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

  AddUpdateDeletePostState _mapFailureOrPostsTostate(
      Either<Failure, Unit> failureOrPosts, String message) {
    return failureOrPosts.fold(
        (failure) =>
            AddUpdateDeletePostErrorState(message: _mapFailureToState(failure)),
        (posts) => MessageAddUpdateDeletePostState(message: message));
  }
}
