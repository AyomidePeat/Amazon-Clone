import 'package:flutter/material.dart';
import 'package:flutter_guide/Screens/Utils/utils.dart';
import 'package:flutter_guide/Screens/result_screen.dart';
import 'package:flutter_guide/Screens/search_screen.dart';

class SearchBarWidget extends StatelessWidget with PreferredSizeWidget {
  final bool isReadOnly;
  final bool hasBackButton;
  SearchBarWidget(
      {Key? key, required this.isReadOnly, required this.hasBackButton})
      : preferredSize = const Size.fromHeight(80),
        super(key: key);
  @override
  final Size preferredSize;
  OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1,
      ));
  List<Color> backgroundGradient = [Color(0xffa0e9ce), Color(0xff80d9e9)];
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();

    return Container(
      height: 80,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: backgroundGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          hasBackButton
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back))
              : Container(),
          SizedBox(
            width: screenSize.width * 0.7,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                onSubmitted: (String query) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => ResultScreen(query: query)),
                    ),
                  );
                },
                readOnly: isReadOnly,
                onTap: () {
                  if (!isReadOnly) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()));
                  }
                },
                decoration: InputDecoration(
                    hintText: "Search for something in Amazon",
                    fillColor: Colors.white,
                    filled: true,
                    border: border,
                    focusedBorder: border),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic_none_outlined),
          )
        ],
      ),
    );
  }
}
