import 'package:flutter/material.dart';




class themeBottomSheet extends StatelessWidget {
  themeBottomSheet({super.key});


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
                  "light"
              ),
            ),



          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {


              },
              child: Text(
                  "dark"
              ),
            ),




          ]),
        ],
      ),
    );
  }
}
