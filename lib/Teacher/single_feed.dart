// ignore_for_file: unused_import, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/Teacher/home.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';

import '../Controller/studentFeedController.dart';
import '../utils/animated_navigation.dart';
import '../utils/network_handler.dart';

class TeacherSingleFeed extends StatefulWidget {
  final dynamic feed;

  const TeacherSingleFeed({Key? key,required this.feed, }) : super(key: key);

  @override
  State<TeacherSingleFeed> createState() => _TeacherSingleFeedState();
}

class _TeacherSingleFeedState extends State<TeacherSingleFeed> {

  DateTime todayDate = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE');
  final DateFormat formatter1 = DateFormat('dMMMM');

  var teacherFeed = Get.put(StudentFeedController());
  NetworkHandler nr = NetworkHandler();

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();

    if (isConnected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        teacherFeed.getTeacherFeed();
      });
    }
    else{
    StudentAppWidgets.noInternetAvailable(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          leading: IconButton(
            alignment: Alignment.topLeft,
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          automaticallyImplyLeading: false,
          toolbarHeight: 160,
          centerTitle: true,
          flexibleSpace: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(90),
              // bottomRight: Radius.circular(20)
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetImages.notification),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          backgroundColor: Color.fromRGBO(55,61,99, 1.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
              //bottomRight: Radius.circular(40),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
          ),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.feedsNotification,
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,

                ),
              ),
              smallSizedBox,
              divider,
              Obx(
                    () => teacherFeed.isLoading ==true?
               StudentAppWidgets.loadingWidget():
                    Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.feed.title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                      BorderRadius.circular(50.0)),
                                ),
                              ],
                            ),
                            smallerSizedBox,
                            Text(
                              DateFormat('dd-MM-yyyy hh:mm  a')
                                  .format(widget.feed.createdAt),
                              style: TextStyle(color: Colors.grey),
                            ),
                            smallerSizedBox,
                            Html(
                              data: widget.feed.message,style: {
                              '#': Style(
                                fontSize: FontSize(15),
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                maxLines: null,
                                textOverflow: TextOverflow.ellipsis,

                              ),
                            }, ),

                          ],
                        ),
                      ),
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}