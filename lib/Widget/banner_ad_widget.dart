import 'package:flutter/material.dart';
import 'package:flutter_guide/Resources/const.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  int currentAd = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
      double smallAdsHeight = screenSize.width / 5;

    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails) {
        if (currentAd == (largeAds.length - 1)) {
          currentAd = -1;
        }
        setState(() {
          currentAd++;
        });
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                largeAds[currentAd],
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenSize.width,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            color: Colors.white,
            height: screenSize.height,
            width: screenSize.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getSmallAdsfromIndex(0, smallAdsHeight),
                getSmallAdsfromIndex(1, smallAdsHeight),
                getSmallAdsfromIndex(2, smallAdsHeight),
                getSmallAdsfromIndex(3, smallAdsHeight)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getSmallAdsfromIndex(int index, double height) {
    return Container(
          height: height,
          width: height,
          decoration: ShapeDecoration(
              color: Colors.white,
              shadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [

                Image.network(smallAds[index]),
                const SizedBox(height: 5,),
                Text(adItemNames[index]),
              ],
            ),
          ),
    );
  }
}
