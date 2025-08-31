import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
<<<<<<< HEAD
import 'package:go_smart_admin_windos/app/admin_caclye/view/all_session_orders_screen.dart';
import 'package:go_smart_admin_windos/app/admin_caclye/provider/pos_provider.dart';
import 'package:go_smart_admin_windos/helpers/application_dimentions.dart';
import 'package:go_smart_admin_windos/helpers/navigation_helper.dart';
import 'package:go_smart_admin_windos/styles/colors.dart';
import 'package:go_smart_admin_windos/widget/buttons.dart';
=======
import 'package:go_smart_admin/app/admin_caclye/view/all_session_orders_screen.dart';
import 'package:go_smart_admin/app/admin_caclye/provider/pos_provider.dart';
import 'package:go_smart_admin/helpers/application_dimentions.dart';
import 'package:go_smart_admin/helpers/navigation_helper.dart';
import 'package:go_smart_admin/styles/colors.dart';
import 'package:go_smart_admin/widget/buttons.dart';
>>>>>>> 2324e96 (staple)
import 'package:provider/provider.dart';

import '../../../styles/text_style.dart';

class SessionDetailsDialog extends StatelessWidget {
  final int sessionId;
  final String posName;
  final String sessionName;
  final String cashierName;
  final double openingCash;
  final double closingCash;
  final String state;
  final String startAt;
  final String closeAt;
  final String openingNote;
  final String closingNote;
  final int orderCount;
  final double totalPaymentsAmount;

  const SessionDetailsDialog({
    super.key,
    required this.sessionId,
    required this.posName,
    required this.sessionName,
    required this.cashierName,
    required this.openingCash,
    required this.closingCash,
    required this.state,
    required this.startAt,
    required this.closeAt,
    required this.openingNote,
    required this.orderCount,
    required this.totalPaymentsAmount,
    required this.closingNote,
  });

  @override
  Widget build(BuildContext context) {
    AppDimentions().appDimentionsInit(context);

    return AlertDialog(
      backgroundColor: bgColor,
<<<<<<< HEAD
      content: Directionality(
        textDirection: context.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: SizedBox(
          width: AppDimentions().availableWidth * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${'session'.tr()}: ', style: boldText),
                  Text(sessionName),
                ],
              ),
              SizedBox(height: 20.h),
              Card(
                elevation: 3,
                color: white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: AppDimentions().availableWidth * 0.7,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: goSmartBlue),
                            ),
                            child: Text('sales_information'.tr(), style: mediumText),
                          ),
                          const Spacer(),
                          Container(
                            alignment: Alignment.center,
                            //width: 80.w,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: state.toLowerCase() == 'closed' ? Colors.red.shade100 : Colors.green.shade100,
                            ),
                            child: Text(
                              state,
                              style: mediumText.copyWith(color: state.toLowerCase() == 'closed' ? Colors.red : Colors.green),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/images/dollar_two.png', height: 15.h, width: 15.w),
                          SizedBox(width: 20.w),
                          Text('${'balance'.tr()}: $totalPaymentsAmount ${'egp'.tr()}', style: mediumText),
                          SizedBox(width: 100.w),
                          Image.asset('assets/images/orders.png', height: 15.h, width: 15.w),
                          SizedBox(width: 20.w),
                          Text('${'orders'.tr()}: $orderCount', style: mediumText),
                        ],
                      ),
                      const Divider(),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 2,
                            child: ColumnDataItem(label: 'pos'.tr(), data: posName),
                          ),
                          Expanded(
                            flex: 2,
                            child: ColumnDataItem(label: 'cashier'.tr(), data: cashierName),
                          ),
                          Expanded(
                            flex: 2,
                            child: ColumnDataItem(
                              label: 'opening_date'.tr(),
                              data: startAt.isEmpty ? '' : ez.DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(startAt)),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ColumnDataItem(
                              label: 'closing_date'.tr(),
                              data: closeAt.isEmpty ? '' : ez.DateFormat('dd/MM/yyyy h:m a').format(DateTime.parse(closeAt)),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 2,
                            child: ColumnDataItem(label: 'opening_cash'.tr(), data: '$openingCash ${'egp'.tr()}'),
                          ),
                          Expanded(
                            flex: 2,
                            child: ColumnDataItem(label: 'closing_cash'.tr(), data: '$closingCash ${'egp'.tr()}'),
                          ),
                        ],
                      ),
                      const Divider(),
                      SizedBox(height: 20.h),
                      ColumnDataItem(label: 'opening_note'.tr(), data: openingNote),
                      SizedBox(height: 10.h),
                      ColumnDataItem(label: 'closing_note'.tr(), data: closingNote),
                      SizedBox(height: 50.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 35.h,
                            width: 200.w,
                            child: BlueButton(
                              label: 'close'.tr(),
                              onPressed: () {
                                Navigation().closeDialog(context);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 35.h,
                            width: 200.w,
                            child: BlueButton(
                              label: 'get_all_orders'.tr(),
                              onPressed: () async {
                                Navigation().showLoadingGifDialog(context);

                                await context.read<PosProvider>().getAllSessionOrders(sessionId);

                                Navigation().closeDialog(context);

                                Navigation().goToScreen(
                                  context,
                                  (context) => AllSessionOrdersScreen(
                                    cashierName: context.read<PosProvider>().allSessionOrders.data!.isEmpty
                                        ? ''
                                        : context.read<PosProvider>().allSessionOrders.data![0].cashier!,
                                    sessionId: sessionId,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
=======
      contentPadding: EdgeInsets.all(10.w),
      content: Directionality(
        textDirection: context.locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: SingleChildScrollView(
          child: SizedBox(
            width: AppDimentions().availableWidth * 0.9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Session Name
                Row(
                  children: [
                    Flexible(
                      child: Text('${'session'.tr()}: ', style: boldText.copyWith(fontSize: 14.sp)),
                    ),
                    Flexible(
                      child: Text(sessionName, style: mediumText.copyWith(fontSize: 14.sp)),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                // Card
                Card(
                  elevation: 3,
                  color: white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header Row: Sales Info + Status
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(color: goSmartBlue),
                              ),
                              child: Text('sales_information'.tr(), style: mediumText.copyWith(fontSize: 12.sp)),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: state.toLowerCase() == 'closed' ? Colors.red.shade100 : Colors.green.shade100,
                              ),
                              child: Text(
                                state,
                                style: mediumText.copyWith(
                                  fontSize: 12.sp,
                                  color: state.toLowerCase() == 'closed' ? Colors.red : Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),

                        // Balance & Orders
                        Wrap(
                          spacing: 10.w,
                          runSpacing: 5.h,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/images/dollar_two.png', height: 14.h, width: 14.w),
                                SizedBox(width: 6.w),
                                Text(
                                  '${'balance'.tr()}: $totalPaymentsAmount ${'egp'.tr()}',
                                  style: mediumText.copyWith(fontSize: 12.sp),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset('assets/images/orders.png', height: 14.h, width: 14.w),
                                SizedBox(width: 6.w),
                                Text('${'orders'.tr()}: $orderCount', style: mediumText.copyWith(fontSize: 12.sp)),
                              ],
                            ),
                          ],
                        ),
                        Divider(height: 15.h),

                        // POS, Cashier, Dates
                        Wrap(
                          spacing: 10.w,
                          runSpacing: 10.h,
                          children: [
                            SizedBox(
                              width: AppDimentions().availableWidth * 0.42,
                              child: ColumnDataItem(label: 'pos'.tr(), data: posName, fontSize: 12.sp),
                            ),
                            SizedBox(
                              width: AppDimentions().availableWidth * 0.42,
                              child: ColumnDataItem(label: 'cashier'.tr(), data: cashierName, fontSize: 12.sp),
                            ),
                            SizedBox(
                              width: AppDimentions().availableWidth * 0.42,
                              child: ColumnDataItem(
                                label: 'opening_date'.tr(),
                                data: startAt.isEmpty ? '' : ez.DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(startAt)),
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(
                              width: AppDimentions().availableWidth * 0.42,
                              child: ColumnDataItem(
                                label: 'closing_date'.tr(),
                                data: closeAt.isEmpty ? '' : ez.DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(closeAt)),
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 15.h),

                        // Opening & Closing Cash
                        Wrap(
                          spacing: 10.w,
                          runSpacing: 10.h,
                          children: [
                            SizedBox(
                              width: AppDimentions().availableWidth * 0.42,
                              child: ColumnDataItem(
                                label: 'opening_cash'.tr(),
                                data: '$openingCash ${'egp'.tr()}',
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(
                              width: AppDimentions().availableWidth * 0.42,
                              child: ColumnDataItem(
                                label: 'closing_cash'.tr(),
                                data: '$closingCash ${'egp'.tr()}',
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 15.h),

                        ColumnDataItem(label: 'opening_note'.tr(), data: openingNote, fontSize: 12.sp),
                        SizedBox(height: 8.h),
                        ColumnDataItem(label: 'closing_note'.tr(), data: closingNote, fontSize: 12.sp),
                        SizedBox(height: 20.h),

                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: SizedBox(
                                height: 32.h,
                                child: BlueButton(label: 'close'.tr(), onPressed: () => Navigation().closeDialog(context)),
                              ),
                            ),
                            Flexible(
                              child: SizedBox(
                                height: 32.h,
                                child: BlueButton(
                                  label: 'get_all_orders'.tr(),
                                  onPressed: () async {
                                    Navigation().showLoadingGifDialog(context);
                                    await context.read<PosProvider>().getAllSessionOrders(sessionId);
                                    Navigation().closeDialog(context);
                                    Navigation().goToScreen(
                                      context,
                                      (context) => AllSessionOrdersScreen(
                                        cashierName: context.read<PosProvider>().allSessionOrders.data!.isEmpty
                                            ? ''
                                            : context.read<PosProvider>().allSessionOrders.data![0].cashier!,
                                        sessionId: sessionId,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
>>>>>>> 2324e96 (staple)
          ),
        ),
      ),
    );
  }
}

<<<<<<< HEAD
class ColumnDataItem extends StatelessWidget {
  final String label;
  final String data;

  const ColumnDataItem({super.key, required this.label, required this.data});
=======
// Updated ColumnDataItem
class ColumnDataItem extends StatelessWidget {
  final String label;
  final String data;
  final double fontSize;

  const ColumnDataItem({super.key, required this.label, required this.data, this.fontSize = 14});
>>>>>>> 2324e96 (staple)

  @override
  Widget build(BuildContext context) {
    return Column(
<<<<<<< HEAD
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: mediumText.copyWith(fontSize: 16.sp, color: goSmartBlue),
        ),
        Text(
          data,
          style: mediumText.copyWith(fontSize: 14.sp, color: Colors.grey[700]),
=======
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: mediumText.copyWith(fontSize: fontSize.sp, color: goSmartBlue),
        ),
        SizedBox(height: 4.h),
        Text(
          data,
          style: mediumText.copyWith(fontSize: (fontSize - 2).sp, color: Colors.grey[700]),
>>>>>>> 2324e96 (staple)
        ),
      ],
    );
  }
}
