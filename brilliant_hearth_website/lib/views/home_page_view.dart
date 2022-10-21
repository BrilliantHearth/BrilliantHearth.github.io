import 'dart:ui';
import 'package:brilliant_hearth_website/models/product_card.dart';
import 'package:brilliant_hearth_website/util/custom_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../controllers/home_page_controller.dart';


class HomePageView extends StatelessWidget {
  final HomePageController state;
  final List<ProductCard> productCards = ProductCard.getProductCards();
  final isWebMobile = kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android);
  HomePage get widget => state.widget;


  HomePageView(this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    print(isWebMobile);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(100.w, 8.h),
        child: AppBar(
          backgroundColor: CustomColors.appBarBackgroundColor,
          title: Row(
            children: [
              Image.asset('images/BHAppBarLogo.png',color: Colors.white,width: 11.h,height: 11.h,),
              Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: shopAppBarButton(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: aboutAppBarButton(),
              ),
            ],
          ),
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 2.h),
              width: 100.w,
              height: 40.h,
              decoration: const BoxDecoration(
                boxShadow: [BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2.0,
                  blurRadius: 5.0
                )],
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/backgrounds/sage_herbs_background_dark.png'),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 10.0,
                            blurRadius: 15.0
                          ),
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: -10.0,
                              blurRadius: 2.0,
                          )
                        ]
                      ),
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                          child: Container(
                            width: 60.w,
                            height: 13.h,
                            color: Colors.transparent,
                            // decoration: BoxDecoration(
                            //   color: Colors.black.withOpacity(0.3),
                            // ),
                            child: Center(
                              child: Text(
                                  'Welcome To Brilliant Hearth',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.newRocker(fontSize: 14.sp,color: Colors.white)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 2.h),
                  //   child: ClipRect(
                  //     child: BackdropFilter(
                  //       filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  //       child: Container(
                  //         width: 25.w,
                  //         height: 15.h,
                  //         decoration: const BoxDecoration(
                  //             color: Colors.transparent,
                  //         ),
                  //         child: Center(
                  //           child: Text(
                  //               'Natures gifts to warm the soul & infuse happiness into everyday life',
                  //               textAlign: TextAlign.center,
                  //               style: GoogleFonts.cinzel(fontSize: 5.2.sp,color: Colors.white)
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: headerButton(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 7.h),
              child: Text("WHAT'S NEW?", style: GoogleFonts.cinzel(fontSize: 6.5.sp,decoration: TextDecoration.underline, decorationThickness: 0.3),),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: whatsNewTiles(screenSize),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: whoWeAre(),
            )
          ],
        ),
      )
    );
  }

  Widget headerButton(){
    return ElevatedButton(
        onPressed: () => print('Button pressed!'),
        style: ElevatedButton.styleFrom(
          primary: CustomColors.buttonPink,
          padding: EdgeInsets.only(
               left: 2.h, right: 2.h, top: 2.h, bottom: 2.h),
        ),
        child: Text("SHOP NOW", style: GoogleFonts.cinzel(fontSize: 7.sp, color: Colors.black),),
    );
  }

  Widget shopAppBarButton(){
    return ElevatedButton(
      onPressed: () => print('Button pressed!'),
      style: ElevatedButton.styleFrom(
        primary: CustomColors.appBarBackgroundColor,
        shadowColor: CustomColors.appBarBackgroundColor,
        elevation: 0,
        padding: EdgeInsets.only(
           left: 2.h, right: 2.h, top: 2.h, bottom: 2.h),
      ),
      child: Text("SHOP", style: GoogleFonts.cinzel(fontSize: 7.sp,color: CustomColors.buttonPink),),
    );
  }

  Widget aboutAppBarButton(){
    return ElevatedButton(
      onPressed: () => print('Button pressed!'),
      style: ElevatedButton.styleFrom(
        primary: CustomColors.appBarBackgroundColor,
        shadowColor: CustomColors.appBarBackgroundColor,
        elevation: 0,
        padding: EdgeInsets.only(
            left: 2.h, right: 2.h, top: 2.h, bottom: 2.h),
      ),
      child: Text("ABOUT", style: GoogleFonts.cinzel(fontSize: 7.sp,color: CustomColors.buttonPink),),
    );
  }

  Widget whatsNewTiles(Size screenSize){
    List<Column> tileList = [];
    for (int i = 0; i < productCards.length; i++){
      tileList.add(Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: screenSize.width / 9,
            width: screenSize.width / 9,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2.0,
                  blurRadius: 5.0,
                ),
              ],
              image: DecorationImage(
                image: AssetImage(productCards[i].imagePath),
                fit: BoxFit.cover
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(productCards[i].title, style: GoogleFonts.cinzel(fontSize: 4.sp),),
          )
        ],
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: tileList
    );
  }

  Widget whoWeAre(){
    return Container(
      width: 100.w,
      height: 35.h,
      decoration: BoxDecoration(
        color: CustomColors.whoAreWeContainerColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text('WHO WE ARE',
              style: GoogleFonts.cinzel(fontSize: 7.0.sp,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Container(
              width: 70.w,
              height: 20.h,
              child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                  'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',textAlign: TextAlign.center, style: GoogleFonts.cinzel(fontSize: 3.5.sp),),
            ),
          )
        ],
      ),
    );
  }


}
