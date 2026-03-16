import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_repository.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository repository = PostRepository();

  List<Post> posts = [];
  int page = 1;
  bool isLoading = false;

  Future<void> loadPosts() async {
    if (isLoading) return;

    isLoading = true;
    
    final newPosts = await repository.fetchPosts(page);
    posts.addAll(newPosts);
    page++;
    
    isLoading = false;
    notifyListeners();
  }

  void toggleLike(int id) {
    final post = posts.firstWhere((p) => p.id == id);
    post.isLiked = !post.isLiked;
    notifyListeners();
  }

  void toggleSave(int id) {
    final post = posts.firstWhere((p) => p.id == id);
    post.isSaved = !post.isSaved;
    notifyListeners();
  }
}