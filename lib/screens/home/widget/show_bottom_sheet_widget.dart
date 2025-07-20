import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/assets_constant.dart';
import 'package:flutter_application_1/screens/auth/widget/text_form_field_widget.dart';

class ShowBottomSheetWidget extends StatelessWidget {
  const ShowBottomSheetWidget({super.key,
   this.onTapFlag,
   this.onTapSend,
   this.onTapTimer,
   required this.titleTask,
   required this.descriptionTask});

  final void Function()? onTapTimer;
  final void Function()? onTapFlag;
  final void Function()? onTapSend;
  final TextEditingController titleTask ;
  final TextEditingController descriptionTask ;



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25,),
           Text(
              "Add Task",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff24252C),
              ),
              
            ),
            SizedBox(height: 14,),
            TextFormFieldWidget(hintText: 'Do math homework',
            controller:titleTask ,),
            SizedBox(height: 14,),
            Text('Description',style: TextStyle(
            fontSize:18,
            fontWeight: FontWeight.w400,
            color: Color(0xff6E6A7C),
            ),
            ),
            TextFormFieldWidget(hintText: 'Enter your description',
            controller:descriptionTask ,),
            SizedBox(height: 17,),
            Row(
              children: [
                GestureDetector(
                  onTap: onTapTimer,
                  child: Image.asset(AssetsConstant.timerIcon)),
                  SizedBox(width: 10,),
                GestureDetector(
                  onTap: onTapFlag,
                  child: Image.asset(AssetsConstant.flagIcon)),
                const Spacer(),
                GestureDetector(
                  onTap: onTapSend,
                  child: Image.asset(AssetsConstant.sendIcon)),
                
              ],
            ),
            SizedBox(height: 25,),
        ],
      ),
    );
  }
}