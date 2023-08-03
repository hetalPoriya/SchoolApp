// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/dailyActivityController.dart';
import 'package:school_app/Student/activity_details.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';

import '../utils/colors.dart';

class Activity extends StatefulWidget {
  final String? id;
  final String? name;
  final double? elevation;
  final String? title;
  const Activity({
    Key? key,
    this.id,
    this.name,
    this.elevation,
    required this.title,
  }) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  var dailyActivityController = Get.put(DailyActivityController());
  DateTime todayDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      automaticallyImplyLeading: false,
      child: ListView(children: [
        const Text(
          "Activities",
          style: TextStyle(
              color: Color.fromARGB(255, 145, 92, 236),
              fontWeight: FontWeight.bold,
              fontSize: 40),
        ),
        const SizedBox(height: 5),
        Text(
          DateFormat('dd MMMM yyyy').format(DateTime.now()),
          style: textButtonTextStyle,
        ),
        const SizedBox(height: 10),
        const Divider(
          color: Colors.grey,
        ),
        Obx(() => widget.id == '1'?ListView.builder(
            shrinkWrap: true,
            itemCount: dailyActivityController.sport_activities.length,
            itemBuilder: (context, index) =>
                GestureDetector(
                  onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                      context,
                      ActivityDetails(
                        id: index,
                        from: "sports_activities",
                      )),
                  child:
                  Card(
                    color: ColorConstants.kGreyColor100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(

                                decoration:
                                BoxDecoration(color: ColorConstants.kWhiteColor, borderRadius: BorderRadius.circular(10.0)),
                                child:
                                Center(
                                  child: Image.network(
                                    dailyActivityController.sport_activities[index].activityImage,
                                    width: 80.0,
                                    height: 80.0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dailyActivityController.sport_activities[index].activityTitle,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  smallerSizedBox,
                                  Text(
                                    dailyActivityController.sport_activities[index].activitySubject,

                                    maxLines: null,


                                  ),


                                ],),),

                              Icon(Icons.arrow_forward_ios,color: ColorConstants.kGreyColor),

                            ],
                          ),



                        ],
                      ),
                    ),
                  ),

                ),

              ):
        ListView.builder(
          shrinkWrap: true,
          itemCount: dailyActivityController.other_activities.length,
          itemBuilder: (context, index) =>

              GestureDetector(
                onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                    context,
                    ActivityDetails(
                      id: index,
                      from: "other_activities",
                    )),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(

                              decoration:
                              BoxDecoration(color: ColorConstants.kWhiteColor, borderRadius: BorderRadius.circular(10.0)),
                              child:
                              Center(
                                child: Image.network(
                                  dailyActivityController.other_activities[index].activityImage,
                                  width: 80.0,
                                  height: 80.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 20,),
                            Expanded(child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              Text(
                                dailyActivityController.other_activities[index].activityTitle,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              smallerSizedBox,
                              Text(
                                dailyActivityController.other_activities[index].activitySubject,

                                maxLines: null,


                              ),


                            ],),),

                    Icon(Icons.arrow_forward_ios,color: ColorConstants.kGreyColor),
                           
                          ],
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            )
        ),
      ]),
    );
  }
}
//  return CustomScaffold(
//       showAppBar: true,
//       showDrawer: false,
//       automaticallyImplyLeading: true,
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//              ],
//         ),
//       ),
//     );
//   }
// }