import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../model/post_model.dart';

abstract class RemoteDataSources {
  Future<List<PostModel>> getPosts();
  Future<Unit> createPost(PostModel post);
  Future<Unit> updatePost(PostModel post);
  Future<Unit> deletePost(int postId);
}

const String POSTS_URL = 'https://jsonplaceholder.typicode.com/posts/';

class RemoteDataSourcesImpl implements RemoteDataSources {
  final http.Client client;

  RemoteDataSourcesImpl({required this.client});

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await client.get(
      Uri.parse(POSTS_URL),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200||response.statusCode == 201) {
      final List<dynamic> jsonList = json.decode(response.body);
      final List<PostModel> posts =
          jsonList.map((e) => PostModel.fromJson(e)).toList();
      return Future.value(posts);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> createPost(PostModel post) async {
    var body = {"title": post.title, "body": post.body};
    final respose = await client.post(Uri.parse(POSTS_URL),
        body: body);
    if (respose.statusCode == 200||respose.statusCode == 201) {
      return Future.value(unit);
    } else {
      print(respose.statusCode);
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response =
        await client.delete(Uri.parse(POSTS_URL + '/${postId.toString()}'));
    if (response.statusCode == 200||response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final postId = post.id.toString();
    final postBody = {'title': post.title, 'body': post.body};
    final response =
        await client.patch(Uri.parse(POSTS_URL + "$postId"), body: postBody);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
