import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/attendanceController.dart';
import 'package:school_app/Student/subjects.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/network_handler.dart';

class Attendance extends StatefulWidget {
  final String? name;
  const Attendance({Key? key, this.name}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  var attendanceController = Get.put(AttendanceController());
  DateTime todayDate = DateTime.now();
  final DateFormat formatter = DateFormat('EEEE');
  final DateFormat formatter1 = DateFormat('dMMMM');
  NetworkHandler nr = NetworkHandler();

  @override
  void initState() {
    _init();
    attendanceController.getAttendance();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();

    if (isConnected) {
      attendanceController.getAttendance();
    }
    else{
      StudentAppWidgets.noInternetAvailable(context: context);
    }
  }

  nameText() => Text(Strings.attendance.toUpperCase(), style: titleTextStyle);

  dateText() => Text(
        DateFormat('dd MMMM yyyy').format(DateTime.now()),
        style: textButtonTextStyle,
      );

  calendarWidget() => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey, width: 1),
          left: BorderSide(color: Colors.grey, width: 1),
          bottom: BorderSide(color: Colors.grey, width: 1),
          right: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
        child: Obx(
          ()=>attendanceController.isLoading ==true?
          StudentAppWidgets.loadingWidget():TableCalendar(
          rowHeight: 25.0,
          headerVisible: true,
          daysOfWeekHeight: 30.0,
          startingDayOfWeek: StartingDayOfWeek.monday,
          headerStyle: const HeaderStyle(
            titleTextStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
            headerPadding: EdgeInsets.symmetric(horizontal:35),
            formatButtonVisible: false,
            leftChevronVisible: true,
            rightChevronVisible: true,
            titleCentered: true,
          ),
          daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle:
                  TextStyle(color: ColorConstants.kWhiteColor, fontSize: 12.0),
              weekendStyle:
                  TextStyle(color: ColorConstants.kBlackColor, fontSize: 12.0)),
          calendarStyle: const CalendarStyle(
              markerSizeScale: 1.3,
              todayDecoration: BoxDecoration(
                  color: ColorConstants.kHeadingTextColor,
                  shape: BoxShape.circle),
              todayTextStyle:
                  TextStyle(color: ColorConstants.kWhiteColor, fontSize: 12.0),
              selectedTextStyle:
                  TextStyle(color: ColorConstants.kBlackColor, fontSize: 12.0),
              outsideTextStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
              weekendTextStyle:
                  TextStyle(color: ColorConstants.kBlackColor, fontSize: 12.0),
              defaultTextStyle:
                  TextStyle(color: ColorConstants.kBlackColor, fontSize: 12.0)),
          firstDay: DateTime.utc(1999, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay){
              for (var attend in attendanceController.attendance) {
                if(day.day == attend.attendanceDate.day &&
                    day.month == attend.attendanceDate.month &&
                    day.year == attend.attendanceDate.year &&
                attend.status == Strings.present){
                  return Container(
                    padding:
                    const EdgeInsets.only(left: 7, right: 7, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Text(
                      '${attend.attendanceDate.day}',
                      style: const TextStyle(
                          color: ColorConstants.kWhiteColor, fontSize: 12.0),
                    ),
                  );
                }
                else if(day.day == attend.attendanceDate.day &&
                    day.month == attend.attendanceDate.month &&
                    day.year == attend.attendanceDate.year &&
                    attend.status == Strings.absent){
                  return Container(
                    padding:
                    const EdgeInsets.only(left: 7, right: 7, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Text(
                      '${attend.attendanceDate.day}',
                      style: const TextStyle(
                          color: ColorConstants.kWhiteColor, fontSize: 12.0),
                    ),
                  );
                }
                else if(day.day == attend.attendanceDate.day &&
                    day.month == attend.attendanceDate.month &&
                    day.year == attend.attendanceDate.year &&
                    attend.status == Strings.leave){
                  return Container(
                    padding:
                    const EdgeInsets.only(left: 7, right: 7, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Text(
                      '${attend.attendanceDate.day}',
                      style: const TextStyle(
                          color: ColorConstants.kWhiteColor, fontSize: 12.0),
                    ),
                  );
                }
                else if(day.day == attend.attendanceDate.day &&
                    day.month == attend.attendanceDate.month &&
                    day.year == attend.attendanceDate.year &&
                    attend.status == Strings.holiday){
                  return Container(
                    padding:
                    const EdgeInsets.only(left: 7, right: 7, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 5, 52, 90),
                        borderRadius: BorderRadius.circular(50.0)),
                    child: Text(
                      '${attend.attendanceDate.day}',
                      style: const TextStyle(
                          color: ColorConstants.kWhiteColor, fontSize: 12.0),
                    ),
                  );
                }

                //log('status: ${attend.status}');
              }
            },
            /*dowBuilder: (context, day) {
              final text = DateFormat.E().format(day);
              return Center(
                child: Text(
                  text.substring(0, 3).toUpperCase(),
                  style: const TextStyle(color: ColorConstants.kBlackColor),
                ),
              );
            },*/
           
            todayBuilder: (context, date, _) {
              return Container(
                padding:
                    const EdgeInsets.only(left: 7, right: 7, top: 4, bottom: 4),
                decoration: BoxDecoration(
                    color: ColorConstants.kHeadingTextColor,
                    borderRadius: BorderRadius.circular(50.0)),
                child: Text(
                  '${date.day}',
                  style: const TextStyle(
                      color: ColorConstants.kWhiteColor, fontSize: 12.0),
                ),
              );
            },
          ),
        )),
      ));

  calendarContainerWidget() => Container(
      height: MediaQuery.of(context).size.height / 2.4,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(color: Colors.black26)),
      child: calendarWidget());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSizedBox(100.0),
            nameText(),
            smallSizedBox,
            dateText(),
            smallSizedBox,
            divider,
            mediumSizedBox,
            calendarWidget(),
            smallSizedBox,
            Container(
              height: 30,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.only(top: 5, left: 6),
                child: Text(
                  Strings.legend,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.left,
                ),
              ),
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 24, 42, 71)),
            ),
            largeSizedBox,
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50.0)),
                ),
                const SizedBox(width: 3),
                const Text(Strings.present),
                const SizedBox(width: 50),
                Container(
                  padding: const EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50.0)),
                ),
                const SizedBox(width: 3),
                const Text(Strings.absent),
                const SizedBox(width: 50),
                Container(
                  padding: const EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.circular(50.0)),
                ),
                const SizedBox(width: 3),
                const Text(Strings.leave),
              ],
            ),
            largeSizedBox,
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7.0),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 5, 52, 90),
                      borderRadius: BorderRadius.circular(50.0)),
                ),
                const SizedBox(width: 3),
                const Text(Strings.holiday),
              ],
            ),
          ],
        ),
      ),
    );
  }
}