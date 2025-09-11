import 'package:flutter/material.dart';
import 'package:partytime/style/app_colors.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.navBar,
      elevation: 0,
      leading: GestureDetector(
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Image.asset('assets/pictures/back.png', height: 83, width: 83),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(67);
}
