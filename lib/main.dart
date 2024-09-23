import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'core/inject/inject.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/routes/name_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInject();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '2GO Supermarket',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.checkout,
      routes: AppRoutes.routes,
    );
  }
}
