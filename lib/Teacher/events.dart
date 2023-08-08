// // ignore_for_file: unused_import
// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/teacherEventController.dart';
import 'package:school_app/Student/event_details.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/Teacher/add_event.dart';
import 'package:school_app/Teacher/home.dart';
import 'package:school_app/Teacher/teacher_particular_event.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';
import 'package:school_app/utils/widgets/widgets.dart';

class TeacherEvents extends StatefulWidget {
  final String? id;
  final String? name;
  const TeacherEvents({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<TeacherEvents> createState() => _TeacherEventsState();
}

class _TeacherEventsState extends State<TeacherEvents> {
  var teacherEventController = Get.put(TeacherEventController());
  DateTime todayDate = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE');
  final DateFormat formatter1 = DateFormat('dMMMM');

  @override
  void initState() {
    teacherEventController.teacherViewEvent();
    super.initState();
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
            onPressed: () =>
                AnimatedNavigation.pushReplacementAnimatedNavigation(
                    context, const TeacherHome()),
          ),
          toolbarHeight: 150,
          centerTitle: true,
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
              // bottomRight: Radius.circular(20)
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetImages.activity2),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90),
              // bottomRight: Radius.circular(40),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             StudentAppWidgets.addButton(onTap:()=>AnimatedNavigation.pushAnimatedNavigation(
                 context, AddEvent()), text: 'Add Event', title: "Event List"),
              divider,
              Obx(() => teacherEventController.isLoading.value == true
                  ? StudentAppWidgets.loadingWidget()
                  : Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child:teacherEventController.eventList.length == 0 ? StudentAppWidgets.noDataFound(text: 'There are no events ') : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: teacherEventController.eventList.length,
                    itemBuilder: (context, index) {
                      return StudentAppWidgets.eventCard(
                          onTap: () {
                            AnimatedNavigation
                                .pushAnimatedNavigation(
                                context,
                                TeacherParticularEvent(
                                  id: index,
                                ));
                          },
                          title: teacherEventController.eventList[index].title,
                          eventDate:
                          teacherEventController.eventList[index].eventDate,
                          description: teacherEventController
                              .eventList[index].description);
                    },
                  ),
                ),
              ),),
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