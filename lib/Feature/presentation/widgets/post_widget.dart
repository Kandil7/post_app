import 'package:flutter/material.dart';
import 'package:post_app/Feature/domain/entities/post_entities.dart';

import '../screens/post_datails.dart';

class PostWidget extends StatelessWidget {
  final List<PostEntities> posts;
  const PostWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => PostDetails(
                      post: posts[index],
                    )));
          },
          child: Card(
            child: ListTile(
              title: Text(posts[index].title),
              subtitle: Text(posts[index].body),
            ),
          ),
        );
      },
    );
  }
}
