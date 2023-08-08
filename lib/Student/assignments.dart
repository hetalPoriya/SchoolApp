// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Student/assignments_inbox.dart';
import 'package:school_app/Student/events_activity.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/Student/todays_work.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/network_handler.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';

import '../Controller/assignmentController.dart';

class Assignments extends StatefulWidget {
  final String? name;
  const Assignments({Key? key, this.name}) : super(key: key);

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
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
      assignmentController.getStuAssignment();
    } else {
      StudentAppWidgets.noInternetAvailable(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: CustomScaffold(
            automaticallyImplyLeading: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 10),
              child: Obx(
                () => assignmentController.isLoading == true
                    ? StudentAppWidgets.loadingWidget()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.myAssignments,
                            style: titleTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd MMMM yyyy')
                                    .format(DateTime.now()),
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 16),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    AnimatedNavigation.pushAnimatedNavigation(
                                        context,
                                        TodaysWork(
                                          name: Strings.todayWorkLowercase,
                                        )),
                                child: SvgPicture.asset(
                                  AssetImages.calendar,
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                          divider,
                          const TabBar(
                            tabs: [
                              Tab(
                                text: Strings.pendingAssignment,
                              ),
                              Tab(
                                text: Strings.submittedAssignment,
                              ),
                              Tab(
                                text: Strings.pastAssignment,
                              ),
                            ],
                            isScrollable: true,
                            labelColor: ColorConstants.kBlackColor,
                            labelStyle: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            unselectedLabelColor: ColorConstants.kBlackColor,
                          ),
                          const SizedBox(height: 10),
                          buildTabBarView(context),
                        ],
                      ),
              ),
            )));
  }
}

buildTabBarView(context) {
  var assignmentController = Get.put(AssignmentController());
  return Expanded(
    child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Obx(() => TabBarView(
            key: ValueKey(DateTime.now().toString()),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              assignmentController.pending_assignments.length == 0
                  ? StudentAppWidgets.noDataFound(
                      text: Strings.noPendingAssignment)
                  : listView(
                      list: assignmentController.pending_assignments,
                      navigatorString: 'pending_assignments'),
              assignmentController.submitted_assignments.length == 0
                  ? StudentAppWidgets.noDataFound(
                      text: Strings.noSubmittedAssignment)
                  : listView(
                      list: assignmentController.submitted_assignments,
                      navigatorString: 'submitted_assignments'),
              assignmentController.past_assignments.length == 0
                  ? StudentAppWidgets.noDataFound(
                      text: Strings.noPastAssignment)
                  : listView(
                      list: assignmentController.past_assignments,
                      navigatorString: 'past_assignments')
            ],
          )),
    ),
  );
}

listView({required RxList list, required String navigatorString}) =>
    ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => AnimatedNavigation.pushAnimatedNavigation(
              context,
              AssignmentInbox(
                id: index,
                name: navigatorString,
              )),
          child: Card(
            color: ColorConstants.kGreyColor100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        list[index].subjectName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      /*const Text(
                              "Xyz",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )*/
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 45.0,
                    width: 1.0,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        list[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy HH:mm')
                            .format(list[index].expireAt),
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        Strings.assignmentDocLink,
                        style: TextStyle(color: Colors.blue, fontSize: 12),
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