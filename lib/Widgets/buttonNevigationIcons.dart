import 'package:flutter/material.dart';
import 'package:lavajava/Widgets/CustomText.dart';

class BottomNavIcon extends StatelessWidget {
  final IconData icon;
  final String name;
  final Function onTap;
  
  const BottomNavIcon({
    Key key,
    this.icon,
    this.name, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? null,
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.orange,
            size: 25,
          ),
          CustomText(
            text: name,
            size: 10,
            color: Colors.orange,
          )
        ],
      ),
    );
  }
}
