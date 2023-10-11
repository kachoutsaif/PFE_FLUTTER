// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:learn/Menu/menu_page.dart';

// class ScanneQr extends StatefulWidget {
//   const ScanneQr({ Key? key }) : super(key: key);

//   @override
//   _ScanneQrState createState() => _ScanneQrState();
// }

// class _ScanneQrState extends State<ScanneQr> {
//   var getResult = 'QR Code Result';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     appBar: AppBar(
//       title: const Text('QR Scanner'),
//       backgroundColor: Colors.blueGrey,
//       leading: IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (context) {
//                   return const MenuPage();
//                 }));
//               }),
//           shadowColor: Colors.blueGrey,
//           elevation: 25,
//     ),
//     body: Container(
//               padding: const EdgeInsets.all(100),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(
//                       child: InkWell(
//                         onTap: () {
//                           scanQRCode();
//                         },
//                         child: Container(
//                           height: 80.0,
//                           width: 180.0,
//                           decoration:  BoxDecoration(boxShadow: const [
//                             BoxShadow(
//                                 offset: Offset(0.0,20.0),
//                                 blurRadius: 30.0,
//                                 color:  Colors.black12)
//                             ], color: Colors.white , borderRadius: BorderRadius.circular(22.0)),
//                          child : Center(
//                            child: Row(
//                                     children: <Widget>[
//                                       Container(
//                                         height: 80.0,
//                                         width: 140.0,
//                                         padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 12.0),
//                                         decoration: const BoxDecoration(
//                                           color: Colors.blueGrey,
//                                           borderRadius: BorderRadius.only(
//                                             bottomLeft: Radius.circular(90.0),
//                                             topLeft: Radius.circular(90.0),
//                                             bottomRight: Radius.circular(300.0))),
//                                         child:  const Center(
//                                           child: Text(
//                                             "Scanne QR Code",
//                                             style: TextStyle(fontSize: 17,color: Colors.white),
//                                           ),
//                                         ),
//                                           ),
//                                       const Icon(Icons.qr_code_2_rounded, size: 35.0)
//                                     ]
//                            ),
//                          ),
//                         ),
//                       ),
//                   ),
//           const SizedBox(height: 20.0,),
//           Text(getResult)
//         ],
//        )
//       ),
//     );
//   }

//   void scanQRCode() async {
//     try {
//         final qrCode = await FlutterBarcodeScanner.scanBarcode("#ff6666", 'Cancel', true , ScanMode.QR);
//         if (!mounted) return ;

//         setState(() {
//           getResult = qrCode;
//         });
//         print("QRCode_Result:--");
//         print(qrCode);
//     }on PlatformException {
//       getResult = 'Failed to scan QR code,';
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:learn/Code%20QR/animation.dart';
import 'package:learn/Code%20QR/codeqr.dart';
import 'package:learn/Equipements/informach.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScanner extends StatefulWidget {
  BarcodeScanner({Key? key}) : super(key: key);

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}


class _BarcodeScannerState extends State<BarcodeScanner>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isScanedOnce = false;

  final Duration delay = const Duration(milliseconds: 700);

  final Duration duration = const Duration(milliseconds: 2800);

  final MobileScannerController cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates, autoStart: true);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: duration)
      ..repeat(reverse: true);
    cameraController.stop();
    isScanedOnce = false;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'Scanne !',
                style: TextStyle(fontFamily: 'NeoSansArabic', fontSize: 15),
                textAlign: TextAlign.left,
              )
            ],
          ),
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.white);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
          ],
        ),
        body: Stack(
          children: [
            MobileScanner(
              controller: cameraController,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;

                if (barcodes.isNotEmpty) {
                  if (isScanedOnce == false) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              InfoMach(docsid: barcodes[0].rawValue!)),
                    );
                    isScanedOnce = true;
                  }
                }
              },
            ),

            QRScannerOverlay(
              overlayColour: Colors.black.withOpacity(.5),
            ),

            ScannerAnimation(
              animation: controller,
              scanningColor: Colors.cyan,
              scanningHeightOffset: 900,
            ),

            // AnimatedPositioned(height: 40,child: Image.asset('assets/images/img_24.png'),duration: Duration(microseconds: 200),),
          ],
          
        ));
        
  }
}
