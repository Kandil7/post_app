import 'package:flutter/material.dart';
import 'package:post_app/Feature/domain/entities/post_entities.dart';

class PostWidget extends StatelessWidget {
  final List<PostEntities> posts;
  const PostWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(posts[index].title),
            subtitle: Text(posts[index].body),
          ),
        );
      },
    );
  }
}
