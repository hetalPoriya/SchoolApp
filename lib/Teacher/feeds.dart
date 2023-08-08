// ignore_for_file: unused_import, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/Teacher/home.dart';
import 'package:school_app/Teacher/single_feed.dart';
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

class TeacherFeeds extends StatefulWidget {
  final String? id;
  final String? name;
  const TeacherFeeds({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<TeacherFeeds> createState() => _TeacherFeedsState();
}

class _TeacherFeedsState extends State<TeacherFeeds> {

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
            onPressed: () => AnimatedNavigation.pushReplacementAnimatedNavigation(
                context, const TeacherHome()),
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
                style: deepPurpleStyle
              ),
              smallSizedBox,
              divider,
          Obx(
                () => teacherFeed.isLoading ==true?
            StudentAppWidgets.loadingWidget():
                DefaultTabController(
                  length: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabBar(
                            // ignore: prefer_const_literals_to_create_immutables
                            tabs: [
                              Tab(text: Strings.dailyFeed,),
                              Tab(text: Strings.others,)
                            ],
                            isScrollable: true,
                            indicator: BoxDecoration(
                              color: Color.fromARGB(255, 238, 220, 241),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            indicatorPadding:
                            EdgeInsets.only(top: 8, bottom: 10, left: 4, right: 4),
                            labelColor: ColorConstants.kHeadingTextColor,
                            labelStyle: mediumStyle,
                            unselectedLabelColor: ColorConstants.kBlackColor,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height -
                                MediaQuery.of(context).size.height * 0.44,
                            child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: TabBarView(
                                  children: [
                                    teacherFeed.events.length == 0?StudentAppWidgets.noDataFound(text: Strings.thereAreNoEventFeeds):
                                    ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: teacherFeed.events.length,
                                      itemBuilder: (context, index) {
                                        return

                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) =>  TeacherSingleFeed(feed: teacherFeed.events[index] ))
                                              );
                                            },
                                            child: Card(
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
                                                        teacherFeed.events[index].title,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: 'Roboto',
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
                                                        .format(teacherFeed.events[index].createdAt),
                                                    style: TextStyle(color: Colors.grey,fontFamily: 'Roboto',),
                                                  ),
                                                  smallerSizedBox,
                                                  Html(
                                                  data: teacherFeed.events[index].message,style: {
                                                    '#': Style(
                                                      fontSize: FontSize(15),
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400,
                                                      maxLines: 2,
                                                      textOverflow: TextOverflow.ellipsis,

                                                    ),
                                                  }, ),

                                                ],
                                              ),
                                            ),
                                        ),
                                          );
                                      },
                                    ),
                                    teacherFeed.others.length == 0?
                                   StudentAppWidgets.noDataFound(text: Strings.thereAreNoOtherFeeds):ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: teacherFeed.others.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) =>  TeacherSingleFeed(feed: teacherFeed.others[index] )),
                                            );
                                          },
                                          child: Card(
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
                                                        teacherFeed.others[index].title,
                                                        style: TextStyle(
                                                            fontFamily: 'Roboto',
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
                                                  smallSizedBox,
                                                  Text(
                                                    DateFormat('dd-MM-yyyy hh:mm  a')
                                                        .format(teacherFeed.others[index].createdAt),
                                                    style: TextStyle(color: Colors.grey,fontFamily: 'Roboto',),
                                                  ),
                                                  smallSizedBox,
                                                  Html(
                                                    data: teacherFeed.others[index].message,style: {
                                                    '#': Style(
                                                      fontSize: FontSize(15),
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w400,
                                                      maxLines: 2,
                                                      textOverflow: TextOverflow.ellipsis,

                                                    ),
                                                  }, ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )),
                          )
                        ]
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