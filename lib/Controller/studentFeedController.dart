import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:school_app/Model/studentFeedModel.dart';
import 'package:school_app/Model/teacherFeedModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class StudentFeedController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  var notifications = [].obs;
  var events = [].obs;
  var others = [].obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());
  Future getStuFeed() async {
    try{
      isLoading(true);
      log("Inside Student Feed Controller");
      ToStudentFeedModel toStudentFeedModel = ToStudentFeedModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(studentFeedModelToJson(toStudentFeedModel), "student_feed");
      var data = json.decode(response);
      //log(data);
    
      if(data["error"] == 1){
        var feed_details = studentFeedModelFromJson(response);
        status = RxString(feed_details.status);
        error(feed_details.error);
        notifications(feed_details.notifications);
        events(feed_details.events);
        others(feed_details.others);
        notifications.forEach((item) {
          log('message: ${item.message}');
        });
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    }finally{
      isLoading(false);
    }
  }

  Future getTeacherFeed() async {
    try{
      isLoading(true);
      log("Inside Teacher Feed Controller");
      ToTeacherFeedModel toTeacherFeedModel = ToTeacherFeedModel(teacherId: loginController.teacherId.value);
      var response = await NetworkHandler.post(teacherFeedModelToJson(toTeacherFeedModel), "teacher_feed");
      var data = json.decode(response);
      //log(data);
    
      if(data["error"] == 1){
        var feed_details = teacherFeedModelFromJson(response);
        status = RxString(feed_details.status);
        error(feed_details.error);
        notifications(feed_details.notifications);
        events(feed_details.events);
        others(feed_details.others);
        notifications.forEach((item) {
          log('message: ${item.message}');
        });
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    }finally{
      isLoading(false);
    }
  }
}