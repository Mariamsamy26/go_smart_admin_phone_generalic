import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_smart_admin/app/admin_caclye/dialogs/refund_request_dialog.dart';
import 'package:go_smart_admin/app/admin_caclye/dialogs/session_details_dialog.dart';
import 'package:go_smart_admin/app/admin_caclye/provider/pos_provider.dart';
import 'package:go_smart_admin/helpers/application_dimentions.dart';
import 'package:go_smart_admin/helpers/navigation_helper.dart';
import 'package:go_smart_admin/styles/colors.dart';
import 'package:go_smart_admin/styles/text_style.dart';
import 'package:go_smart_admin/widget/buttons.dart';
import 'package:provider/provider.dart';

class AllSessionsScreen extends StatelessWidget {
  AllSessionsScreen({super.key});

  final searchController = TextEditingController();
  final searchNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    AppDimentions().appDimentionsInit(context);
    final posProviderRead = context.read<PosProvider>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            SizedBox(height: 10.h),

            //* Header Row
            SizedBox(
              height: AppDimentions().availableheightNoAppBar * 0.09,
              child: Row(
                children: [
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(Icons.arrow_back_ios_new, size: 20.sp, color: Colors.grey[500]),
                  ),

                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: EdgeInsets.only(left: 20.w, right: 10.w),
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: TextField(
                        controller: searchController,
                        focusNode: searchNode,
                        onChanged: posProviderRead.onSearchAllSessionsTextChanged,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'search'.tr(),
                          hintStyle: mediumText.copyWith(color: const Color(0xffA6B3BA).withOpacity(0.5), fontSize: 16.sp),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(5.w),
                            child: Image.asset('assets/images/search.png', height: 15.h, width: 15.w, color: goSmartBlue),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              posProviderRead.clearSearchAllSessionsList();
                              searchController.clear();
                              FocusScope.of(context).unfocus();
                            },
                            child: const Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),

                  Text('POS', style: mediumText.copyWith(color: goSmartBlue)),
                  SizedBox(width: 5.w),
                  Text('GO Smart ', style: mediumText),
                  SizedBox(width: 5.w),
                  Image.asset('assets/images/pos.png', height: 25.h, width: 25.w),
                  SizedBox(width: 10.w),
                ],
              ),
            ),
            SizedBox(height: 5.h),
            const Divider(indent: 20, endIndent: 20),
            SizedBox(height: 5.h),

            //* Flexible List Area
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //* Sessions Header + Refund Button
                    Row(
                      children: [
                        Text('sessions'.tr(), style: boldText.copyWith(fontSize: 18.sp)),
                        const Spacer(),
                        // BlueButton(
                        //   label: 'refund_request'.tr(),
                        //   onPressed: () {
                        //     showDialog(
                        //       context: context,
                        //       builder: (context) => const RefundRequestDialog(),
                        //     );
                        //   },
                        // ),
                      ],
                    ),
                    SizedBox(height: 15.h),

                    //* Column Header Card
                    Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Expanded(flex: 3, child: Text('session'.tr())),
                            Expanded(flex: 2, child: Text('pos'.tr())),
                            Expanded(flex: 2, child: Text('cashier'.tr(), textAlign: TextAlign.center)),
                            Expanded(flex: 3, child: Text('status'.tr(), textAlign: TextAlign.center)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    //* Sessions List
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: ListView.separated(
                          separatorBuilder: (_, __) => const Divider(),
                          itemCount: posProviderRead.isSearchingSessions
                              ? posProviderRead.allSessionsSearchResult.length
                              : posProviderRead.posSessions.data!.length,
                          itemBuilder: (context, index) {
                            final session = posProviderRead.isSearchingSessions
                                ? posProviderRead.allSessionsSearchResult[index]
                                : posProviderRead.posSessions.data![index];

                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => SessionDetailsDialog(
                                    key: ValueKey(session.id),
                                    posName: session.posName!,
                                    cashierName: session.cashierName!,
                                    sessionName: session.name!,
                                    startAt: session.startAt!,
                                    closeAt: session.stopAt!,
                                    closingCash: session.closingCash!,
                                    openingCash: session.openingCash!,
                                    openingNote: session.openingNotes!,
                                    closingNote: session.closingNotes!,
                                    orderCount: session.ordersCount!,
                                    sessionId: session.id!,
                                    state: session.state!,
                                    totalPaymentsAmount: session.totalPaymentsAmount!,
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Row(
                                  children: [
                                    Expanded(flex: 3, child: Text(session.name!)),
                                    Expanded(flex: 2, child: Text(session.posName!)),
                                    Expanded(flex: 2, child: Text(session.cashierName!, textAlign: TextAlign.center)),
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 7.h,
                                            width: 7.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: session.state!.toLowerCase() == 'closed' ? Colors.red : Colors.green,
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Flexible(
                                            child: Text(
                                              session.state!,
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//---------------------------- ColumnDataItem ----------------------------
class ColumnDataItem extends StatelessWidget {
  final String label;
  final String data;

  const ColumnDataItem({super.key, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: mediumText.copyWith(fontSize: 16.sp, color: goSmartBlue),
        ),
        SizedBox(height: 5.h),
        Text(
          data,
          style: mediumText.copyWith(fontSize: 14.sp, color: Colors.grey[700]),
        ),
      ],
    );
  }
}
