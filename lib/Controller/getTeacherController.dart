import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:school_app/Controller/stuCompMsgController.dart';
import 'package:school_app/Model/getTeacherModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class GetTeacherController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  var teachers = [].obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());
  var stuComposeMsgController = Get.put(StuCompMsgController());
  Future getStuTeacher() async {
    try{
      isLoading(true);
      log("Inside Get Teacher Controller");
      ToGetTeacherModel toGetTeacherModel = ToGetTeacherModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(getTeacherModelToJson(toGetTeacherModel), "get_teachers_of_student");
      var data = json.decode(response);
      //log(data);
    
      if(data["error"] == 1){
        var get_teacher_details = getTeacherModelFromJson(response);
        status = RxString(get_teacher_details.status);
        error(get_teacher_details.error);
        teachers(get_teacher_details.teachers);
        teachers.forEach((item) {
          log('Teacher Name: ${item.teacherName}');
          if(item.teacherType == "Mother Teacher"){
            stuComposeMsgController.teacherController.text = item.teacherName;
            stuComposeMsgController.teacherId = RxString(item.teacherId.toString());
          }
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