import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../bottom_sheet/language_bottom_sheet.dart';
import '../../bottom_sheet/theme_bottom_sheet.dart';

class settingTab extends StatelessWidget {
  const settingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Language",
            style:TextStyle( fontSize: 30, fontWeight: FontWeight.w700) ,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(context: context,
                isDismissible: true,
                isScrollControlled: true,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height* .70,
                    child: LanguageBottomSheet(),
                  );
                },);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffB7935F),
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: Text(
                "Arabic",
                style:TextStyle(fontSize: 20, fontWeight: FontWeight.w400) ,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          Text(
            "Theme",
            style:TextStyle(fontSize: 30, fontWeight: FontWeight.w700) ,
            //Theme.of(context).textTheme.bodyLarge
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(context: context,
                isDismissible: true,
                isScrollControlled: true,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height* .70,
                    child: themeBottomSheet(),
                  );
                },);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffB7935F),
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: Text(
                "light",
                style:TextStyle(fontSize: 20, fontWeight: FontWeight.w400) ,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
