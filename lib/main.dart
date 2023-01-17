import 'package:bluetooth_printer/notification_manager/local_notification_api.dart';
import 'package:bluetooth_printer/printer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Plugin must be initialized before usinga
  // await LocalNotificationApi.init();
  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Printer app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PrinterScreen(),
    );
  }
}
