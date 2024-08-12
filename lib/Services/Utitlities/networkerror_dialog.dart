// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomAlertDialog extends StatelessWidget {
  final String message;
  double fontsize;
  String message2;
  Function? onRetry;

  CustomAlertDialog(
      {required this.message,
      required this.fontsize,
      required this.message2,
      this.onRetry});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: 200,
              child: Image.asset(
                'images/no_connection.png',
                color: Colors.white,
              )),
          const Text(
            "Whoops!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              onRetry!();
            },
            child: Text(
              message2,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

// return AlertDialog(
//       content: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.2,
//           width: MediaQuery.of(context).size.width * 0.8,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 message,
//                 style: TextStyle(
//                   fontSize: fontsize ?? 30,
//                   fontFamily: 'Montserrat',
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//               SizedBox(height: 40.0),
//               TextButton(
//                 onPressed: () {
//                   onRetry!();
//                 },
//                 style: TextButton.styleFrom(
//                     backgroundColor: Color.fromRGBO(255, 121, 25, 0.308),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10))),
//                 child: Text(
//                   message2 ?? 'DONE',
//                   style: TextStyle(
//                     color: Color(0xFFFF7919),
//                     fontSize: 18,
//                     fontFamily: 'Montserrat',
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
