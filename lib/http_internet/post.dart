class Post {
  int id;
  String title;
  String body;
  int userId;
  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });
  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "body": body, "userId": userId};
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      title: json["title"],
      body: json["body"],
      userId: json["userId"],
    );
  }
}
