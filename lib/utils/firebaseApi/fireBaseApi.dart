import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;
import 'package:permission_handler/permission_handler.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

class FireBaseApi{
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<Object?>> listAll(String id) async {
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = (await _collectionRef.where('id' , isEqualTo: id)) as QuerySnapshot<Object?>;

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;

  }
  static Future<String> GetStatus(String shift,String job) async {
    String result;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('weekSchedule');
    var querySnapshot = await _collectionRef.where('shift' , isEqualTo: shift).where('job' , isEqualTo: job).get();
    if (!querySnapshot.docs.isEmpty) {
      var snapshot =querySnapshot.docs[0];
       result = snapshot.get('status');
    } else {
      result = 'Available';
    }
    return result;
  }
  static Future<String> GetBlockEmployee(String shift,String job) async {
    String result;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('weekSchedule');
    var querySnapshot = await _collectionRef.where('shift' , isEqualTo: shift).where('job' , isEqualTo: job).get();
    if (!querySnapshot.docs.isEmpty) {
      var snapshot =querySnapshot.docs[0];
      result = snapshot.get('employee');
    } else {
      result = 'Available';
    }
    return result;
  }



  static Future downloadFile(String url,String filename) async{
    final dir  =  await getExternalStorageDirectory();
    final file = File('${dir?.path}/${filename}');
    final respose =  await Dio().get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        receiveTimeout: 0
      ),


    );
    print(respose.data);
     final raf = file.openSync(mode: FileMode.write);
     raf.writeByteSync(respose.data);
     await raf.close();
  }
 static Future<void> downloadFileWeb(String url,String filename) async {
    html.window.open(url, '${filename}');


  }

  static Future<void> downloadFiletoDevice(String url,String filename)
  async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //add more permission to request here.
    ].request();

    if (statuses[Permission.storage]!.isGranted) {
      var dir = await DownloadsPathProvider.downloadsDirectory;
      if (dir != null) {

        String savePath = dir.path + "/$filename";
        print(savePath);
        //output:  /storage/emulated/0/Download/banner.png

        try {
          await Dio().download(url, savePath,
              onReceiveProgress: (received, total) {
            if (total != -1) {
              print((received / total * 100).toStringAsFixed(0) + "%");
              //you can build progressbar feature too
            }
          });
          print("File is saved to download folder.");
        } on DioError catch (e) {
          print(e.message);
        }
      }
    } else {
      print("No permission to read and write.");
    }
  }
}
