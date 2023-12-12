import 'package:flutter/material.dart';
import 'package:post_app/Feature/domain/entities/post_entities.dart';
import 'package:post_app/Feature/presentation/screens/add_update_post_screen.dart';

class PostDetails extends StatelessWidget {
  final PostEntities post;
  const PostDetails({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(post.title, style: TextStyle(fontSize: 40)),
              const SizedBox(height: 10),
              Text(post.body, style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AddUpdatePostScreen(isUpdate:true,post: post)));
                },
                child: const Icon(Icons.edit),
              )
            ],
          ),
        ),
      ),
    );
  }
}
