import 'package:allen/pellete.dart';
import 'package:flutter/material.dart';
class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  FeatureBox({Key? key, required this.color, required this.headerText, required this.descriptionText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(horizontal: 35,vertical: 10),
      decoration: BoxDecoration(
        color:color,
        borderRadius: BorderRadius.circular(15),

      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20).copyWith(left: 15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(headerText,style: TextStyle(
                fontFamily: 'Cera Pro',
                color: Pallete.blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),),
            ),
            SizedBox(height: 3,),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(descriptionText,style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.blackColor,
              ),),
            )
          ],
        ),
      ),
    );
  }
}
