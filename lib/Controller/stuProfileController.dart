import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:school_app/Model/stuProfileModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class stuProfileController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  var student_details = [].obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());
  Future getStuProfile() async {
    try{
      isLoading(true);
      log("Inside Student Profile Controller");
      ToStuProfileModel toStuProfileModel = ToStuProfileModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(stuProfileModelToJson(toStuProfileModel), "student_profile");
      var data = json.decode(response);
      //log(data);
    
      if(data["error"] == 1){
        var profile_details = stuProfileModelFromJson(response);
        status = RxString(profile_details.status);
        error(profile_details.error);
        student_details(profile_details.studentDetails);
        student_details.forEach((item) {
          log('student_name: ${item.studentName}');
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