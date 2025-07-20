import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/constant/assets_constant.dart';

class ContainerPriorityWidget extends StatelessWidget {
  const ContainerPriorityWidget({
    super.key,
    this.isSelected=false,
    required this.index,
    this.onTap,
  });
  final bool isSelected;
  final int index;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color:isSelected ? Color(0xff5F33E1):Colors.white,
          borderRadius: BorderRadius.circular(4),
          border:isSelected
          ? null
          : Border.all(
            color: Color(0xff6E6A7C),
            width: 1.3,
          )
        ),
        child: Column(
          children: [
            ImageIcon(
              AssetImage(AssetsConstant.flagIcon),
              color:isSelected?Colors.white: Color(0xff5F33E1),
              size: 24,
            ), 
            Text(
              "$index",
              style: TextStyle(
                fontSize: 16,
                color:isSelected?Colors.white : Color(0xff24252C),
                fontWeight: FontWeight.bold,
              ),
            )
      
          ],
        ),
      ),
    );
  }
}