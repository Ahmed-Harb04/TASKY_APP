

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
    static const String routeName = "OnboardingScreen";


  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnboardingData> OnboardingList = dataOnboarding();
  int index = 0;
  PageController controller =PageController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 260,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  index =value;
                });
              },
              itemBuilder: (context,index){
                return CustomAnimationWidget(
                  delay:index,
                  index: index,
                  
                  child: Image.asset(OnboardingList[index].image));
              },
              itemCount: OnboardingList.length,
            ),
          ),

          SizedBox(height: 35,),

          SmoothPageIndicator(
            controller: controller,
             count: OnboardingList.length,
             effect: ExpandingDotsEffect(
              spacing: 20,
              radius: 10,
              dotWidth: 15,
              dotColor: Color(0xffAFAFAF),

             )
             ),
          SizedBox(height: 50,),

          CustomAnimationWidget(
            delay: (index+1)*100,
            index: index,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              child: Column(
                children: [
                  Text(OnboardingList[index].title,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff24252C),
                  ),),
            
                  SizedBox(height: 40,),
                  
                  Text(OnboardingList[index].description,
                  style: TextStyle(
                    fontSize:16 ,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6E6A7C)
                  ),
                  textAlign: TextAlign.center,
                  ),
                  
                ],
              ),
            ),
          ),
          
          SizedBox(height: 100,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                onPressed: (){
                  if(index < OnboardingList.length-1){
                    controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                  }
                  else{
                    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                  }
                  
                },
                color: Color(0xff5F33E1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                height: 48,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                     index < OnboardingList.length-1 ?"Next":"Get Started",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffFFFFFF)
                      ),
                    ),
                )),
            ),
          )

        ],
      )),
    );
  }
}

class OnboardingData{
  final String title;
  final String description;
  final String image;
OnboardingData({
  required this.title,
  required this.description,
 required this.image,

});

}


List<OnboardingData>dataOnboarding(){
  return[
    OnboardingData(title: "Manage your tasks",
     description: "You can easily manage all of your daily tasks in DoMe for free",
     image: 'assets/images/Onboarding_1_screen.png'
     ),

     OnboardingData(title: "Create daily routine",
      description: "In Tasky  you can create your personalized routine to stay productive",
       image: 'assets/images/Onboarding_2_screen.png'
       ),

       OnboardingData(title: "Orgonaize your tasks",
        description: "You can organize your daily tasks by adding your tasks into separate categories",
         image: 'assets/images/Onboarding_3_screen.png'
         ),

  ];
}


class CustomAnimationWidget extends StatelessWidget {
  const CustomAnimationWidget({super.key, required this.child, required this.delay, required this.index});
  final int index;
  final int delay;
  final Widget child;


  @override
  Widget build(BuildContext context) {
    if(index==1){
      return FadeInDown(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child:child,
      );
  }
}