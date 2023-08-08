import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:school_app/Controller/dailyActivityController.dart';
import 'package:school_app/utils/colors.dart';
import 'package:school_app/utils/strings.dart';
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
          bool? readOnly,
          String? Function(String?)? validator}) =>
      TextFormField(
        controller: textEditingController,
        onTap: onTap,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        readOnly: readOnly ?? false,
        textInputAction: textInputAction ?? TextInputAction.next,
        keyboardType: keyboardType ?? TextInputType.text,
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
      TextEditingController? dateController}) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2040),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              textTheme: TextTheme(
                  displayMedium: mediumStyle.copyWith(color: Colors.black)),
              colorScheme: const ColorScheme.light(
                primary: ColorConstants.calenderColor, // <-- SEE HERE
                onPrimary: Colors.white, // <-- SEE HERE
                onSurface: Colors.black, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor:
                      ColorConstants.calenderColor, // button text color
                ),
              ),
            ),
            child: child!);
      },
    ).then((date) {
      dateTime = date!;
      dateController?.text = DateFormat('dd-MM-yyyy').format(date);
    });
  }

  static elevatedButtonWithVisibility(
          {required BuildContext context,
          required bool isVisible,
          required String text,
          required VoidCallback onPressed,
          Color? color}) =>
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: color ?? const Color.fromRGBO(105, 80, 255, 1.0),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: mediumStyle.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Visibility(
                    visible: isVisible,
                    child: const SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ))),
              ]),
        ),
      );

  static elevatedButton({required BuildContext context,required String text,required VoidCallback onPressed,Color? color})=>SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 40,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor:
        color??  const Color.fromRGBO(105, 80, 255, 1.0),
      ),
      child:Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: mediumStyle.copyWith(color: Colors.white),
      ),
    ),
  );


  static eventCard({required String title, required DateTime eventDate,required String description,required VoidCallback onTap}) => GestureDetector(
    onTap: onTap,
    child: Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(   horizontal: 8.0,vertical: 10),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            smallerSizedBox,
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight:
                      FontWeight.bold),
                ),
                Center(
                  child: Container(
                    child: Align(
                      alignment: Alignment
                          .topRight,
                      child: Text(
                        DateFormat(
                            'MMM dd yyyy')
                            .format(eventDate),
                      ),
                    ),
                  ),
                )
              ],
            ),
            mediumSizedBox,
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            smallerSizedBox,
          ],
        ),
      ),
    ),
  );

  static eventCardDetails({required String title, required DateTime eventDate,required String description}) => ListView(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    children: [
      largeSizedBox,
      const Divider(color: Colors.grey),
      largeSizedBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
           title,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ],
      ),
      smallerSizedBox,
      Text(
        DateFormat('dd MMMM yyyy').format(eventDate),
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.grey,),
      ),
      largeSizedBox,
      Text(
        description,
        style: const TextStyle(fontSize: 15),
      ),
      largeSizedBox,
    ],
  );

  static noDataFound({required String text}) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("assets/no-data.gif"),
      smallSizedBox,
      Text(
        text,
        style:
        TextStyle(color: Colors.purple[800]),
      )
    ],
  );

  static loadingWidget() => Center(
    child: Image.asset(
      "assets/loading.gif",
      height: 425.0,
      width: 425.0,
      fit: BoxFit.fitHeight,
    ),

  );

  static titleTextHeading({required String title}) =>  Text(
    title,
    style: const TextStyle(
      color: Colors.deepPurple,
      fontSize: 35,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      decorationThickness: 2.0,
      decorationStyle: TextDecorationStyle.solid,
    ),
  );
  static addButton({required VoidCallback onTap,required String text,required String title}) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
       titleTextHeading(title: title),
      ElevatedButton(
        onPressed:onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.add,
              color: Colors.white,
              size: 18.0,
            ),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold,fontFamily: "Roboto"),
            ),
          ],
        ),
      ),
    ],
  );

  static noInternetAvailable({required BuildContext context}) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(days: 1),
    behavior: SnackBarBehavior.floating,
    content: const Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.signal_wifi_off,
          color: Colors.white,
        ),
        Expanded(
          child: Padding(
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