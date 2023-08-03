import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:school_app/Model/pickupCardModel.dart';
import '../Model/assignmentModel.dart';
import '../utils/network_handler.dart';
import 'loginController.dart';

class PickupCardController extends GetxController{
  var error = 0.obs;
  var status = ''.obs;
  var pickup_card_details = {}.obs;
  var isLoading = false.obs;
  var loginController = Get.put(LoginController());
  Future getPickupCard() async {
    try{
      isLoading(true);
      log("Inside Pickup Card Controller");
      ToPickupCardModel toPickupCardModel = ToPickupCardModel(studentId: loginController.studentId.value);
      var response = await NetworkHandler.post(pickupCardModelToJson(toPickupCardModel), "student_pickup_card");
      var data = json.decode(response);
    
      if(data["error"] == 1){
        var pickupcard_details = pickupCardModelFromJson(response);
        status = RxString(pickupcard_details.status);
        error(pickupcard_details.error);
        pickup_card_details(pickupcard_details.pickupCardDetails);
        log(pickup_card_details["guardian_details"].length);
        for (var entry in pickup_card_details.entries) {
          log(entry.key);
          log(entry.value);
          //log(entry.value[0]["teacher_approved"]);
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