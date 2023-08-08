// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Student/assignments_inbox.dart';
import 'package:school_app/Student/events_activity.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/Teacher/action_assignment.dart';
import 'package:school_app/Teacher/create_assignment.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';

import '../Controller/assignmentController.dart';
import '../utils/network_handler.dart';

class TeacherAssignments extends StatefulWidget {
  final String? id;
  final String? name;
  const TeacherAssignments({Key? key, this.id, this.name}) : super(key: key);

  @override
  State<TeacherAssignments> createState() => _TeacherAssignmentsState();
}

class _TeacherAssignmentsState extends State<TeacherAssignments> {
  var assignmentController = Get.put(AssignmentController());
  NetworkHandler nr = NetworkHandler();

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();

    if (isConnected) {
      assignmentController.getTeacherAssignment();
    } else {
      StudentAppWidgets.noInternetAvailable(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: DefaultTabController(
          length: 3,
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
                  onPressed: () => Navigator.of(context).pop()),
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
                      image: AssetImage(AssetImages.assignment1),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              backgroundColor: Color.fromRGBO(55, 61, 99, 1.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90),
                  //bottomRight: Radius.circular(40),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Obx(
                () => assignmentController.isLoading == true
                    ? StudentAppWidgets.loadingWidget()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                    Strings.assignment.toUpperCase(),
                              style: titleTextStyle,
                            ),
                          ),
                          smallSizedBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd MMMM yyyy')
                                    .format(DateTime.now()),
                                style: textButtonTextStyle,
                              ),
                              // SvgPicture.asset(AssetImages.search, height: 25),
                              ElevatedButton(
                                onPressed: () =>
                                    AnimatedNavigation.pushAnimatedNavigation(
                                        context, CreateAssignment()),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  primary: Colors.deepPurple,
                                ),
                                child: Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 18.0,
                                    ),
                                    Text(
                                      Strings.addAssignment,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          divider,
                          TabBar(
                            indicatorColor:  Colors.grey,
                            indicatorPadding: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            indicatorSize: TabBarIndicatorSize.tab,

                            tabs:  [
                              Tab(
                                child: Text(Strings.checkedAssignments,
                                    textAlign: TextAlign.center),
                                // text: "Checked \n Assignments",
                              ),
                              Tab(
                                child: Text(Strings.uncheckedAssignments,
                                    textAlign: TextAlign.center),
                              ),
                              Tab(
                                child: Text(Strings.allUploadedAssignments,
                                    textAlign: TextAlign.center),
                              ),
                            ],
                            isScrollable: true,
                            labelColor: ColorConstants.kBlackColor,
                            labelStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            ),
                            unselectedLabelColor: ColorConstants.kBlackColor,
                          ),
                          const SizedBox(height: 10),
                          buildTabBarView(context),
                        ],
                      ),
              ),
            ),
          )),
    );
  }
}

buildTabBarView(context) {
  var assignmentController = Get.put(AssignmentController());
  return Obx(
    () => Expanded(
      child: TabBarView(
        key: ValueKey(DateTime.now().toString()),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          assignmentController.checked_assignments.length == 0
              ? StudentAppWidgets.noDataFound(text: Strings.thereAreNoPendingAssignments)
              : cardWidget(list: assignmentController.checked_assignments),
          assignmentController.unchecked_assignments.length == 0
              ?  StudentAppWidgets.noDataFound(text: Strings.thereAreNoPendingAssignments)
              : cardWidget(list: assignmentController.unchecked_assignments),
          assignmentController.all_assignments.length == 0
              ? StudentAppWidgets.noDataFound(text: Strings.thereAreNoPendingAssignments)
              : cardWidget(list: assignmentController.all_assignments)
        ],
      ),
    ),
  );
}

cardWidget({required RxList list}) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: list.length,
    itemBuilder: (context, index) {
      return InkWell(
        // onTap: () => AnimatedNavigation.pushAnimatedNavigation(
        //     context, AssignmentInbox()),
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AssetImages.folder,
                  height: 30,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "${list[index].assignmentTitle}",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                    smallSizedBox,
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Icon(
                          Icons.class_,
                          color: Colors.pink,
                          size: 18.0,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${Strings.classStrings} ${list[index].className}",
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontSize: 12),
                        ),
                        const SizedBox(width: 20),
                        const Icon(
                          Icons.punch_clock,
                          color: Colors.pink,
                          size: 18.0,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${Strings.section} ${list[index].sectionName}",
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    smallSizedBox,
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Icon(
                          Icons.check,
                          color: Colors.pink,
                          size: 18.0,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${Strings.subject} ${list[index].subjectName}",
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    smallSizedBox,
                    Text(
                      Strings.assignmentDocLink,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.blue,
                          fontSize: 12),
                    )
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
    },
  );
}

noDataFoundWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("assets/no-data.gif"),
      smallSizedBox,
      Text(
        "",
        style: TextStyle(
          color: Colors.purple[800],
          fontFamily: 'Roboto',
        ),
      )
    ],
  );
}