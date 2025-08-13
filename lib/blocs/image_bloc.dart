import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'dart:convert';
import '../models/image_model.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();
  @override
  List<Object> get props => [];
}

class FetchImages extends ImageEvent {}

abstract class ImageState extends Equatable {
  const ImageState();
  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}
class ImageLoading extends ImageState {}
class ImageLoaded extends ImageState {
  final List<ImageModel> images;
  const ImageLoaded(this.images);
  @override
  List<Object> get props => [images];
}
class ImageError extends ImageState {
  final String message;
  const ImageError(this.message);
  @override
  List<Object> get props => [message];
}

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<FetchImages>(_onFetchImages);
  }

  Future<void> _onFetchImages(
    FetchImages event,
    Emitter<ImageState> emit,
  ) async {
    emit(ImageLoading());
    try {
      final response = await http.get(
        Uri.parse('https://picsum.photos/v2/list?page=1&limit=10')
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final images = jsonResponse.map((image) => ImageModel.fromJson(image)).toList();
        emit(ImageLoaded(images));
      } else {
        emit(const ImageError('Failed to load images'));
      }
    } catch (e) {
      emit(ImageError(e.toString()));
    }
  }
}