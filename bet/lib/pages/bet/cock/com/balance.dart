import 'package:bet/theme/theme_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/values.dart';

class Balance extends StatelessWidget {
  const Balance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      height: 25,
      child: Row(
        children: [
          Text(
            "Balance",
            style: TextStyle(
              color: Values.Grey,
              fontSize: 13,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "200",
            style: TextStyle(
                color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold),
          ),
          TextButton(
              onPressed: () {},
              child: Container(
                child: Text("Deposit",style: TextStyle(
                  color: Colors.blueAccent,
                ),),
              ))
        ],
      ),
    );
  }
}
