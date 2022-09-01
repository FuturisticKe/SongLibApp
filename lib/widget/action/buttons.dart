import 'package:flutter/material.dart';

import '../../../theme/theme_colors.dart';

class SimpleButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  final Color? txColor;
  final Color? bgColor;
  final double ftSize;
  final double bdRadius;
  final EdgeInsetsGeometry cPadding;

  const SimpleButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.txColor = Colors.white,
    this.bgColor = ThemeColors.primary,
    this.ftSize = 20,
    this.bdRadius = 5,
    this.cPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: cPadding,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(
            Radius.circular(bdRadius),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          title!,
          style: TextStyle(fontSize: ftSize, color: txColor),
          maxLines: 2,
        ),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final Function()? onPressed;
  final Color? inColor;
  final Color? bgColor;
  final double size;
  final IconData icon;

  const RoundButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.inColor = Colors.white,
    this.bgColor = ThemeColors.primary,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(
            Radius.circular(size),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Icon(icon, color: inColor),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  final Icon? icon;
  final Color? txColor;
  final Color? bgColor;
  final Color? bdColor;
  final bool? isActive;
  final double ftSize;
  final double bdRadius;
  final EdgeInsetsGeometry cMargin;
  final EdgeInsetsGeometry cPadding;

  const SubmitButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.txColor = Colors.white,
    this.bgColor = ThemeColors.primary,
    this.bdColor = Colors.white,
    this.isActive = true,
    this.ftSize = 16,
    this.bdRadius = 5,
    this.cMargin = const EdgeInsets.symmetric(vertical: 20),
    this.cPadding = const EdgeInsets.all(5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: cMargin,
      //padding: cMargin,
      child: InkWell(
        onTap: isActive! ? onPressed : null,
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: bdColor!),
            borderRadius: BorderRadius.all(
              Radius.circular(bdRadius),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Center(
            child: Container(
              padding: cPadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (icon != null) icon!,
                  if (icon != null) const SizedBox(width: 10),
                  Text(
                    title!,
                    style: TextStyle(
                        fontSize: ftSize,
                        color: txColor,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Function()? onTap;
  final IconData? icon;
  final Color? txColor;
  final Color? bgColor;
  final Color? bdColor;
  final bool? isActive;
  final double bdRadius;

  const DrawerItem({
    Key? key,
    required this.title,
    required this.onTap,
    this.subtitle = '',
    this.icon,
    this.txColor = Colors.black,
    this.bgColor = Colors.white,
    this.bdColor = Colors.white,
    this.isActive = true,
    this.bdRadius = 0,
  })  : assert(subtitle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 5,
            color: Colors.black26,
          )
        ],
      ),
      child: ListTile(
        leading: icon == null ? null : Icon(icon),
        title: Text(
          title!,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: subtitle!.isEmpty
            ? null
            : Text(
                subtitle!,
                style: const TextStyle(fontSize: 12),
              ),
        onTap: onTap,
      ),
    );
  }
}
