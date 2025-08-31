import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/colors.dart';
import '../styles/text_style.dart';

class BlueButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const BlueButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
<<<<<<< HEAD
      height: 55.h,
=======
      height: 30.h,
>>>>>>> 2324e96 (staple)
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(goSmartBlue),
          shape: WidgetStatePropertyAll(
<<<<<<< HEAD
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: mediumText.copyWith(
            fontSize: 18.sp,
            color: white,
            fontWeight: FontWeight.w600,
          ),
        ),
=======
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          ),
        ),
        onPressed: onPressed,
      child: FittedBox(
  fit: BoxFit.scaleDown, 
  child: Text(
    label,
    maxLines: 1,
    style: TextStyle(
      fontSize: 17.sp, 
      color: white,
      fontWeight: FontWeight.w600,
    ),
  ),
),

>>>>>>> 2324e96 (staple)
      ),
    );
  }
}

class GreyButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const GreyButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.grey[300]),
          shape: WidgetStatePropertyAll(
<<<<<<< HEAD
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
=======
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
>>>>>>> 2324e96 (staple)
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
<<<<<<< HEAD
          style: mediumText.copyWith(
            fontSize: 18.sp,
            color: Colors.grey[800],
          ),
=======
          style: mediumText.copyWith(fontSize: 18.sp, color: Colors.grey[800]),
>>>>>>> 2324e96 (staple)
        ),
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const CancelButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
<<<<<<< HEAD
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
=======
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
>>>>>>> 2324e96 (staple)
          ),
          backgroundColor: const WidgetStatePropertyAll(
            Color.fromRGBO(251, 170, 171, 1),
          ),
        ),
        onPressed: onPressed,
<<<<<<< HEAD
        child: Text(
          label,
          style: boldText.copyWith(color: Colors.red),
        ),
=======
        child: Text(label, style: boldText.copyWith(color: Colors.red)),
>>>>>>> 2324e96 (staple)
      ),
    );
  }
}

class DisabledButton extends StatelessWidget {
  final String label;

<<<<<<< HEAD
  const DisabledButton({
    super.key,
    required this.label,
  });
=======
  const DisabledButton({super.key, required this.label});
>>>>>>> 2324e96 (staple)

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
<<<<<<< HEAD
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
=======
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
>>>>>>> 2324e96 (staple)
          ),
          backgroundColor: const WidgetStatePropertyAll(Colors.grey),
        ),
        onPressed: null,
<<<<<<< HEAD
        child: Text(
          label,
          style: boldText.copyWith(color: Colors.white),
        ),
=======
        child: Text(label, style: boldText.copyWith(color: Colors.white)),
>>>>>>> 2324e96 (staple)
      ),
    );
  }
}

class BorderButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const BorderButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
<<<<<<< HEAD
                borderRadius: BorderRadius.circular(10.r), side: const BorderSide(color: goSmartBlue, width: 2)),
=======
              borderRadius: BorderRadius.circular(10.r),
              side: const BorderSide(color: goSmartBlue, width: 2),
            ),
>>>>>>> 2324e96 (staple)
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
<<<<<<< HEAD
          style: mediumText.copyWith(
            fontSize: 18.sp,
            color: goSmartBlue,
          ),
=======
          style: mediumText.copyWith(fontSize: 18.sp, color: goSmartBlue),
>>>>>>> 2324e96 (staple)
        ),
      ),
    );
  }
}
