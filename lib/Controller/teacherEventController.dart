import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:school_app/Controller/loginController.dart';
import 'package:school_app/Model/teacherAssignmentModel.dart';
import 'package:school_app/Model/teacherVideoModel.dart';
import 'package:school_app/Model/teacherViewEventModel.dart';
import 'package:school_app/utils/network_handler.dart';

class TeacherEventController extends GetxController{

  var error = 0.obs;
  var status = ''.obs;
  var isLoading = false.obs;
   var eventList = [].obs;
  var loginController = Get.put(LoginController());

  Future teacherViewEvent() async {
    try {
      isLoading(true);
      log("Inside teacherViewEvent Controller");
      ToTeacherVideoModel toTeacherVideoModel = ToTeacherVideoModel(teacherId: loginController.teacherId.value);
      var response = await NetworkHandler.post(
          teacherVideoModelToJson(toTeacherVideoModel),
          "teacher_view_event");
      var data = json.decode(response);
      //log(data);

      if (data["error"] == 1) {
        var data_details = teacherViewEventModelFromJson(response);
        status = RxString(data_details.status ?? '');
        error(data_details.error);
        eventList(data_details.calenderEvents);
        isLoading(false);
      } else {
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isLoading(false);
    }
  }

  Future teacherAddEvent({required String title,required String description,required String date}) async {
    try {
      isLoading(true);
      log("Inside teacherAddEvent Controller");
      ToTeacherAddEventModel toTeacherAddEventModel = ToTeacherAddEventModel(teacherId: loginController.teacherId.value,description: description,title: title,eventDate: date);
      var response = await NetworkHandler.post(
          toTeacherAddEventModelToJson(toTeacherAddEventModel),
          "teacher_store_event");
      var data = json.decode(response);
      //log(data);

      if (data["error"] == 1) {
        var data_details = teacherViewEventModelFromJson(response);
        status = RxString(data_details.status ?? '');
        error(data_details.error);
       Get.back();
        isLoading(false);
      } else {
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isLoading(false);
    }
  }
}