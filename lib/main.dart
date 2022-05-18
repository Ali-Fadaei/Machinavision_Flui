import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:machinavision/screens/handwriting_sc.dart';
import 'package:machinavision/screens/main_panel_sc.dart';
import 'package:machinavision/screens/object_detector_sc.dart';
import 'package:machinavision/tool_kit.dart' as T;

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  T.Utilities.initAndroid();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Powered APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: T.Colors.primary,
        onPrimary: T.Colors.white,
        secondary: T.Colors.secondary,
        onSecondary: T.Colors.white,
        error: T.Colors.errorPrimary,
        onError: T.Colors.errorSecondary,
        background: T.Colors.background,
        onBackground: T.Colors.primary2,
        surface: T.Colors.background2,
        onSurface: T.Colors.primary2,
      )),
      home: MyHomePage(title: 'AI Powered APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: MainPanelScreen.route,
      key: widget.navigatorKey,
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case MainPanelScreen.route:
            builder = (_) => const MainPanelScreen();
            break;
          case ObjectDetectorScreen.route:
            builder = (_) => const ObjectDetectorScreen();
            break;
          case HandWritingScreen.route:
            builder = (_) => const HandWritingScreen();
            break;
          default:
            builder = (_) => const MainPanelScreen();
        }
        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },

      // floatingActionButton: const FloatingActionButton(
      //   onPressed: null,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
