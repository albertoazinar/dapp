import 'package:flutter/material.dart';

Widget buildCardButton({String title, Function() action, String valueKey}) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: TextButton(
      key: ValueKey(valueKey),
      onPressed: action,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_baseball_outlined,
              color: Colors.blueGrey,
              size: 48,
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
