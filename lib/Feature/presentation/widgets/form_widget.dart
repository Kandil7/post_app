import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/Feature/domain/entities/post_entities.dart';
import 'package:post_app/Feature/presentation/bloc/add_update_delete_post_bloc/add_update_delete_post_bloc.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({
    super.key,
    required this.isUpdate,
    this.post,
  });

  final bool isUpdate;
  final PostEntities? post;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void validUpdateOrAddPost() {
    if (_formKey.currentState!.validate()) {
      final post = PostEntities(
          id: widget.isUpdate ? widget.post!.id : null,
          title: _titleController.text,
          body: _bodyController.text);

      if (widget.isUpdate) {
        BlocProvider.of<AddUpdateDeletePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddUpdateDeletePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }

    @override
    void initState() {
      super.initState();

      if (widget.isUpdate) {
        _titleController.text = widget.post!.title;
        _bodyController.text = widget.post!.body;
      }
    }

    @override
    Widget build(BuildContext context) {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _titleController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Post Title';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter Post Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _bodyController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Post Body';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter Post Body',
                border: OutlineInputBorder(),
              ),
              minLines: 6,
              maxLines: 6,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                validUpdateOrAddPost();
              },
              child: Text(widget.isUpdate ? 'Update' : 'Add'),
            ),
          ],
        ),
      );
    }
  }

