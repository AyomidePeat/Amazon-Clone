import 'package:flutter/material.dart';
import 'package:flutter_guide/Resources/const.dart';
import 'package:flutter_guide/Screens/result_screen.dart';

class CategoriesHorizontalList extends StatelessWidget {
  const CategoriesHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
          itemCount: 8,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            
             return GestureDetector(
              onTap: (){
                Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(query: categoriesList[index]),
            ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          categoryLogos[index],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          categoriesList[index],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
