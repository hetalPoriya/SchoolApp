// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/Student/home_page.dart';
import 'package:school_app/Teacher/home.dart';
//import 'package:school_app/Teacher/home_page.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/network_handler.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';

import 'Controller/loginController.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController addmissionNoController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String email = Strings.email;
  String userName = Strings.userName;
  var loginController = Get.put(LoginController());
  NetworkHandler nr = NetworkHandler();
  String? deviceId;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  var token1;

  @override
  void initState() {
    _messaging.getToken().then((token) {

      token1 = token;
      loginController.androidToken = RxString(token!);
      loginController.iosToken = RxString(token);
    });
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      //var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // unique ID on Android
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showAppBar: false,
      child: Center(child: loginPageBody()),
    );
  }

  Widget loginPageBody() => SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Your School Name',style: greetingTextStyle.copyWith(color: ColorConstants.kGreyColor
                  ),textAlign: TextAlign.center),
                  // Image(
                  //   width: MediaQuery.of(context).size.width / 1.2,
                  //   image: const AssetImage(AssetImages.splashLogo),
                  //),
                  largerSizedBox,
                  TextField(
                    style: mediumStyle,

                    controller: loginController.loginEmailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      prefixIcon: Icon(Icons.mail, color: Colors.grey),
                      hintText: 'Email',


                    ),
                  ),
                  largeSizedBox,
                  TextField(
                    style: mediumStyle,
                    controller: loginController.passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      suffixIcon: InkWell(
                        onTap: () => setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        }),
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.grey),
                      hintText: 'Password',
                    ),
                  ),
                  largeSizedBox,
                  smallerSizedBox,
                  Obx(() => CustomElevatedButton(
                      onPressed: () async {
                        deviceId = await _getId();
                        loginController.deviceId = RxString(deviceId!);
                        log("Device Id: ${deviceId}");
                        bool isConnected = await nr.checkConnectivity();
                        if (isConnected) {
                          await loginController.login();
                          loginController.error.value == 1
                              ? loginController.status.value == "0"
                                  ? Get.offAll(StudentHome())
                                  : Get.offAll(TeacherHome())
                              : ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(loginController.status.value)));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(days: 1),
                            behavior: SnackBarBehavior.floating,
                            content: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.signal_wifi_off,
                                  color: Colors.white,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16.0,
                                    ),
                                    child: Text(
                                      'No internet available',
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            action: SnackBarAction(
                                textColor: Colors.white,
                                label: 'RETRY',
                                onPressed: () async {}),
                            backgroundColor: Colors.grey,
                          ));
                        }
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            Strings.login,
                            style: buttonTextStyle,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Visibility(
                              visible: loginController.isLoading.value,
                              child: SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))),
                        ],
                      ))),
                  CustomTextButton(
                      align: Alignment.center,
                      onPressed: () {},
                      child: Text(
                        Strings.forgotPwd,
                        style: textButtonTextStyle,
                      )),
                ],
              ),
            ),
          ),
        ),
      );
}