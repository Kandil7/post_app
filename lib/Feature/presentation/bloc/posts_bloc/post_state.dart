part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<PostEntities> posts;
  const PostLoadedState({required this.posts});
  
  @override
  List<Object> get props => [posts];
}

class PostErrorState extends PostState {
  final String message;
  const PostErrorState({required this.message});
  
  @override
  List<Object> get props => [message];
}
