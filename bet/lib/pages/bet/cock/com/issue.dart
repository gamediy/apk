import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CockIssue extends StatefulWidget {
  const CockIssue({super.key});

  @override
  State<CockIssue> createState() => _CockIssueState();
}

class _CockIssueState extends State<CockIssue> {
  CountdownController cController = new CountdownController(autoStart: true);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: 50,
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "201",
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Countdown(
                controller: cController!,
                seconds: 250,
                build: (BuildContext context, double time) => Container(
                    height: 30,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Text(
                      time.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                interval: Duration(milliseconds: 1000),
                onFinished: () {},
              ),
              Text(
                "start",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 18),
              )
            ],
          )),
    ]);
  }
}
