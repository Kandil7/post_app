import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../model/post_model.dart';

abstract class LocalDataSources {
  Future< List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> posts);
}

const String POSTS_CACHED = 'POSTS_CACHED';


class LocalDataSourcesImpl implements LocalDataSources {
      SharedPreferences sharedPrefrences;
  LocalDataSourcesImpl({required this.sharedPrefrences});

  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    final postModelToJson = posts.map((e) => e.toJson()).toList();

    sharedPrefrences.setString(POSTS_CACHED, json.encode(postModelToJson));

    return Future.value(unit);



  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPrefrences.getString(POSTS_CACHED);
    if(jsonString!=null){
      final List<dynamic> jsonList =json.decode(jsonString);
      final List<PostModel> posts = jsonList.map((e) => PostModel.fromJson(e)).toList();
      return Future.value(posts);
    }else{
      throw EmptyCacheException();
    }
  }
}
