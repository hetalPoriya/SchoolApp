// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:typed_data';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:school_app/Controller/pickupCardController.dart';
import 'package:school_app/Student/edit_pickUp_card.dart';
import 'package:school_app/Student/profile_page.dart';
import 'package:school_app/utils/animated_navigation.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/constants.dart';
import 'package:school_app/utils/student/app_widget.dart';
import 'package:school_app/utils/widgets/custom_page.dart';
import 'package:school_app/utils/images.dart';
import 'package:school_app/utils/strings.dart';
import 'package:school_app/utils/utility.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;

import '../Controller/loginController.dart';
import '../utils/network_handler.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class Pickupcard extends StatefulWidget {
  const Pickupcard({Key? key}) : super(key: key);

  @override
  State<Pickupcard> createState() => _PickupcardState();
}

class _PickupcardState extends State<Pickupcard> {
  var pickupCardController = Get.put(PickupCardController());
  NetworkHandler nr = NetworkHandler();
  var loginController = Get.put(LoginController());
  final GlobalKey genKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    _init();
    super.initState();
  }

  _init() async {
    bool isConnected = await nr.checkConnectivity();

    if (isConnected) {
      await pickupCardController.getPickupCard();
    } else {
     StudentAppWidgets.noInternetAvailable(context: context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        automaticallyImplyLeading: false,
        child: ListView(
          //padding:const  EdgeInsets.only(top:20),
          children: [
            // Text("Pickup Card", style: titleTextStyle),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Strings.pickupCard, style: titleTextStyle),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () => AnimatedNavigation.pushAnimatedNavigation(
                        context, const EditPickUpCard()),
                    child: const Icon(
                      Icons.edit,
                      size: 30.0,
                      color: ColorConstants.kHeadingTextColor,
                    ),
                  ),
                )
              ],
            ),
            smallSizedBox,
            Text(
              DateFormat('dd MMMM yyyy').format(DateTime.now()),
              style: textButtonTextStyle,
            ),
            divider,
            buildPickupCard(),
            largeSizedBox,
            largeSizedBox,
            largeSizedBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: CustomElevatedButton(
                onPressed: () {
                  takePicture();
                },
                borderRadius: BorderRadius.circular(20),
                child: Text(
                  Strings.download,
                  style: buttonTextStyle1,
                ),
              ),
            ),
          ],
        ));
  }

  buildPickupCard() {
    return Obx(() => pickupCardController.isLoading == true
        ?StudentAppWidgets.loadingWidget()
        : pickupCardController.status == Strings.pickupCardNotFound
            ? StudentAppWidgets.noDataFound(text: Strings.pickupCardNotFound)
            : RepaintBoundary(
                key: genKey,
                child: Card(
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Image.network(
                            //   pickupCardController.pickup_card_details.isEmpty
                            //       ? ""
                            //       : "https://synramtechnology.com/lahs/storage/app/${pickupCardController.pickup_card_details["student_details"][0]["student_photo"]}",
                            //   height: 60,
                            //   width: 70,
                            //   alignment: Alignment.topLeft,
                            // ),
                            SvgPicture.asset(
                              AssetImages.drawerPickUpCard,
                              height: 60,width: 90,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      Strings.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 30),
                                    Text(
                                      loginController.studentName.value,
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      Strings.classStrings,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 33),
                                    Text(
                                      pickupCardController
                                              .pickup_card_details.isEmpty
                                          ? ""
                                          : pickupCardController
                                                      .pickup_card_details[
                                                  "student_details"][0]
                                              ["class_name"],
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                     Strings.section,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 18),
                                    Text(
                                      pickupCardController
                                              .pickup_card_details.isEmpty
                                          ? ""
                                          : pickupCardController
                                                      .pickup_card_details[
                                                  "student_details"][0]
                                              ["section_name"],
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      Strings.gender,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      pickupCardController
                                              .pickup_card_details.isEmpty
                                          ? ""
                                          : StringUtils.capitalize(
                                              "${pickupCardController.pickup_card_details["student_details"][0]["student_gender"]}"),
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                     Strings.dateOfBirth,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 36),
                                    Text(
                                      pickupCardController
                                              .pickup_card_details.isEmpty
                                          ? ""
                                          : pickupCardController
                                                      .pickup_card_details[
                                                  "student_details"][0]
                                              ["student_dob"],
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        smallSizedBox,
                        const Text(
                          Strings.guardiansDetails,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        smallSizedBox,
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Strings.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              Strings.contact,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            // const SizedBox(width:1),
                            Text(
                              Strings.relation,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              Strings.aadharNo,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        smallSizedBox,
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              pickupCardController.pickup_card_details.isEmpty
                                  ? 0
                                  : pickupCardController
                                      .pickup_card_details["guardian_details"]
                                      .length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  pickupCardController.pickup_card_details[
                                      "guardian_details"][index]["name"],
                                  style: const TextStyle(fontSize: 12),
                                ),
                                // const SizedBox(width:1),
                                Text(
                                  pickupCardController.pickup_card_details[
                                      "guardian_details"][index]["contact"],
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Text(
                                  pickupCardController.pickup_card_details[
                                      "guardian_details"][index]["relation"],
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  pickupCardController.pickup_card_details[
                                      "guardian_details"][index]["aadhar_no"],
                                  style: const TextStyle(fontSize: 12),
                                ),
                                // const SizedBox(width: 4),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )));
  }

  Future<void> takePicture() async {
    final RenderRepaintBoundary boundary =
        genKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }
}