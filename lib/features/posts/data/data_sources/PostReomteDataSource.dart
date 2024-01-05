import 'dart:convert';

import 'package:posts_clean_architecture/global/errors/exception.dart';

import '../models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> deletePost(int postId);

  Future<Unit> updatePost(PostModel postModel);

  Future<Unit> addPost(PostModel postModel);
}

const baseUrl = 'https://jsonplaceholder.typicode.com';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  late final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse("$baseUrl/posts/"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonDecoded = jsonDecode(response.body) as List;
      print(jsonDecoded);
      final List<PostModel> posts =
          jsonDecoded.map<PostModel>((e) => PostModel.fromJson(e)).toList();
      return Future.value(posts);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final Map body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response =
        await client.post(Uri.parse("$baseUrl/posts/"), body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse("$baseUrl/posts/${postId.toString()}"),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id;
    final body = {"title": postModel.title, "body": postModel.body};
    final response =
        await client.patch(Uri.parse("$baseUrl/posts/$postId"), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
