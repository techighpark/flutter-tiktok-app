class VideoModel {
  final String id;
  final String creator;
  final String title;
  final String description;
  final String fileUrl;
  final String thumbnailUrl;
  final int likes;
  final int comments;
  final String creatorUid;
  final int createdAt;

  VideoModel({
    required this.id,
    required this.creator,
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.likes,
    required this.comments,
    required this.creatorUid,
    required this.createdAt,
  });

  VideoModel.fromJson({
    required Map<String, dynamic> json,
    required String videoId,
  })  : creator = json['creator'],
        title = json['title'],
        description = json['description'],
        fileUrl = json['fileUrl'],
        thumbnailUrl = json['thumbnailUrl'],
        likes = json['likes'],
        comments = json['comments'],
        creatorUid = json['creatorUid'],
        createdAt = json['createdAt'],
        id = videoId;

  Map<String, dynamic> toJson() {
    return {
      "creator": creator,
      "title": title,
      "description": description,
      "fileUrl": fileUrl,
      "thumbnailUrl": thumbnailUrl,
      "likes": likes,
      "comments": comments,
      "creatorUid": creatorUid,
      "createdAt": createdAt,
      "id": id,
    };
  }
}
