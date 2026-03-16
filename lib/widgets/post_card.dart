import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../providers/post_provider.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  final PageController controller = PageController();
  bool showHeart = false;
  bool isZooming = false;

  void onDoubleTap() {

    setState(() {
      widget.post.isLiked = true;
      showHeart = true;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        showHeart = false;
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// HEADER
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.post.profileImage),
          ),
          title: Text(widget.post.username),
          trailing: const Icon(Icons.more_vert),
        ),

        /// IMAGE CAROUSEL
        GestureDetector(
          onDoubleTap: onDoubleTap,
          child: Stack(
            alignment: Alignment.center,
            children: [

              SizedBox(
                height: MediaQuery.of(context).size.width,
                width: double.infinity,
                child: PageView.builder(
                  controller: controller,

                  physics: isZooming
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),

                  itemCount: widget.post.images.length,
                  itemBuilder: (context, index) {

                    return InteractiveViewer(

                      minScale: 1,
                      maxScale: 4,
                      panEnabled: true,

                      onInteractionStart: (_) {
                        setState(() {
                          isZooming = true;
                        });
                      },

                      onInteractionEnd: (_) {
                        setState(() {
                          isZooming = false;
                        });
                      },

                      child: CachedNetworkImage(
                        imageUrl: widget.post.images[index],
                        fit: BoxFit.cover,
                        width: double.infinity,

                        placeholder: (context, url) =>
                            const Center(
                              child: CircularProgressIndicator(),
                            ),

                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    );

                  },
                ),
              ),

              /// DOUBLE TAP HEART
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: showHeart ? 1 : 0,
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 120,
                ),
              ),

              /// DOT INDICATOR
              Positioned(
                bottom: 12,
                child: SmoothPageIndicator(
                  controller: controller,
                  count: widget.post.images.length,
                  effect: const WormEffect(
                    dotHeight: 6,
                    dotWidth: 6,
                    spacing: 6,
                    activeDotColor: Colors.white,
                    dotColor: Colors.white54,
                  ),
                ),
              ),

            ],
          ),
        ),

        /// ACTION BUTTONS
        Row(
          children: [

            IconButton(
              iconSize: 26,
              icon: Icon(
                widget.post.isLiked
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: widget.post.isLiked
                    ? Colors.red
                    : Colors.black,
              ),
              onPressed: () {
                context.read<PostProvider>()
                    .toggleLike(widget.post.id);
              },
            ),

            IconButton(
              iconSize: 26,
              icon: const Icon(Icons.chat_bubble_outline),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Comment clicked"),
                  ),
                );
              },
            ),

            IconButton(
              iconSize: 26,
              icon: const Icon(Icons.send),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Share clicked"),
                  ),
                );
              },
            ),

            const Spacer(),

            IconButton(
              iconSize: 26,
              icon: Icon(
                widget.post.isSaved
                    ? Icons.bookmark
                    : Icons.bookmark_border,
              ),
              onPressed: () {
                context.read<PostProvider>()
                    .toggleSave(widget.post.id);
              },
            ),

          ],
        ),

        /// CAPTION
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(widget.post.caption),
        ),

        const SizedBox(height: 10),

      ],
    );
  }
}