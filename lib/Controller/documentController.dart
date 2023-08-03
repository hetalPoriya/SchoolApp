import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:school_app/Model/documentModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class DocumentController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  RxMap docdata = {}.obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());
  Future getStuDecument() async {
    try{
      isLoading(true);
      log("Inside Document Controller");
      ToDocumentModel toDocumentModel = ToDocumentModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(documentModelToJson(toDocumentModel), "student_view_documents");
      var data = json.decode(response);
      //log(data);
    
      if(data["error"] == 1){
        var documet_details = documentModelFromJson(response);
        status = RxString(documet_details.status);
        error(documet_details.error);
        docdata(documet_details.data);
        for (var entry in docdata.entries) {
          log(entry.key);
          log(entry.value);
          log(entry.value["year_folder"]);
          log(entry.value["month_folder"][0]["folder_name"]);
          log(entry.value["month_folder"].length);
          log(entry.value["month_folder"][4]["documents"].length);
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