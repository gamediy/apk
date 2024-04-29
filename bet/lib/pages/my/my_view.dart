import 'package:bet/router/name.dart';
import 'package:bet/utils/utils.dart';
import 'package:bet/utils/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../theme/theme_style.dart';
import '../component/bottom.dart';
import 'my_logic.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(MyLogic());
    return GetBuilder<MyLogic>(
      builder: (logic) {
        return Container(
            color: ThemeStyle.BgColor1,
            child: Stack(children: [
              Align(
                alignment: Alignment.topCenter,
                child: ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: 230,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.purpleAccent,
                          Colors.purple,
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "game@gmail.com",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    logic.set();
                                  },
                                  child: Container(
                                    child: Icon(Icons.settings),
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  left: 10,
                  right: 10,
                  top: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: 180,
                      color: ThemeStyle.Color1,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Stack(
                        children: [
                          Positioned(
                              top: 10,
                              left: 10,
                              child: Text(
                                "Balance",
                                style: TextStyle(
                                    fontSize: 20, color: ThemeStyle.txtColor),
                                textAlign: TextAlign.right,
                              )),
                          Positioned(
                              top: 40,
                              left: 0.5.sw-50 ,

                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "₱ 20",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: ThemeStyle.txtColor),
                                    ),
                                  ],
                                ),
                              )),
                          Positioned(
                              bottom: 10,
                              height: 50,
                              left: 0,
                              right: 0,

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MaterialButton(
                                    child: Text(
                                      "Withdraw",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    onPressed: () => Get.toNamed(Name.Withdraw),
                                    color: Colors.blue,
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0)),
                                    minWidth: 120,
                                    height: 60,
                                  ),
                                  MaterialButton(
                                    child: Text(
                                      "Deposit",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    onPressed: () => Get.toNamed(Name.Deposit),
                                    color: Colors.purple,
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0)),
                                    minWidth: 120,
                                    height: 60,
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  top: 300,
                  left: 10,
                  right: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Container(
                      height: 300,
                      width: 0.6.sw,
                      color: ThemeStyle.BgColor1,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      "Bet order",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                    new Icon(Icons.chevron_right),
                                  ],
                                ),
                                leading: FaIcon(FontAwesomeIcons.bahtSign),
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black12)),
                              ),
                            ),
                            Container(
                              child: ListTile(
                                onTap: () {
                                  Get.toNamed(Name.DepositRecord);
                                },
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      "Deposit order",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                    new Icon(Icons.chevron_right),
                                  ],
                                ),
                                leading: FaIcon(FontAwesomeIcons.deploydog),
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black12)),
                              ),
                            ),
                            Container(
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      "Withdraw record ",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                    new Icon(Icons.chevron_right),
                                  ],
                                ),
                                leading: FaIcon(FontAwesomeIcons.receipt),
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black12)),
                              ),
                            ),
                            Container(
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      "Address",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                    new Icon(Icons.chevron_right),
                                  ],
                                ),
                                leading: FaIcon(FontAwesomeIcons.addressBook),
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black12)),
                              ),
                            ),
                            Container(
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      "Bet record ",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                    new Icon(Icons.chevron_right),
                                  ],
                                ),
                                leading: FaIcon(FontAwesomeIcons.receipt),
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black12)),
                              ),
                            ),
                            Container(
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Text(
                                      "Bet record ",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                    new Icon(Icons.chevron_right),
                                  ],
                                ),
                                leading: FaIcon(FontAwesomeIcons.receipt),
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black12)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
            ]));
      },
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
