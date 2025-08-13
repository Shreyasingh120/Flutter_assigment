import 'package:equatable/equatable.dart';

class ImageModel extends Equatable {
  final String id;
  final String author;
  final String downloadUrl;

  const ImageModel({
    required this.id,
    required this.author,
    required this.downloadUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] ?? '',
      author: json['author'] ?? '',
      downloadUrl: json['download_url'] ?? '',
    );
  }

  @override
  List<Object> get props => [id, author, downloadUrl];
}