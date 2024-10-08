part of 'add_update_delete_post_bloc.dart';

sealed class AddUpdateDeletePostEvent extends Equatable {
  const AddUpdateDeletePostEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddUpdateDeletePostEvent {
  final PostEntities post;
  const AddPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends AddUpdateDeletePostEvent {
  final PostEntities post;
  const UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends AddUpdateDeletePostEvent {
  final int postId;
  const DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
