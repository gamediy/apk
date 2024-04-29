import 'package:bet/pages/deposit/confirm/confirm_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../theme/theme_style.dart';

class Confirm extends StatelessWidget {
  const Confirm({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ConfirmLogic());
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          title: Text('${logic.data["protocol"]} Transfer'),
        ),
        body: GetBuilder<ConfirmLogic>(
          builder: (logic) {
            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 1. 金额输入框
                      TextField(
                        controller: logic.amountController,
                        decoration: InputDecoration(labelText: 'Amount'),
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 16.0),
                      // 1. 金额输入框
                      TextField(
                        controller: logic.nameController,
                        enabled: false,
                        decoration: InputDecoration(labelText: 'Name'),
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 18.0, color: Colors.deepPurpleAccent),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              enabled: false,
                              controller: logic.cardNumberController,
                              decoration:
                                  InputDecoration(labelText: 'Card number'),
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.deepPurpleAccent),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.content_copy),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(
                                text: logic.data["address"],
                              ));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Card number copied')),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Column(
                        children: [
                          QrImageView(
                            data: '1234567890',
                            version: QrVersions.auto,
                            size: 150.0,
                          ),
                        ],
                      ),
                      Divider(
                        height: 20,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        child: Text(
                          "Screenshot of successful transfer",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(height: 16.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              logic.pickImage();
                            },
                            child: Obx(
                              () => Container(
                                height: 200,
                                width: 200,
                                decoration: ThemeStyle.BoxBorderRadius,
                                child: logic.imagePath == ""
                                    ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add,
                                              color: Colors.deepPurpleAccent),
                                          Container(
                                            child: Text("Pick Image"),
                                          )
                                        ],
                                      )
                                    : Stack(
                                        children: [
                                          // Image Placeholder (Replace with your image widget)
                                          Image.network(
                                            logic.imagePath.value,
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          ),
                                          // Delete Icon in the top-right corner
                                          Positioned(
                                            top: 2,
                                            right: 2,
                                            child: GestureDetector(
                                              onTap: () {
                                                // Your logic for handling delete icon click
                                                logic.deleteImage();
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Divider(
                        height: 20,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(height: 10.0),

                      // 5. 确认提交按钮
                      MaterialButton(
                        height: 50,
                        onPressed: ()  {
                          logic.confirm();
                        },
                        color: Colors.purple,
                        child: new Text(
                          'Confirm',
                          style: TextStyle(
                              fontSize: ThemeStyle.ButtonFontSize,
                              color: Colors.white),
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(45.0)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
