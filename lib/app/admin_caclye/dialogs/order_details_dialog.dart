import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_smart_admin/app/admin_caclye/models/all_session_orders.dart' as so;
import 'package:go_smart_admin/app/admin_caclye/provider/pos_provider.dart';
import 'package:go_smart_admin/helpers/application_dimentions.dart';
import 'package:go_smart_admin/helpers/navigation_helper.dart';
import 'package:go_smart_admin/styles/colors.dart';
import 'package:go_smart_admin/styles/text_style.dart';
import 'package:go_smart_admin/widget/buttons.dart';
import 'package:go_smart_admin/widget/yes_no_dialog.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class OrderDetailsDialog extends StatelessWidget {
  final int index;
  final int sessionId;
  final ScreenshotController screenshotControllerOrderDetails = ScreenshotController();

  OrderDetailsDialog({super.key, required this.index, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    AppDimentions().appDimentionsInit(context);
    final posProviderWatch = context.watch<PosProvider>();
    final order = posProviderWatch.allSessionOrders.data![index];

    return Dialog(
      insetPadding: EdgeInsets.all(16.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: AppDimentions().availableWidth * 0.95,
          maxHeight: AppDimentions().availableheightWithAppBar * 0.9,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with close button
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'تفاصيل الطلب',
                        style: boldText.copyWith(fontSize: 18.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, size: 24.sp),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Order information
                _buildOrderInfo(context, order, posProviderWatch),
                SizedBox(height: 16.h),

                // Order items
                _buildOrderItems(context, order),
                SizedBox(height: 16.h),

                // Order summary
                _buildOrderSummary(context, order, posProviderWatch),
                SizedBox(height: 16.h),

                // Action buttons
                _buildActionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderInfo(BuildContext context, so.Datum order, PosProvider posProviderWatch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('order_number'.tr(), order.orderNumber ?? ''),
        _buildInfoRow('معرف الفاتورة', order.posReference ?? ''),
        if (order.invoiceDetails!.isNotEmpty) _buildInfoRow('order_reference'.tr(), order.invoiceDetails![0].reference ?? ''),
        _buildInfoRow('pos'.tr(), order.posName ?? ''),
        _buildInfoRow('session'.tr(), order.sessionName ?? ''),

        // Delivery button condition
        if ((order.paymentData![0].type == 'delivery' && order.invoiceDetails!.isEmpty) ||
            (order.paymentData![0].type == 'delivery' &&
                order.invoiceDetails!.isNotEmpty &&
                order.invoiceDetails![0].amountDue != 0))
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: BlueButton(
              label: 'توريد الفاتورة',
              onPressed: () => _showDeliveryConfirmation(context, order, posProviderWatch),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: mediumText.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 7,
            child: Text(
              value,
              style: mediumText.copyWith(fontSize: 14.sp),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItems(BuildContext context, so.Datum order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'المنتجات',
          style: boldText.copyWith(fontSize: 16.sp),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),

        // Table header
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r), topRight: Radius.circular(8.r)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  'product_name'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    'quantity'.tr(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    'price'.tr(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    'total'.tr(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Table items
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.r), bottomRight: Radius.circular(8.r)),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: order.orderLines!.length,
            separatorBuilder: (context, index) => Divider(height: 1.h, color: Colors.grey[300]),
            itemBuilder: (context, secIndex) {
              final item = order.orderLines![secIndex];
              return Container(
                color: secIndex.isEven ? Colors.grey[50] : Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        item.fullProductName!,
                        style: TextStyle(fontSize: 12.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(item.qty!.toStringAsFixed(0), style: TextStyle(fontSize: 12.sp)),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(item.priceUnit!.toStringAsFixed(2), style: TextStyle(fontSize: 12.sp)),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          item.priceSubtotalIncl!.toStringAsFixed(2),
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary(BuildContext context, so.Datum order, PosProvider posProviderWatch) {
    final hasInvoice = order.invoiceDetails!.isNotEmpty;
    final isDeliveryPaid = hasInvoice && order.invoiceDetails![0].amountDue == 0;
    final isDelivery = order.paymentData![0].type == 'delivery';

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          if (!isDelivery || (isDelivery && isDeliveryPaid)) ...[
            _buildSummaryRow(
              'total_no_tax'.tr(),
              hasInvoice ? order.invoiceDetails![0].untaxedAmount!.toStringAsFixed(2) : '0.00',
            ),
            _buildSummaryRow('tax'.tr(), hasInvoice ? order.invoiceDetails![0].taxes!.toStringAsFixed(2) : '0.00'),
            Divider(),
          ],
          _buildSummaryRow(
            'total'.tr(),
            hasInvoice && isDeliveryPaid
                ? order.invoiceDetails![0].total!.toStringAsFixed(2)
                : order.amountTotal!.toStringAsFixed(2),
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: isTotal ? 16.sp : 14.sp, fontWeight: isTotal ? FontWeight.bold : FontWeight.w600),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: isTotal ? 16.sp : 14.sp, fontWeight: isTotal ? FontWeight.bold : FontWeight.w600),
          ),
          SizedBox(width: 4.w),
          Text(
            'egp'.tr(),
            style: TextStyle(fontSize: isTotal ? 14.sp : 12.sp, fontWeight: isTotal ? FontWeight.bold : FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('إغلاق', style: mediumText.copyWith(fontSize: 14.sp)),
          ),
        ),
      ],
    );
  }

  void _showDeliveryConfirmation(BuildContext context, so.Datum order, PosProvider posProviderWatch) {
    showDialog(
      context: context,
      builder: (context) => YesNoDialog(
        dialogText: 'هل انت متأكد من توريد الفاتورة',
        onYesPressed: () async {
          Navigation().showLoadingGifDialog(context);
          await context.read<PosProvider>().generateAndRegisterDeliveryOrder(
            order.id!,
            order.paymentData![0].cashJournalId!,
            sessionId,
          );
          Navigation().closeDialog(context);
          Navigation().closeDialog(context);
        },
        onNoPressed: () => Navigation().closeDialog(context),
      ),
    );
  }

  void _printReceipt(BuildContext context) {
    // Implement receipt printing functionality
    // This would use the screenshotControllerOrderDetails to capture and print
  }

  // Hidden receipt template for screenshot (optional)
  Widget _buildReceiptTemplate(BuildContext context, so.Datum order, PosProvider posProviderWatch) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: 360,
        padding: EdgeInsets.all(12.w),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'اسم المطعم',
              textAlign: TextAlign.center,
              style: boldText.copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 12.h),

            // Order info
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'order_number'.tr(),
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(order.orderNumber!, style: TextStyle(fontSize: 12.sp)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'date'.tr(),
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(intl.DateFormat('E d MMMM yyyy', 'ar').format(order.dateOrder!), style: TextStyle(fontSize: 12.sp)),
                      Text(
                        'time'.tr(),
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(intl.DateFormat('hh:mm a', 'ar').format(order.dateOrder!), style: TextStyle(fontSize: 12.sp)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Order items
            Container(
              color: Colors.black,
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      'product_name'.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'quantity'.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'price'.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'total'.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ...order.orderLines!.map(
              (item) => Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(item.fullProductName!, style: TextStyle(fontSize: 10.sp)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(item.qty!.toStringAsFixed(0), style: TextStyle(fontSize: 10.sp)),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(item.priceUnit!.toStringAsFixed(2), style: TextStyle(fontSize: 10.sp)),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(item.priceSubtotalIncl!.toStringAsFixed(2), style: TextStyle(fontSize: 10.sp)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Total
            Container(
              color: Colors.black,
              padding: EdgeInsets.all(8.w),
              child: Row(
                children: [
                  Text(
                    'total'.tr(),
                    style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    '${order.amountTotal!.toStringAsFixed(2)} ${'egp'.tr()}',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
