// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/Feature/domain/entities/post_entities.dart';
import 'package:post_app/Feature/presentation/bloc/add_update_delete_post_bloc/add_update_delete_post_bloc.dart';
import 'package:post_app/Feature/presentation/screens/posts_screen.dart';
import 'package:post_app/Feature/presentation/widgets/message_widget.dart';
import 'package:post_app/core/widget/loading_widget.dart';
import 'package:post_app/core/widget/snakbar_widget.dart';

import '../widgets/form_widget.dart';

class AddUpdatePostScreen extends StatelessWidget {
  final bool isUpdate;
  final PostEntities? post;
  const AddUpdatePostScreen({Key? key, required this.isUpdate, this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(isUpdate: isUpdate),
      body: addUpdateBody(isUpdate: isUpdate, post: post),
    );
  }
}

class addUpdateBody extends StatelessWidget {
  const addUpdateBody({
    super.key,
    required this.isUpdate,
    this.post,
  });

  final bool isUpdate;
  final PostEntities? post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: BlocConsumer<AddUpdateDeletePostBloc, AddUpdateDeletePostState>(
        listener: (context, state) {
          if (state is MessageAddUpdateDeletePostState) {
            showSnackBar(
                context: context,
                title: isUpdate ? 'Update Post' : 'Add New Post',
                message: isUpdate
                    ? 'Post Updated Successfully'
                    : 'Post Added Successfully',
                contentType: ContentType.success);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const PostsScreen(
                    
                    )));
          } else if (state is AddUpdateDeletePostErrorState) {
            showSnackBar(
                context: context,
                title: isUpdate ? 'Update Post' : 'Add New Post',
                message: state.message,
                contentType: ContentType.failure);
          }
        },
        builder: (context, state) {
          if (state is AddUpdateDeletePostLoadingState)
            return const LoadingWidget();
          else
            return FormWidget(isUpdate: isUpdate, post: post);
        },
      ),
    );
  }
}

AppBar _buildAppBar({required bool isUpdate}) {
  return AppBar(
    title: Center(child: Text(isUpdate ? 'Update Post' : 'Add New Post')),
    centerTitle: true,
  );
}
