//import 'dart:convert';

class BlogPostList {
  final List<Post> posts;

  BlogPostList({required this.posts});

  factory BlogPostList.fromJson(List<dynamic> parsedJson) {
    List<Post> posts = <Post>[];
    posts = parsedJson.map((i) => Post.fromJson(i)).toList();
    return BlogPostList(posts: posts); //Post[0].userId;
  }
}

class Post {
  int id;
  String sliderTitle;
  String sliderMessage;
  String sliderImage;
  String createdAt;
  String updatedAt;

  Post({
    required this.id,
    required this.sliderTitle,
    required this.sliderMessage,
    required this.sliderImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        sliderTitle: json['title'],
        sliderMessage: json['message'],
        sliderImage: json['image_url'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
