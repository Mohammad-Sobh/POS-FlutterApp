import 'package:flutter/material.dart';
import 'package:pos_app/core/core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
export 'package:pos_app/services/api_service.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    HttpClient client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //temperory bypass sceurty
  HttpOverrides.global = MyHttpOverrides();
  final appState = AppStateNotifier();
  await appState.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (context) => appState,
      child:  const MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  
   @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateNotifier>(context);
    final router = createRouter(appState);
    
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'POS-project',
      localizationsDelegates: const [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: appState.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: appState.themeMode,
      routerConfig: router,
    );
  }
}
