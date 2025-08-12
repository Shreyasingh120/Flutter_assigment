import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/image_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery'),
      ),
      body: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          if (state is ImageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ImageError) {
            return Center(child: Text(state.message));
          } else if (state is ImageLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: state.images.length,
              itemBuilder: (context, index) {
                final image = state.images[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          image.downloadUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          image.author,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No images available'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ImageBloc>().add(FetchImages());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}