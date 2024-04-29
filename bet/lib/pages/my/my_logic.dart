import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/theme_style.dart';

class MyLogic extends GetxController {
   void set() async {
     var cmd = await showMenu(
         color: ThemeStyle.Color1,
         //弹出框的颜色
         shape: const RoundedRectangleBorder(
             borderRadius: BorderRadius.all(
                 Radius.circular(5))),
         //给弹出框添加一个圆角形状
         elevation: 10,
         context: Get.context!,
         position: RelativeRect.fromLTRB(1.sw-100,50,0,0
         ),
         //弹出的位置，默认是在左上角的
         items: <PopupMenuEntry>[
           // value 可以是任何的object ,比如可以是颜色，你点击就可以传递该颜色,返回该颜色的
           PopupMenuItem(

               padding: EdgeInsets.only(left: 10),
               value: "CP",
               child: Text('Change Password')),

           PopupMenuDivider(),
           //下划线
           PopupMenuItem(
               padding: EdgeInsets.only(left: 10),
               value: "SO",
               child: Text('Sign Out')),

           //下划线
         ]);
     if (cmd == "CP") {
       Get.defaultDialog(
           title: "Change Password",
           content: CP());
     }
   }
   Widget CP() {
     GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
     return new Column(
       children: <Widget>[

         Container(
           padding: const EdgeInsets.all(16.0),
           child: new Form(
             key: loginKey,
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
                       labelText: 'Original password',
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
                     onSaved: (value) {},
                     validator: (email) {
                       if (email?.length == 0) {
                         return 'Please enter password';
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
                       labelText: 'New password',
                       labelStyle: new TextStyle(
                           fontSize: 15.0,
                           color: Color.fromARGB(255, 93, 93, 93)),
                       border: InputBorder.none,
                       prefixIcon: Padding(
                         padding: EdgeInsets.only(left: 0, right: 5),
                         child: Icon(Icons.phonelink_lock),
                       ),
                     ),
                     validator: (password) {
                       if (password?.length == 0) {
                         return 'Please enter password';
                       }
                     },
                     onSaved: (value) {},
                   ),
                 ),
                 new Container(
                   height: 45.0,
                   margin: EdgeInsets.only(top: 40.0),
                   child: new SizedBox.expand(
                     child: new MaterialButton(
                       color: Colors.purple,
                       child: new Text(
                         'Sign In',
                         style: TextStyle(
                             fontSize: 14.0,
                             color: Color.fromARGB(255, 255, 255, 255)),
                       ),
                       shape: new RoundedRectangleBorder(
                           borderRadius: new BorderRadius.circular(45.0)),
                       onPressed: () {},
                     ),
                   ),
                 ),
               ],
             ),
           ),
         )
       ],
     );
   }
}
