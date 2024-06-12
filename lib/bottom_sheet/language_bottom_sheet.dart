import 'package:flutter/material.dart';




class LanguageBottomSheet extends StatelessWidget {
  LanguageBottomSheet({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {
              },
              child: Text(
                "english"
              ),
            ),



          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {


              },
              child: Text(
               "arabic"
              ),
            ),




          ]),
        ],
      ),
    );
  }
}
