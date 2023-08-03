import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/Model/stuCompMsgModel.dart';

import '../Model/loginModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';
class StuCompMsgController extends GetxController {
  var status = "".obs;
  var isLoading = false.obs;
  var error = 0.obs;
  var loginController = Get.put(LoginController());
  var teacherId = "".obs;

  TextEditingController subjectController = TextEditingController();
  TextEditingController teacherController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  Future compMsg() async {
    try{
      isLoading(true);
      log("Inside StuCompMsgController");
      ToStuCompMsgModel toStuCompMsgModel = ToStuCompMsgModel(studentId: loginController.studentId.value, teacherId: int.parse(teacherId.value), title: subjectController.text, message: messageController.text);
      var response = await NetworkHandler.post(stuCompMsgModelToJson(toStuCompMsgModel), "student_send_message");
      var data = json.decode(response);
      //log(data);
    
      if(data["error"] == 1){
        var msg_details = stuCompMsgModelFromJson(response);
        status = RxString(msg_details.status);
        error(msg_details.error);

      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isLoading(false);
      messageController.clear();
      subjectController.clear();
      teacherId = RxString("");
    }
  }

  setTeacherId(Object? val) {
    teacherId = RxString(val.toString());
    //teacherId(val as int);
  }
}