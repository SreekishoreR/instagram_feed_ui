class Post {
  final int id;
  final String username;
  final String profileImage;
  final List<String> images;
  final String caption;

  bool isLiked;
  bool isSaved;

  Post({
    required this.id,
    required this.username,
    required this.profileImage,
    required this.images,
    required this.caption,
    this.isLiked = false,
    this.isSaved = false,
  });
}