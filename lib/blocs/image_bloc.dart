import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/image_model.dart';

class ImageEvent {}

class ImageState {
  final List<ImageModel> images;

  ImageState(this.images);
}

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageState([]));

  @override
  Stream<ImageState> mapEventToState(ImageEvent event) async* {
    final response = await http.get(Uri.parse('https://picsum.photos/v2/list?page=1&limit=10'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final images = jsonResponse.map((image) => ImageModel.fromJson(image)).toList();
      yield ImageState(images);
    }
  }
}