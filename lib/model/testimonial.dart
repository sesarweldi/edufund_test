class Testimonial {
  String? createdAt;
  String? name;
  String? avatar;
  String? content;
  int? likes;
  String? id;

  Testimonial(
      {this.createdAt,
      this.name,
      this.avatar,
      this.content,
      this.likes,
      this.id});

  Testimonial.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    name = json['name'];
    avatar = json['avatar'];
    content = json['content'];
    likes = json['likes'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['name'] = name;
    data['avatar'] = avatar;
    data['content'] = content;
    data['likes'] = likes;
    data['id'] = id;
    return data;
  }
}
