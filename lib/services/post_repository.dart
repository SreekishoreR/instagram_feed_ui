import 'dart:async';
import '../models/post.dart';

class PostRepository {
  Future<List<Post>> fetchPosts(int page) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    return List.generate(10, (index) {
      final id = page * 10 + index;

      return Post(
        id: id,
        username: "user${page}_$index",
        profileImage: "https://picsum.photos/200?random=${index + 20}",
        images: [
          "https://picsum.photos/500/500?random=${index + page}",
          "https://picsum.photos/500/500?random=${index + page + 10}",
        ],
        caption: "Beautiful day at the beach 🌊",
      );
    });
  }
}