import 'package:posts_clean_architecture/features/posts/domain/entities/post.dart';

class PostModel extends Post{
  const PostModel({required super.id, required super.title, required super.body});

 factory PostModel.fromJson(Map<String,dynamic> json){
   return PostModel(id: json['id'],title: json['title'], body: json['body']);
  }

  Map<String,dynamic> toJson(){
   return {
     'id':super.id  ,
     'title': super.title,
     'body': super.body,
   };
  }
}