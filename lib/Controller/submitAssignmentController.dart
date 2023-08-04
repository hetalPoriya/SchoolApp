import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/Model/stuCompMsgModel.dart';
import 'package:school_app/Model/submitAssignmentModel.dart';

import '../Model/loginModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class SubmitAssignmentController extends GetxController {
  var status = "".obs;
  var isLoading = false.obs;
  var error = 0.obs;
  var loginController = Get.put(LoginController());
  var assignmentId = "".obs;
  var assignDoc = <File>[].obs;

  TextEditingController decriptionController = TextEditingController();


  Future submitAssi() async {
    try {
      isLoading(true);
      log("Inside SubmitAssignmentController");
      //TosubmitAssignmentModel tosubmitAssignmentModel = TosubmitAssignmentModel(studentId: loginController.studentId.value, assignmentId: int.parse(assignmentId.value), description: decriptionController.text, assignDoc: assignDoc);
      var response = await NetworkHandler.postForm(
          assignDoc,
          "submit_assignment",
          int.parse(assignmentId.value),
          loginController.studentId.value,
          decriptionController.text);
      var data = json.decode(response);
      //log(data);
    
      if (data["error"] == 1) {
        var submit_details = submitAssignmentModelFromJson(response);
        status = RxString(submit_details.status);
        error(submit_details.error);

      } else {
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isLoading(false);
      decriptionController.clear();
      assignmentId = RxString("");
    }
  }

  //teacher side
  Future createAssi() async {
    try {
      isLoading(true);
      log("Inside CreateAssignmentController");
      //TosubmitAssignmentModel tosubmitAssignmentModel = TosubmitAssignmentModel(studentId: loginController.studentId.value, assignmentId: int.parse(assignmentId.value), description: decriptionController.text, assignDoc: assignDoc);
      var response = await NetworkHandler.postForm(
          assignDoc,
          "submit_assignment",
          int.parse(assignmentId.value),
          loginController.studentId.value,
          decriptionController.text);
      var data = json.decode(response);
      //log(data);

      if (data["error"] == 1) {
        var submit_details = submitAssignmentModelFromJson(response);
        status = RxString(submit_details.status);
        error(submit_details.error);

      } else {
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isLoading(false);
      decriptionController.clear();
      assignmentId = RxString("");
    }
  }

  setvalues(Object? assiId, List<File>? assignDocument) {

    assignmentId = RxString(assiId.toString());
    assignDoc(assignDocument);
  }
}