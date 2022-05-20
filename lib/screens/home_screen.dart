

import 'package:avatar_view/avatar_view.dart';

import 'package:flutter/material.dart';


import '../utiles/camera_deep_ar.dart';

class HomeScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => HomeState();
}
class HomeState extends State<HomeScreen>{

  late CameraDeepArController _cameraDeepArController;
  String platformVersion = "UnKnown";
  int currentPage = 0;
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  final vp = PageController(viewportFraction: 0.24);
  bool isRecording = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    platformVersion  ="ff";
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CameraDeepAr(
            
              cameraDeepArCallback: (c) async{
                _cameraDeepArController = c;

              },
              androidLicenceKey: "8214975e5c27cfe05c1aef3ab8c015f1b141c427e7b04c161a71864d9904842f1377f1e36b2cf6c1",
              iosLicenceKey: "8214975e5c27cfe05c1aef3ab8c015f1b141c427e7b04c161a71864d9904842f1377f1e36b2cf6c1",

              onImageCaptured: (val){},
              onVideoRecorded: (val){}
              , onCameraReady: (isReady){
            platformVersion = "Camera Status ${isReady}";
            print(platformVersion);
            setState(() {
              platformVersion = "Camera Status ${isReady}";
            });


          }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(
                    'Response >>> : $platformVersion\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            if (null == _cameraDeepArController) return;
                            if (isRecording) return;
                            _cameraDeepArController.snapPhoto();
                          },
                          child: Icon(Icons.camera_enhance_outlined),
                          color: Colors.white,
                          padding: EdgeInsets.all(15),
                        ),
                      ),
                      if (isRecording)
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              if (null == _cameraDeepArController) return;
                              _cameraDeepArController.stopVideoRecording();
                              isRecording = false;
                              setState(() {});
                            },
                            child: Icon(Icons.videocam_off),
                            color: Colors.red,
                            padding: EdgeInsets.all(15),
                          ),
                        )
                      else
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              if (null == _cameraDeepArController) return;
                              _cameraDeepArController.startVideoRecording();
                              isRecording = true;
                              setState(() {});
                            },
                            child: Icon(Icons.videocam),
                            color: Colors.green,
                            padding: EdgeInsets.all(15),
                          ),
                        ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(8, (page) {
                        bool active = currentPage ==page;

                        return true ?

                        GestureDetector(
                          onTap: (){
                            currentPage = page;
                            _cameraDeepArController.changeMask(page);
                            setState(() {

                            });


                          },
                          child: AvatarView(
                            radius: active?65:30,
                            backgroundColor: Colors.red,
                            borderColor: Colors.yellow,
                            borderWidth: 2,
                            isOnlyText: false,
                            avatarType: AvatarType.CIRCLE,
                            imagePath: "assets/ios/${page.toString()}.jpg",
                            placeHolder: Icon(Icons.person,size: 50,),
                            errorWidget: Container(child: Icon(Icons.error,size: 50,),),

                          ),
                        )
                            :

                        GestureDetector(
                          onTap: (){

                          },
                          child: AvatarView(
                            radius: active?65:30,
                            backgroundColor: Colors.red,
                            borderColor: Colors.yellow,
                            borderWidth: 2,
                            isOnlyText: false,
                            avatarType: AvatarType.CIRCLE,
                            imagePath: "assets/android/${page.toString()}.jpg",
                            placeHolder: Icon(Icons.person,size: 50,),
                            errorWidget: Container(child: Icon(Icons.error,size: 50,),),

                          ),
                        )
                        ;

                      } ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}