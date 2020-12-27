import 'package:flutter/material.dart';
import 'package:whatsme/presentation/widgets/theme/style.dart';

class SingleItemCallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset("assets/profile_default.png"),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Username",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Icon(
                            Icons.call_received,
                            color: primaryColor,
                            size: 18,
                          ),
                          Text("Yesterday",maxLines: 1,overflow: TextOverflow.ellipsis,),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Icon(Icons.call,color: primaryColor,)
            ],
          ),
          Padding(padding: EdgeInsets.only(left: 60,right: 10),child: Divider(thickness: 1.5,),)
        ],
      ),
    );
  }
}
