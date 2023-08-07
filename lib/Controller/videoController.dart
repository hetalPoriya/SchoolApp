import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:school_app/Model/teacherVideoModel.dart';
import '../Model/assignmentModel.dart';
import '../Model/videoModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class VideoController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  RxMap videos = {}.obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());
  Future getStuVideos() async {
    try{
      isLoading(true);
      log("Inside Video Controller");
      ToVideoModel toVideoModel = ToVideoModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(videoModelToJson(toVideoModel), "student_videos");
      var data = json.decode(response);
      //log(data);
    
      if(data["error"] == 1) {
        var video_details = videoModelFromJson(response);
        status = RxString(video_details.status);
        error(video_details.error);
        videos(video_details.videos);

        for (var entry in videos.entries) {
          log(entry.key);
          log(entry.value);
          for (var videoentry in entry.value){
            log(videoentry["video_link"]);
          }
        }
      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    }finally{
      isLoading(false);
    }
  }
  Future getTeacherVideos() async {
    try{
      isLoading(true);
      log("Inside Teacher Video Controller");
      ToTeacherVideoModel toVideoModel = ToTeacherVideoModel(teacherId: loginController.teacherId.value);
      var response = await NetworkHandler.post(teacherVideoModelToJson(toVideoModel), "view_uploaded_videos");
      var data = json.decode(response);
      //log(data);
    
      if(data["error"] == 1) {
        var video_details = teacherVideoModelFromJson(response);
        status = RxString(video_details.status);
        error(video_details.error);
        videos(video_details.videos);

        for (var entry in videos.entries) {

          if(entry.value != []){
            for (var videoentry in entry.value){
              log(videoentry["video_link"]);
            }
          }

        }
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