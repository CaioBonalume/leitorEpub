class EscriboModel {
  int? id;
  String? title;
  String? author;
  String? coverUrl;
  String? downloadUrl;

  EscriboModel({
    this.id,
    this.title,
    this.author,
    this.coverUrl,
    this.downloadUrl,
  });

  EscriboModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    coverUrl = json['cover_url'];
    downloadUrl = json['download_url'];
  }

  static List<EscriboModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => EscriboModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['cover_url'] = coverUrl;
    data['download_url'] = downloadUrl;

    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'cover_url': coverUrl,
      'download_url': downloadUrl,
    };
  }

  factory EscriboModel.fromMap(Map<String, dynamic> map) {
    return EscriboModel(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      coverUrl: map['cover_url'],
      downloadUrl: map['download_url'],
    );
  }
}
