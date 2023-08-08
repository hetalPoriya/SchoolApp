import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';

import 'package:school_app/utils/network_handler.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';

import 'package:school_app/utils/utility.dart';
import 'package:school_app/utils/widgets/show_image.dart';

import '../Controller/assesmentCertController.dart';
import '../utils/widgets/shimmerWidget.dart';

class AssesmentCertificate extends StatefulWidget {
  const AssesmentCertificate({Key? key}) : super(key: key);

  @override
  State<AssesmentCertificate> createState() => _AssesmentCertificateState();
}

class _AssesmentCertificateState extends State<AssesmentCertificate> {
  DateTime todayDate = DateTime.now();
  NetworkHandler nr = NetworkHandler();
  var assesmentCertController = Get.put(AssesmentCertController());
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();

    if (isConnected) {
      assesmentCertController.getStuCertificate();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(days: 1),
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.signal_wifi_off,
              color: Colors.white,
            ),
            Expanded(
              child: const Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                ),
                child: Text(
                  Strings.noInternetAvailable,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
            textColor: Colors.white, label: 'RETRY', onPressed: () async {}),
        backgroundColor: Colors.grey,
      ));
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
            Text(Strings.assesmentCertificate, style: titleTextStyle),
            smallSizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd MMMM yyyy').format(DateTime.now()),
                  style: textButtonTextStyle,
                ),
              ],
            ),
            divider,
            const SizedBox(height: 10),
            buildTabBarView(),
          ],
        ),
      ),
    );
    //   ),
    // );
  }

  buildTabBarView() {
    return Obx(() => assesmentCertController.isLoading == true
        ? StudentAppWidgets.loadingWidget()
        : Expanded(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: assesmentCertController.status == "Certificate not found"
                  ? StudentAppWidgets.noDataFound(text: Strings.certificateNotFound)
                  : ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 15,
                            //childAspectRatio: 16 / 9,
                          ),
                          itemCount:
                              assesmentCertController.certificates.length,
                          itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                AnimatedNavigation.pushAnimatedNavigation(
                                  context,
                                  ShowImage(
                                      url: assesmentCertController
                                          .certificates[index].certificateFile),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  smallSizedBox,
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: CachedNetworkImage(
                                          imageUrl: assesmentCertController
                                              .certificates[index]
                                              .certificateFile,
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          placeholder: (context, url) =>
                                              buildShimmer(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                        smallSizedBox,
                      ],
                    ),
            ),
          ));
  }

  Widget buildShimmer() {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ColorConstants.kWhiteColor,
          borderRadius: BorderRadius.circular(10.0)),
      child: Center(
          child: ShimmerWidget.rectangular(
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width,
      )),
    );
  }
}