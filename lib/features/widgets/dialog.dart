import 'package:flutter/material.dart';

Future<void> showNeedNetwork(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: Color(0xff60C6FF),
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 25, left: 25, right: 25),
        content: const Text(
          'Vui lòng kiểm tra\nkết nối mạng!',
          overflow: TextOverflow.clip,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff60C6FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            child: const Text(
              'OK',
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}
