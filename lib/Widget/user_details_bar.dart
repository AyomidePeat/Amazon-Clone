import 'package:flutter/material.dart';
import 'package:flutter_guide/Model/user_details.dart';
import 'package:flutter_guide/Providers/user_details_provider.dart';
import 'package:flutter_guide/Resources/const.dart';
import 'package:flutter_guide/Screens/Utils/utils.dart';
import 'package:provider/provider.dart';

class UserDetailsBar extends StatelessWidget {
  
  final double offset;
  const UserDetailsBar({
    super.key,
    required this.offset,
    
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    UserDetailsModel userDetails = Provider.of<UserDetailsProvider>(context).userDetails;

    const List<Color> lightBackgroundGradient = [
      Color(0xffa2e0eb),
      Color.fromARGB(255, 200, 228, 218)
    ];

    return Positioned(
      top: -offset / 3,
      child: Container(
        height: kAppBarHeight / 2,
        width: screenSize.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: lightBackgroundGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 20,
          ),
          child: SizedBox(
            width: screenSize.width * 0.7,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey[900],
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.7,
                  child: Text(
                    "Deliver to ${userDetails.name} -${userDetails.address}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[900]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
