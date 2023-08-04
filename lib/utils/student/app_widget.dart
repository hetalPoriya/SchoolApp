import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:school_app/Controller/dailyActivityController.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/utility.dart';
import 'package:intl/intl.dart';
import 'package:school_app/utils/widgets/shimmerWidget.dart';
import 'package:badges/badges.dart' as badges;

class StudentAppWidgets {
  static Widget todaysWorkContainer(
          {required String subjectName, required String description}) =>
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${subjectName}",
                style: TextStyle(
                    color: Colors.grey.shade600, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 4.0,
              ),
              const Text(
                // "(${todaysWorkController.todayWork[i].})",
                "(Sunita mam)",
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
              const SizedBox(
                width: 4.0,
              ),
              const Text(
                // "(${todaysWorkController.todayWork[i].})",
                "5h ago",
                style: TextStyle(color: Colors.grey, fontSize: 8.0),
              ),
            ],
          ),
          smallSizedBox,
          Text(
            "${description}",
            style: const TextStyle(fontSize: 12.0, color: Colors.grey),
            textAlign: TextAlign.start,
          )
        ]),
      );

  static Widget elevatedButtonForCalender({required DateTime selectedDay}) =>
      CustomElevatedButton(
        endColor: Colors.blue,
        beginColor: Colors.blue,
        height: 45.0,
        width: double.infinity,
        onPressed: () {},
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('EEEE').format(selectedDay).toString()),
            Text(DateFormat('dd MMM yyyy').format(selectedDay).toString()),
          ],
        ),
      );

  static Widget homeScreenBadgeTabs(
          {required BuildContext context,
          required VoidCallback onTap,
          required String icon,
          required String text,
          required DailyActivityController dailyActivityController,
          required showBadgeOrNot,
          required String badgeText,
          required List<Color> color}) =>
      InkWell(
        splashColor: ColorConstants.kTransparentColor,
        highlightColor: ColorConstants.kTransparentColor,
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: color),
                borderRadius: containeBorderRadius,
              ),
              child: Obx(() => dailyActivityController.isLoading.value
                  ? ShimmerWidget.rectangular(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    )
                  : badges.Badge(
                      showBadge: showBadgeOrNot,
                      badgeContent: SizedBox(
                          width: 20, //height: 20, //badge size
                          child: Center(
                            //aligh badge content to center
                            child: Text(badgeText,
                                style: const TextStyle(
                                    color: Colors.white, //badge font color
                                    fontSize: 20 //badge font size
                                    )),
                          )),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              icon,
                              width: 50.0,
                              height: 50.0,
                            ),
                            Text(
                              text,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: buttonTextStyle,
                            ),
                          ],
                        ),
                      ),
                    )),
            )),
      );
  static Widget homeScreenTabs(
          {required BuildContext context,
          required VoidCallback onTap,
          required String icon,
          required String text,
          required DailyActivityController dailyActivityController,
          bool? isSvg,
          required List<Color> color}) =>
      InkWell(
        splashColor: ColorConstants.kTransparentColor,
        highlightColor: ColorConstants.kTransparentColor,
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 10.0, 8.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: color),
                borderRadius: containeBorderRadius,
              ),
              child: Obx(
                () => dailyActivityController.isLoading.value
                    ? ShimmerWidget.rectangular(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isSvg == true
                              ? SvgPicture.asset(
                                  icon,
                                  width: 45.0,
                                  height: 45.0,
                                )
                              : Image.asset(
                                  icon,
                                  width: 50.0,
                                  height: 50.0,
                                ),
                          Text(
                            text,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: buttonTextStyle,
                          ),
                        ],
                      ),
              ),
            )),
      );

  static titleTextMarked({required String text}) => Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          children: [
            Text(text, style: mediumStyle),
            const Icon(
              Icons.star,
              size: 8,
              color: Colors.red,
            )
          ],
        ),
      );

  static titleText({required String text}) => Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Text(text, style: mediumStyle),
      );

  static textFormFieldWidget(
          {required String hintText,
          required TextEditingController textEditingController,
          Widget? suffixIcon,
          VoidCallback? onTap,
            TextInputAction? textInputAction,
            TextInputType? keyboardType,
          bool? readOnly,String? Function(String?)? validator}) =>
      TextFormField(
        controller: textEditingController,
        onTap: onTap,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        readOnly: readOnly ?? false,
        textInputAction: textInputAction ??TextInputAction.next,
        keyboardType: keyboardType ??TextInputType.text,
        decoration: InputDecoration(
          focusColor: Colors.white,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.only(left: 12.0),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(10),
          ),

          hintText: hintText,
        ),
      );

  static calenderView(
          {required BuildContext context,
          DateTime? dateTime,
          TextEditingController? dateController}){
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2040),

      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(


              textTheme: TextTheme( displayMedium:mediumStyle.copyWith(color: Colors.black) ),
              colorScheme: ColorScheme.light(
                primary: ColorConstants.calenderColor, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: Colors.black, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor:ColorConstants.calenderColor, // button text color
                ),
              ),
            ),
            child: child!);
      },
    ).then((date) {
      dateTime = date!;
      dateController?.text =
          DateFormat('dd-MM-yyyy').format(date);
    });
  }
}