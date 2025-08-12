import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/blocs/image_bloc.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
  });

  testWidgets('Image Gallery app test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => ImageBloc(),
          child: const HomeScreen(),
        ),
      ),
    );

    // Verify app bar title
    expect(find.text('Image Gallery'), findsOneWidget);

    // Verify floating action button exists
    expect(find.byType(FloatingActionButton), findsOneWidget);

    // Allow the widget to rebuild
    await tester.pump();

    // Initial state should show either loading or no images
    bool hasLoadingOrNoImages = find.byType(CircularProgressIndicator).evaluate().isNotEmpty ||
        find.text('No images available').evaluate().isNotEmpty;
    expect(hasLoadingOrNoImages, true);
  });
}