import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class PrinterScreen extends StatefulWidget {
  const PrinterScreen({Key? key}) : super(key: key);

  @override
  State<PrinterScreen> createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if (status == DownloadTaskStatus.complete) {
        debugPrint('Download Complete');
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) async {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);

  }

  String? taskId;

  Future downloadFile(String url) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final storage = await getExternalStorageDirectory();
      taskId = await FlutterDownloader.enqueue(
        url: url,
        headers: {},
        savedDir: storage!.path,
        showNotification: true,
        saveInPublicStorage: true,
        openFileFromNotification: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blue Thermal Printer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Device:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                onPressed: () async {
                  downloadFile(
                          'https://www.eurofound.europa.eu/sites/default/files/ef_publication/field_ef_document/ef1710en.pdf');
                },
                child: const Text('Download',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                onPressed: () async {
                  print(taskId);
                  await FlutterDownloader.open(taskId: taskId!);
                },
                child: const Text('Open file',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
