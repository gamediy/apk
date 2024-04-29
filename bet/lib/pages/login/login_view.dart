import 'package:bet/router/name.dart';
import 'package:bet/theme/theme_style.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:get/get.dart';

import '../../utils/check.dart';
import 'login_logic.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => new _LoginPage();
}

class _LoginPage extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    final logic = Get.put(LoginLogic());
    ToastContext().init(context);
    return new Scaffold(
        body: new Column(
          children: <Widget>[
            new Container(
                padding: EdgeInsets.only(top: 80.0, bottom: 30.0),
                child: new Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.deepPurple, fontSize: 38.0),
                )),

            new Container(
              padding: const EdgeInsets.all(16.0),
              child: new Form(
                key: logic.loginKey,
                autovalidateMode: AutovalidateMode.always,
                child: new Column(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  width: 1.0))),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          labelText: 'Enter email',
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 0, right: 5),
                            child: Icon(Icons.email),
                          ),
                          labelStyle: new TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                          // suffixIcon: new IconButton(
                          //   icon: new Icon(
                          //     Icons.close,
                          //     color: Color.fromARGB(255, 126, 126, 126),
                          //   ),
                          //   onPressed: () {

                          //   },
                          // ),
                        ),
                        keyboardType: TextInputType.phone,
                        onSaved: (value) {
                          logic.userName = value!;
                        },
                        validator: (email) {
                          if (!Check.Email(email)) {
                            return 'Please enter email';
                          }
                        },
                        onFieldSubmitted: (value) {},
                      ),
                    ),
                    new Container(
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  width: 1.0))),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                            labelText: 'Enter password',
                            labelStyle: new TextStyle(
                                fontSize: 15.0,
                                color: Color.fromARGB(255, 93, 93, 93)),
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 0, right: 5),
                              child: Icon(Icons.phonelink_lock),
                            ),
                            suffixIcon: new IconButton(
                              icon: new Icon(
                                logic.isShowPassWord.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color.fromARGB(255, 126, 126, 126),
                              ),
                              onPressed: logic.showPassWord,
                            )),
                        obscureText: !logic.isShowPassWord.value,
                        validator: (password) {
                          if (password?.length == 0) {
                            return 'Please enter password';
                          }
                        },
                        onSaved: (value) {
                          logic.password = value!;
                        },
                      ),
                    ),
                    new Container(
                      height: 45.0,
                      margin: EdgeInsets.only(top: 40.0),
                      child: new SizedBox.expand(
                        child: Obx(
                              ()=> new MaterialButton(
                            onPressed:logic.login,
                            color: Colors.purple,
                            child:  logic.isLoading.value
                                ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ):new Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(45.0)),
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 30.0),
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Get.offAllNamed(Name.Register);
                            },
                            child: new Container(
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: ThemeStyle.ButtonFontSize,
                                    color: Colors.purple),
                              ),
                            ),
                          ),
                          Text(
                            'Forgot password',
                            style: TextStyle(
                                fontSize: ThemeStyle.ButtonFontSize,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  }
}
