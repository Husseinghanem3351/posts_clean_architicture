import 'dart:convert';

import 'package:posts_clean_architecture/global/errors/exception.dart';

import '../models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePost(List<PostModel> postModel);
}

class PostLocalDataSourceImpl implements PostLocalDataSource {
  PostLocalDataSourceImpl({required this.prefs});

  final SharedPreferences prefs;

  @override
  Future<List<PostModel>> getCachedPosts()  {
    final jsonString = prefs.getString('CACHED_POSTS');
    if (jsonString != null) {
      List decodeJsonData = jsonDecode(jsonString);
      List<PostModel> posts = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(posts);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> cachePost(List<PostModel> posts) async {

    //this list to store the posts item in json type by the fun postModel.toJson
    //the first type in the fun map is to specific the type that we want to return it
    //this list will store all the items in the posts like List(without list it will be Iterable)
    List postModelsToJson = posts
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    // when we store list in the cache we should to apply the method jsonEncode on it
    // it will convert it to string
    await prefs.setString("CACHED_POSTS", jsonEncode(postModelsToJson));
    return Future.value(unit);
  }
}
