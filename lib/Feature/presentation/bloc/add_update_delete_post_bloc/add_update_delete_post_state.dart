part of 'add_update_delete_post_bloc.dart';

sealed class AddUpdateDeletePostState extends Equatable {
  const AddUpdateDeletePostState();
  
  @override
  List<Object> get props => [];
}

final class AddUpdateDeletePostInitial extends AddUpdateDeletePostState {}

final class AddUpdateDeletePostLoadingState extends AddUpdateDeletePostState {}

final class AddUpdateDeletePostLoadedState extends AddUpdateDeletePostState {
  final List<PostEntities> posts;
  const AddUpdateDeletePostLoadedState({required this.posts});
  
  @override
  List<Object> get props => [posts];
}

final class AddUpdateDeletePostErrorState extends AddUpdateDeletePostState {
  final String message;
  const AddUpdateDeletePostErrorState({required this.message});
  
  @override
  List<Object> get props => [message];
}

class MessageAddUpdateDeletePostState extends AddUpdateDeletePostState {
  final String message;
  const MessageAddUpdateDeletePostState({required this.message});
  
  @override
  List<Object> get props => [message];
}
