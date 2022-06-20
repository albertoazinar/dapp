import 'package:flutter/material.dart';

Widget buildCardButton(int index,
    {String? title,
    Function()? action,
    String? valueKey,
    String? total,
    String? disponivel}) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: FittedBox(
      fit: BoxFit.scaleDown,
      child: TextButton(
        key: ValueKey(valueKey),
        onPressed: action,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Icon(
                    Icons.local_grocery_store_outlined,
                    size: 50,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 9),
                    child: Text(
                      index.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w700),
                      //
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                '$disponivel/$total',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
