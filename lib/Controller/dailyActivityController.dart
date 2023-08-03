import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:school_app/Model/dailyActivityModel.dart';
import 'package:school_app/Model/stuCounterModel.dart';
import 'package:school_app/Model/stuUpdateCounterModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class DailyActivityController extends GetxController{
  var error = 0.obs;
  var counter_error = false.obs;
  var status = ''.obs;
  var sport_activities = [].obs;
  var other_activities = [].obs;
  var assignmentCount = 0.obs;
  var messageCount = 0.obs;
  var eventCount = 0.obs;
  var certificateCount = 0.obs;
  var otherCount = 0.obs;
  var notification = 0.obs;
  var message = "".obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());


  Future getStuActivity() async {
    try{
      isLoading(true);
      log("Inside Daily Activity Controller");
      ToDailyActivityModel toDailyActivityModel = ToDailyActivityModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(dailyActivityModelToJson(toDailyActivityModel), "student_daily_activity_list");
      var data = json.decode(response);
      //log(data);
    

      if(data["error"] == 1){
        var activity_details = dailyActivityModelFromJson(response);

        log('activity ${activity_details.otherActivities.first.toJson()}');
        status = RxString(activity_details.status);
        error(activity_details.error);
        sport_activities(activity_details.sportActivities);
        other_activities(activity_details.otherActivities);
        sport_activities.forEach((item) {
          log('activity_title: ${item.activityTitle}');
        });
        other_activities.forEach((item) {
          log('other_activities: ${item.activityTitle}');
        });
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
      ToStuCounterModel toStuCounterModel = ToStuCounterModel(student_id: loginController.studentId.value);
      var counter_response = await NetworkHandler.post(stuCounterModelToJson(toStuCounterModel), "student_feed_updates");
      var counter_data = json.decode(counter_response);

      if(counter_error == false){
        var counter_details = stuCounterModelFromJson(counter_response);
        assignmentCount(counter_details.assignmentCount);
        messageCount(counter_details.messageCount);
        eventCount(counter_details.eventCount);
        certificateCount(counter_details.certificateCount);
        otherCount(counter_details.otherCount);
        log("Message Count ${messageCount} ${assignmentCount}");
        message(counter_details.message);
        notification(counter_details.notification);
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    }finally{
      isLoading(false);
    }
  }
  Future stuUpdateCounter(String type) async {
    try{
      log("Inside stuUpdateCounter Controller");
      ToStuUpdateCounterModel toStuUpdateCounterModel = ToStuUpdateCounterModel(studentId: loginController.studentId.value, type: type);
      var response = await NetworkHandler.post(stuUpdateCounterToJson(toStuUpdateCounterModel), "student_feed_counter_updates");
      var data = json.decode(response);
      //log(data);
    
    }finally{
    }
  }
}