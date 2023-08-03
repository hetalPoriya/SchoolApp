// ignore_for_file: unnecessary_import

import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/Teacher/home.dart';
import 'package:school_app/login_page.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/utility.dart';
//import 'package:little_angels/welcome_page.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/widgets/custom_splashpage.dart';

import 'Controller/loginController.dart';
import 'Student/home_page.dart';
import 'utils/colors.dart';
import 'utils/network_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var loginController = Get.put(LoginController());
  var isToken;
  var isPassToken;
  var androidToken;
  var iosToken;
  var deviceIdToken;
  var route_val;
  NetworkHandler nr = NetworkHandler();

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();

    if (isConnected) {
      checkLogin();
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(days: 1),
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.signal_wifi_off,
              color: Colors.white,
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                ),
                child: const Text(
                  'No internet available',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
            textColor: Colors.white, label: 'RETRY', onPressed: () async {}),
        backgroundColor: Colors.grey,
      ));
    }
  }

  checkLogin() async {
    log("inside check login");
    isToken = await NetworkHandler.getToken("emailToken");
    isPassToken = await NetworkHandler.getToken("passwordToken");
    androidToken = await NetworkHandler.getToken("androidToken");
    iosToken = await NetworkHandler.getToken("iosToken");
    deviceIdToken = await NetworkHandler.getToken("deviceId");
    if(isToken != null){
      loginController.loginEmail(isToken);
      loginController.loginPassword(isPassToken);
      loginController.androidToken(androidToken);
      loginController.iosToken(iosToken);
      loginController.deviceId(deviceIdToken);
      log("token email is");

      await loginController.loggedin();
      //log("error");
      //log(loginController.error.value);
      (loginController.error.value == 1 && !loginController.isLoading.value && loginController.status.value == "0") ?
      setState((){
        route_val = const StudentHome();
      }):
      (loginController.error.value == 1 && !loginController.isLoading.value && loginController.status.value == "1") ?
      setState((){
        route_val = const TeacherHome();
      }):
      setState((){
        route_val = const LoginPage();
      }
      );
    }
    else{
      setState((){
        route_val = const LoginPage();
      }
      );
    }
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    return AnimatedNavigation.pushReplacementAnimatedNavigation(
        context, route_val);
  }

  @override
  Widget build(BuildContext context) {
    return CustomSplashScaffold(
      showAppBar: false,
      child: Center(
        child: Text('Your School Name',style: greetingTextStyle.copyWith(color: ColorConstants.kGreyColor
        ),textAlign: TextAlign.center),
        // child: Image.asset(
        //   AssetImages.splashLogo,
        //   width: MediaQuery.of(context).size.width / 1.2,
        // ),
      ),
    );
  }
}