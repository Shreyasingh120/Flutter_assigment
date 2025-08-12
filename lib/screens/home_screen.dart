import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/image_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageBloc()..add(ImageEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            if (state.images.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: state.images.length,
              itemBuilder: (context, index) {
                final image = state.images[index];
                return Card(
                  child: Column(
                    children: [
                      Image.network(image.downloadUrl),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(image.author, style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}