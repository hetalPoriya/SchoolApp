import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_app/Student/chapter_wise_list.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/utility.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:intl/intl.dart';

class SubjectsWiseList extends StatefulWidget {
  final String subjectName;
  final DateTime date;

  const SubjectsWiseList(
      {Key? key, required this.subjectName, required this.date})
      : super(key: key);

  @override
  State<SubjectsWiseList> createState() => _SubjectsWiseListState();
}

class _SubjectsWiseListState extends State<SubjectsWiseList>
    with SingleTickerProviderStateMixin {
  nameText() => Text(widget.subjectName,
      style: titleTextStyle.copyWith(color: const Color(0xFF536DFE)));

  //
  // dateText() => Text.rich(
  //       TextSpan(
  //         style: textButtonTextStyle.copyWith(
  //             fontSize: 14.0, color: ColorConstants.kGreyColor600),
  //         children: <TextSpan>[
  //           TextSpan(
  //               text: '${formatDay.format(DateTime.now())} ',
  //               style:
  //                   textButtonTextStyle.copyWith(fontWeight: kFontWeightBold)),
  //           TextSpan(text: formatDate.format(DateTime.now())),
  //         ],
  //       ),
  //     );
  //
  // scheduleText() => Text(
  //       "Here is list of schedule you need to check...",
  //       style: textButtonTextStyle.copyWith(
  //           fontSize: 14.0, color: ColorConstants.kGreyColor400),
  //     );
  //
  // tabbarWidget() => DefaultTabController(
  //       length: tabs.length,
  //       child: SizedBox(
  //         height: 30.0,
  //         child: TabBar(
  //           isScrollable: true,
  //           controller: tabController,
  //           indicatorWeight: 0.0,
  //           onTap: (int index) {},
  //           tabs: tabs,
  //           labelColor: const Color(0xFF536DFE),
  //           labelStyle: TextStyle(
  //             fontWeight: kFontWeight900,
  //           ),
  //           unselectedLabelColor: ColorConstants.kBlackColor54,
  //           unselectedLabelStyle: TextStyle(
  //             fontWeight: kFontWeight900,
  //           ),
  //           indicator: BoxDecoration(
  //               gradient: const LinearGradient(colors: [
  //                 Color(0xFFB3E5FC),
  //                 Color(0xFFC5CAE9),
  //               ]),
  //               borderRadius: BorderRadius.circular(50)),
  //         ),
  //       ),
  //     );
  //
  // textWidget(String text, int count) => Text.rich(
  //       TextSpan(
  //         style: textButtonTextStyle,
  //         children: <TextSpan>[
  //           TextSpan(
  //               text: text,
  //               style:
  //                   textButtonTextStyle.copyWith(fontWeight: kFontWeight900)),
  //           TextSpan(
  //               text: " ($count)",
  //               style: textButtonTextStyle.copyWith(
  //                   color: ColorConstants.kGreyColor600)),
  //         ],
  //       ),
  //     );
  //
  // seeAllWidget() => Text(
  //       "See all",
  //       style: subtitleTextStyle,
  //     );
  //
  // todayClassesWidget() => ListView.builder(
  //     padding: EdgeInsets.zero,
  //     shrinkWrap: true,
  //     itemCount: 2,
  //     itemBuilder: (_context, index) => Column(
  //           children: [
  //             Container(
  //               decoration: BoxDecoration(
  //                 color: ColorConstants.kGreyColor100,
  //                 borderRadius: containeBorderRadius,
  //               ),
  //               child: IntrinsicHeight(
  //                 child: Row(
  //                   children: [
  //                     Expanded(
  //                       flex: 2,
  //                       child: Padding(
  //                         padding:
  //                             const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
  //                         child: SizedBox(
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               Text(
  //                                 '07:00',
  //                                 style: textButtonTextStyle.copyWith(
  //                                     fontSize: 16.0,
  //                                     color: ColorConstants.kBlackColor54,
  //                                     fontWeight: kFontWeightBold),
  //                               ),
  //                               Text(
  //                                 "AM",
  //                                 style: textButtonTextStyle.copyWith(
  //                                     fontSize: 14.0,
  //                                     color: ColorConstants.kGreyColor400),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     VerticalDivider(color: ColorConstants.kGreyColor600),
  //                     Expanded(
  //                       flex: 7,
  //                       child: Padding(
  //                         padding:
  //                             const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
  //                         child: SizedBox(
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 'The basic of typograhy',
  //                                 style: textButtonTextStyle.copyWith(
  //                                     fontSize: 18.0,
  //                                     color: ColorConstants.kBlackColor54,
  //                                     fontWeight: kFontWeightBold),
  //                               ),
  //                               smallerSizedBox,
  //                               Row(
  //                                 children: [
  //                                   Icon(Icons.location_on,
  //                                       size: 20.0,
  //                                       color: ColorConstants.kGreyColor400),
  //                                   customWidthSizedBox(5.0),
  //                                   Flexible(
  //                                     child: Text(
  //                                       'Room C1, Faculty of Art & Design',
  //                                       style: textButtonTextStyle.copyWith(
  //                                           fontSize: 14.0,
  //                                           overflow: TextOverflow.ellipsis,
  //                                           color:
  //                                               ColorConstants.kGreyColor400),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               smallerSizedBox,
  //                               Row(
  //                                 children: [
  //                                   Image.asset(
  //                                     AssetImages.teacherProfile,
  //                                     height: 20.0,
  //                                     width: 20.0,
  //                                   ),
  //                                   customWidthSizedBox(5.0),
  //                                   Text(
  //                                     "Teacher Name",
  //                                     style: textButtonTextStyle.copyWith(
  //                                         fontSize: 14.0,
  //                                         overflow: TextOverflow.ellipsis,
  //                                         color: ColorConstants.kGreyColor400),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             mediumSizedBox
  //           ],
  //         ));
  //
  // taskWidget() => SizedBox(
  //       height: 150,
  //       child: ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: 4,
  //           scrollDirection: Axis.horizontal,
  //           itemBuilder: (BuildContext context, int index) {
  //             return Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: Container(
  //                 padding: const EdgeInsets.all(15.0),
  //                 width: 150.0,
  //                 decoration: BoxDecoration(
  //                   color: (index % 2 == 0) ? Colors.red[50] : Colors.green[50],
  //                   borderRadius: containeBorderRadius,
  //                 ),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Deadline',
  //                       style: textButtonTextStyle.copyWith(
  //                           fontSize: 12.0, color: ColorConstants.kGreyColor),
  //                     ),
  //                     Row(
  //                       children: [
  //                         Icon(Icons.lens,
  //                             size: 15.0,
  //                             color:
  //                                 (index % 2 == 0) ? Colors.red : Colors.green),
  //                         customWidthSizedBox(5.0),
  //                         Text(
  //                           '3 days Left',
  //                           maxLines: 2,
  //                           style: textButtonTextStyle.copyWith(
  //                             fontSize: 14.0,
  //                             fontWeight: FontWeight.w500,
  //                             color: ColorConstants.kBlackColor54,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     largeSizedBox,
  //                     Text(
  //                       "The Basic of typogarphy II",
  //                       maxLines: 2,
  //                       style: textButtonTextStyle.copyWith(
  //                         color: ColorConstants.kBlackColor54,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           }),
  //     );

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customSizedBox(100.0),
        nameText(),
        smallSizedBox,
        StudentAppWidgets.elevatedButtonForCalender(selectedDay: widget.date),
        smallSizedBox,
        smallSizedBox,
        listView(),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [nameText(), dateText()],
        // ),
        // smallSizedBox,
        // scheduleText(),
        // smallSizedBox,
        // divider,
        // mediumSizedBox,
        // tabbarWidget(),
        // largerSizedBox,
        // Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [textWidget(Strings.todayClasses, 3), seeAllWidget()]),
        // largeSizedBox,
        // todayClassesWidget(),
        // mediumSizedBox,
        // Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [textWidget(Strings.yourTask, 3), seeAllWidget()]),
        // mediumSizedBox,
        // taskWidget(),
      ],
    ));
  }

  listView() {
    return Expanded(
      child: ListView.builder(
          itemCount: 50,
          padding: EdgeInsets.zero,
          //shrinkWrap: true,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => ChapterWiseList()))),
              child: Column(
                children: [
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                        height: 80.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                        ),
                        child: Container(
                            height: 80.0,
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 12.0, right: 4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text('Chapter 1',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 18.0)),
                                ),
                                smallSizedBox,
                                Flexible(
                                  child: Text(
                                    Strings.equationsAndGeometricalCal,
                                    style: TextStyle(
                                        fontSize: 10.0, color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ))),
                  ),
                  smallSizedBox,
                  smallSizedBox
                ],
              ),
            );
          })),
    );
  }
}