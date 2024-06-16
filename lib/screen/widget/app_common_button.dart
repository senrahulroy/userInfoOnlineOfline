


import 'package:flutter/material.dart';

class CommButton extends StatelessWidget {
  const CommButton({
    super.key, required this.btnTitle, this.width = double.infinity , required this.onPressed,
  });

  final String btnTitle;
  final double width;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 5,
        ),
        child: Text(btnTitle,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .apply(color: Colors.white, fontSizeDelta: 6),),
      ),
    );
  }
}
