import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/Model/teacherLoginModel.dart';

import '../Model/loginModel.dart';
import '../utils/network_handler.dart';

class LoginController extends GetxController {
  var status = "".obs;
  var details = [].obs;
  var siblingStatus = "".obs;
  var teacherId = 0.obs;
  var teacherName = "".obs;
  var studentId = 0.obs;
  var studentName = "".obs;
  var siblingId = 0.obs;
  var addmissionId = "".obs;
  var email = "".obs;
  var className = "".obs;
  var sectionName = "".obs;
  var gender = "".obs;
  var dob = DateTime.now().obs;
  var contactNo = "".obs;
  var picture = "".obs;
  var siblingDetails = [].obs;
  var isLoading = false.obs;
  var error = 0.obs;
  var loginEmail = "".obs;
  var loginPassword = "".obs;
  var deviceId = "".obs;
  var androidToken = "".obs;
  var iosToken = "".obs;
  var bearerToken = "".obs;

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future login() async {
    try{
      isLoading(true);
      log("Inside Login Controller");
      ToLoginModel toLoginModel = ToLoginModel(email: loginEmailController.text, password: passwordController.text, androidToken: androidToken.value, iosToken: iosToken.value, deviceId: deviceId.value);
      var response = await NetworkHandler.post(loginModelToJson(toLoginModel), "new_login");
      log('Response ${response.toString()}');
      var data = json.decode(response);
      //log(data);
    
      error(data["error"]);
      if(data["error"] == 1 && data["status"] == "0"){
        log("Inside Student Controller");
        var user_details = loginModelFromJson(response);
        status = RxString(user_details.status);
        siblingStatus = RxString(user_details.siblingStatus);
        studentId(user_details.details.studentId);
        studentName = RxString(user_details.details.studentName);
        email = RxString(user_details.details.email);
        className = RxString(user_details.details.className);
        sectionName = RxString(user_details.details.sectionName);
        gender = RxString(user_details.details.gender);
        dob(user_details.details.dob);
        addmissionId = RxString(user_details.details.addmissionId);
        siblingId(user_details.details.siblingId);
        siblingDetails(user_details.siblingDetails);
        error(user_details.error);
        bearerToken(user_details.token.plainTextToken);

        log("error $error");
        error.refresh();
        log("error $status");

        NetworkHandler.storeToken("bearerToken",bearerToken.value);
        NetworkHandler.storeToken("emailToken",loginEmailController.text);
        NetworkHandler.storeToken("passwordToken",passwordController.text);
        NetworkHandler.storeToken("androidToken",androidToken.value);
        NetworkHandler.storeToken("iosToken",iosToken.value);
        NetworkHandler.storeToken("deviceId",deviceId.value);
      }
      else if(data["error"] == 1 && data["status"] == "1"){
        log("Inside Teacher Controller");

        var user_details = teacherLoginModelFromJson(response);
        log('User ${user_details.toJson()}');
        if(user_details.details != null){
          status = RxString(user_details.status ?? '');
          siblingStatus = RxString(user_details.siblingStatus ?? '');


          log('Teacher ${user_details.details?.teacherId ?? ''}');

          teacherId(user_details.details?.teacherId);
          teacherName = RxString(user_details.details?.teacherName ?? '');
          email = RxString(user_details.details?.email ?? '');
          className = RxString(user_details.details?.className ?? '');
          sectionName = RxString(user_details.details?.sectionName ?? '');
          gender = RxString(user_details.details?.gender ??'');
          dob(user_details.details?.dob );
          contactNo = RxString(user_details.details?.contactNo ?? '');
          picture = RxString(user_details.details?.picture ?? '');
          bearerToken(user_details.token?.plainTextToken ?? '');
          //siblingDetails(user_details.siblingDetails);
          error(user_details.error);
          log("errorTea $error");
          error.refresh();

          //log(siblingStatus);
          NetworkHandler.storeToken("bearerToken",bearerToken.value);
          NetworkHandler.storeToken("emailToken",loginEmailController.text);
          NetworkHandler.storeToken("passwordToken",passwordController.text);
          NetworkHandler.storeToken("androidToken",androidToken.value);
          NetworkHandler.storeToken("iosToken",iosToken.value);
          NetworkHandler.storeToken("deviceId",deviceId.value);
        }

      }
      else{
        error(int.parse(data["error"]));
        status(data["status"]);
      }
    } finally {
      isLoading(false);
    }
  }

  Future switchProfile(int sibling_id) async {
    try{
      isLoading(true);
      log("Inside SwitchProfile Controller");
      SwitchProfileModel switchProfileModel = SwitchProfileModel(sibling_id: sibling_id);
      var response = await NetworkHandler.post(switchProfileModelToJson(switchProfileModel), "new_login");
      var data = json.decode(response);
      //log(data);
    
      if(data["error"] == 1){
        var user_details = loginModelFromJson(response);
        status = RxString(user_details.status);
        siblingStatus = RxString(user_details.siblingStatus);
        studentId(user_details.details.studentId);
        studentName = RxString(user_details.details.studentName);
        email = RxString(user_details.details.email);
        className = RxString(user_details.details.className);
        sectionName = RxString(user_details.details.sectionName);
        gender = RxString(user_details.details.gender);
        dob(user_details.details.dob);
        addmissionId = RxString(user_details.details.addmissionId);
        siblingId(user_details.details.siblingId);
        siblingDetails(user_details.siblingDetails);
        error(user_details.error);
        bearerToken(user_details.token.plainTextToken);

      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isLoading(false);
    }
  }

  Future loggedin() async {
    try{
      isLoading(true);
      log("Inside loggedin Controller");
      ToLoginModel toLoginModel = ToLoginModel(email: loginEmail.value, password: loginPassword.value, androidToken: androidToken.value, iosToken: iosToken.value, deviceId: deviceId.value);
      var response = await NetworkHandler.post(loginModelToJson(toLoginModel), "new_login");
      var data = json.decode(response);

      if(data["error"] == 1 && data["status"] == "0"){
        log("Inside Student Controller");
        var user_details = loginModelFromJson(response);
        status = RxString(user_details.status);
        siblingStatus = RxString(user_details.siblingStatus);
        studentId(user_details.details.studentId);
        studentName = RxString(user_details.details.studentName);
        email = RxString(user_details.details.email);
        className = RxString(user_details.details.className);
        sectionName = RxString(user_details.details.sectionName);
        gender = RxString(user_details.details.gender);
        dob(user_details.details.dob);
        addmissionId = RxString(user_details.details.addmissionId);
        siblingId(user_details.details.siblingId);
        siblingDetails(user_details.siblingDetails);
        error(user_details.error);
        bearerToken(user_details.token.plainTextToken);
        log("Token "+user_details.token.plainTextToken);

        // log('Lenghe ${siblingDetails.value.toString()}');
        // if(siblingDetails.value != []){
        //   for(var i=0; i<siblingDetails.length; i++){
        //     log(siblingDetails[i][0].studentName);
        //   }
        // }

      }
      else if(data["error"] == 1 && data["status"] == "1"){
        log("Inside Teacher Controller");
        var user_details = teacherLoginModelFromJson(response);

        status = RxString(user_details.status?? "");
        teacherId(user_details.details?.teacherId ?? 0);
        teacherName = RxString(user_details.details?.teacherName ?? '');
        email = RxString(user_details.details?.email?? '');
        className = RxString(user_details.details?.className ?? '');
        sectionName = RxString(user_details.details?.sectionName ?? '');
        gender = RxString(user_details.details?.gender ?? '');
        dob(user_details.details?.dob);
        contactNo = RxString(user_details.details?.contactNo ?? '');
        picture = RxString(user_details.details?.picture ?? '');
        bearerToken(user_details.token?.plainTextToken);
        error(user_details.error);

      }
      else{
        error(data["error"]);
        status(data["status"]);
      }
    } finally {
      isLoading(false);
    }
  }
}