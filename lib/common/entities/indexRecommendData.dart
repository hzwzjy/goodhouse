import 'package:goodhouse/pages/home/tab_index/index_recommend_data.dart';

class IndexRecommendData extends IndexRecommendItem {
  IndexRecommendData({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.navigateUrl,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.indexRecommendDataId,
  }) : super('', '', '', '');

  String id;
  String title;
  String subTitle;
  String imageUrl;
  String navigateUrl;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String indexRecommendDataId;

  factory IndexRecommendData.fromJson(Map<String, dynamic> json) =>
      IndexRecommendData(
        id: json["_id"],
        title: json["title"],
        subTitle: json["subTitle"],
        imageUrl: json["imageUrl"],
        navigateUrl: json["navigateUrl"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        indexRecommendDataId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "subTitle": subTitle,
        "imageUrl": imageUrl,
        "navigateUrl": navigateUrl,
        "published_at": publishedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "id": indexRecommendDataId,
      };
}
