
import 'package:ar_face_filter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreenPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return SplashScreenView(
      navigateRoute:HomeScreen() ,
      imageSrc: "assets/images/icon.png",
      text: "AR Face Masks App",

        textType: TextType.ColorizeAnimationText,
        textStyle: TextStyle(
          fontSize: 50.0,color: Colors.green,fontFamily: "Signatra"

        ),
        duration: 5000,
        imageSize: 130,

        backgroundColor: Colors.white
    );
  }
}