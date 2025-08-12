import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  final String id;
  final String url;
  final String title;
  final String downloadUrl;
  final String author;

  const ImageModel({
    required this.id,
    required this.url,
    required this.title,
    required this.downloadUrl,
    required this.author,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      title: json['title'] ?? '',
      downloadUrl: json['download_url'] ?? '',
      author: json['author'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'title': title,
      'download_url': downloadUrl,
      'author': author,
    };
  }

  @override
  List<Object?> get props => [id, url, title, downloadUrl, author];
}