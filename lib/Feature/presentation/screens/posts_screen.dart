import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/Feature/presentation/widgets/message_widget.dart';

import '../../../core/widget/loading_widget.dart';
import '../bloc/posts_bloc/post_bloc.dart';
import '../widgets/post_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Posts')),
        centerTitle: true,

      ),
      body:  PostScreenBody(),
    );
  }
}

class PostScreenBody extends StatelessWidget {
  const PostScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is PostLoadingState) {
          return  LoadingWidget();
        } else if (state is PostLoadedState) {
          return RefreshIndicator(
            onRefresh: ()=> _onRefresh(context),
            child: PostWidget(posts: state.posts));
        } else if (state is PostErrorState) {
          return MessageWidget(message: state.message);
        } else {
          return  LoadingWidget();
        }
      },
    );
  }
  
 Future<void> _onRefresh(BuildContext context) async{
    BlocProvider.of<PostBloc>(context).add(RefreshPostEvent());
  }
}
