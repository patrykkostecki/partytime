import 'package:flutter/material.dart';
import 'package:partytime/style/app_colors.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final Color color;
  final double? Width;
  final double? Height;
  final String? centerImagePath;
  final Color? centerImageColor;
  final String? rightImagePath;
  final VoidCallback? rightTap;
  Navbar({
    super.key,
    this.color = AppColors.navBar,
    this.centerImagePath,
    this.centerImageColor,
    this.rightImagePath,
    this.rightTap,
    this.Width = 29,
    this.Height = 29,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      elevation: 0,
      leading: GestureDetector(
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Image.asset('assets/pictures/back.png', height: 83, width: 83),
        ),
      ),
      title: centerImagePath != null
          ? Container(
              height: 51,
              width: 51,
              decoration: BoxDecoration(
                color: centerImageColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: UnconstrainedBox(
                child: SizedBox(
                  width: Width,
                  height: Height,
                  child: Image.asset(centerImagePath!),
                ),
              ),
            )
          : null,
      actions: rightImagePath != null
          ? [
              IconButton(
                onPressed: rightTap,
                icon: Image.asset(rightImagePath!, height: 75, width: 75),
              ),
            ]
          : null,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(67);
}
