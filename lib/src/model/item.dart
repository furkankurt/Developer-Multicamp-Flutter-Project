import 'dart:convert';

class Item {
  Item({
    this.link,
    this.title,
    this.description,
    this.pubDate,
    this.image,
  });

  String link;
  String title;
  String description;
  String pubDate;
  String image;

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        link: json["link"] == null ? null : json["link"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        pubDate: json["pubDate"] == null ? null : json["pubDate"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "link": link == null ? null : link,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "pubDate": pubDate == null ? null : pubDate,
        "image": image == null ? null : image,
      };
}
