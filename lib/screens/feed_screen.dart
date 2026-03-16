import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import '../widgets/post_card.dart';
import '../widgets/story_list.dart';
import '../widgets/shimmer_loader.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PostProvider>().loadPosts();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        context.read<PostProvider>().loadPosts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PostProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Instagram",
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 28,
            color: Colors.black,
          ),
        ),
        leading: const Icon(Icons.add_box_outlined, color: Colors.black),
        actions: const [
          Icon(Icons.favorite_border, color: Colors.black),
          SizedBox(width: 16),
          Icon(Icons.chat_bubble_outline, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: provider.posts.isEmpty
          ? const ShimmerLoader()
          : ListView(
              controller: _scrollController,
              children: [
                const StoryList(),
                const Divider(height: 1, color: Colors.black12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.posts.length + 1,
                  itemBuilder: (context, index) {
                    if (index == provider.posts.length) {
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }

                    return PostCard(post: provider.posts[index]);
                  },
                ),
              ],
            ),
    );
  }
}