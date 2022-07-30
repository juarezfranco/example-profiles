import 'package:flutter/material.dart';
import 'package:posts/generate_data.dart';
import 'package:posts/pages/profiles/list_profiles_page.dart';
import 'package:posts/support/app_container.dart';

bool generateFakeData = true;
bool resetFakeData = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppContainer.initialize();

  if (generateFakeData) {
    await GenerateFakeData().generate(
      reset: resetFakeData,
    );
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListProfilesPage(),
    );
  }
}
