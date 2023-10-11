import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:learn/Documentation/button_widget.dart';
import 'package:learn/Documentation/firebase_api.dart';

class DemInter extends StatefulWidget {
  const DemInter({super.key});

  @override
  State<DemInter> createState() => _DemInterState();
}

class _DemInterState extends State<DemInter> {

  PlatformFile? pickedFile;
  UploadTask? task;
  File? file;


      @override
    Widget build(BuildContext context) {
      final String fileName;
      if (file !=null) {
        fileName = basename(file!.path);
      } else {
        fileName = 'Pas de Fichier';
      }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Demande Intervetion"),
            backgroundColor: Colors.blueGrey,
          ),
          body: Container( 
           padding: const EdgeInsets.all(32),
           child: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                onClicked: selectFile,
                icon: Icons.attach_file,
                text :'Fichier Selectionnée',
               ),
              const SizedBox(height: 8),
               Text(
                fileName,
                style: const TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),
               ),
              const SizedBox(height: 48),
              ButtonWidget(
                onClicked: uploadFile,
                icon: Icons.cloud_upload_outlined,
                text :'Fichier Importée',
               ),
               const SizedBox(height: 20),
               task !=null ? buildUploadStatus(task!) : Container(),
            ],
            ),
          ),
         ),
        );
    }

 Future selectFile() async {
      final result = await FilePicker.platform.pickFiles(allowMultiple: false);
      if (result == null ) {
        return ;
      }
      final path =result.files.single.path!;
      setState(() {
        file = File(path);
      });
  }

Future uploadFile() async {
    if (file == null) return ;
     final fileName = basename(file!.path);
     final destination = 'Demande_Inventaire/$fileName';

     task =FirebaseApi.uploadFile(destination,file!);
     setState(() {  });
      if (task == null ) return;
       final snapshot = await task!.whenComplete(() {});
       final urlDownload = await snapshot.ref.getDownloadURL();

       print(' Download-Link : $urlDownload');
   }

  Widget buildUploadStatus(UploadTask task ) => StreamBuilder<TaskSnapshot> (
    stream : task.snapshotEvents,
    builder : (context , snapshot) {
        if (snapshot.hasData) {
           final snap =snapshot.data!;
           final progress = snap.bytesTransferred / snap.totalBytes;
           final percentage = (progress *100).toStringAsFixed(2);
          return Text(
            '$percentage %',
            style: const TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),
          );

        } else {
          return Container();
        }
    }
  );
}