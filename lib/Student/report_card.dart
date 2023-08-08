// ignore_for_file: unused_import

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/reportCardController.dart';
import 'package:school_app/Student/change_request.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/network_handler.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';
import 'package:school_app/utils/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/widgets/show_image.dart';

class ReportCard extends StatefulWidget {
  const ReportCard({Key? key}) : super(key: key);

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  DateTime todayDate = DateTime.now();
  var reportCardController = Get.put(ReportCardController());
  NetworkHandler nr = NetworkHandler();

  @override
  void initState() {
    // TODO: implement initState
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();

    if (isConnected) {
      reportCardController.getStuReportCard();
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
        padding: const EdgeInsets.only(top: 60, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Strings.reportCard, style: titleTextStyle),
            smallSizedBox,
            Text(
              DateFormat('dd MMMM yyyy').format(DateTime.now()),
              style: textButtonTextStyle,
            ),
            divider,
            mediumSizedBox,
        Expanded(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Obx(
                  () => reportCardController.isLoading ==true?
              StudentAppWidgets.loadingWidget():
                  (reportCardController.report_card.length==0 || reportCardController.status == Strings.reportCardNotFound )?
            StudentAppWidgets.noDataFound(text: Strings.reportCardNotFound): ListView(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    //childAspectRatio: 16 / 9,
                  ),
                  itemCount: reportCardController.report_card.length,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        AppWidget.launchUrlWidget(reportCardController.report_card[index].reportCardFile);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          largeSizedBox,
                          SizedBox(
                              height: MediaQuery.of(context).size.height/5.7,
                            child:
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  "assets/pdf-file.png",
                                  fit: BoxFit.fill,
                                  //height: MediaQuery.of(context).size.height/6,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ],
                          ),
                            ),
                          ),
                          )
                        ],
                      )
                  ),
                ),
                largeSizedBox,
              ],
            ),
          ),
          )
        ),
            smallSizedBox,
            /*Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Download",
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        primary: const Color.fromRGBO(105, 80, 255, 1.0),
                      ),
                    ),
                    //SizedBox(height: 10),
                  ],
                ),
              ),
            ),*/
           
      ],
      ),
      ),
      );
    //   ),
    // );
  }

}