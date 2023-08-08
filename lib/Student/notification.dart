// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/notificationController.dart';
import 'package:school_app/Student/edit_profile.dart';
import 'package:school_app/Student/particular_notification_screen.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/network_handler.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';

import '../utils/colors.dart';

class Notifications extends StatefulWidget {
  const Notifications({
    Key? key,
  }) : super(key: key);
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var notificationController = Get.put(NotificationController());
  NetworkHandler nr = NetworkHandler();

  @override
  void initState() {
    _init();
    // TODO: implement initState
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();

    if (isConnected) {
      notificationController.getStuNotification();
    }
    else{
     StudentAppWidgets.noInternetAvailable(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        automaticallyImplyLeading: false,
        child: Padding(
            padding: const EdgeInsets.only(top: 60,),
            child:
            Obx(
            () => notificationController.isLoading ==true?
            StudentAppWidgets.loadingWidget():Column(
              mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                Strings.notification,
                style: titleTextStyle,
              ),
              divider,
              Expanded(
                child:
              MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      // removeBottom: true,
                      // removeBottom: true,
                      child: (notificationController.notifications.length==0 || notificationController.status == Strings.notificationsNotFound)?
                StudentAppWidgets.noDataFound(text: Strings.notificationsNotFound):ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: notificationController.notifications.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  ParticularNotifications(index: index)),
                              );
                            },
                            child: Card(
                              color: ColorConstants.kGreyColor100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    smallerSizedBox,
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          notificationController.notifications[index].title!=null?
                                          notificationController.notifications[index].title:"",
                                          style:const  TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Center(
                                          child: Container(
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                DateFormat('dd/MM/yyyy')
                                                    .format(notificationController.notifications[index].createdAt),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    mediumSizedBox,
                                    Text(
                                      notificationController.notifications[index].message,
                                      maxLines: 2,
                                    ),
                                    smallerSizedBox,
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),),),
                ]
           ))));
        
  }
}