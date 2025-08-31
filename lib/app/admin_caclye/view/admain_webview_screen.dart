// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:go_smart_admin/app/admin_caclye/view/all_pos_screens.dart';
import 'package:go_smart_admin/app/auth_branches_caclye/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:go_smart_admin/app/auth_branches_caclye/providers/auth_provider.dart';
import 'package:go_smart_admin/services/odoo.dart';

import '../../../../../../helpers/navigation_helper.dart';
import '../../../../../../widget/loading_percent_dialog.dart';

class AdminWebviewScreen extends StatefulWidget {
  final String email;
  final String password;
  final String urlLink;
  final String branchNane;

  const AdminWebviewScreen({
    super.key,
    required this.email,
    required this.password,
    required this.urlLink,
    required this.branchNane,
  });

  @override
  State<AdminWebviewScreen> createState() => _AdminWebviewScreenState();
}

class _AdminWebviewScreenState extends State<AdminWebviewScreen> {
  bool dataLoaded = false;
  bool showLoading = false;
  int pageProgress = 0;

  late WebViewController controller;

  //  final String _baseUrl =
  // 'https://pos-c1.gosmart.eg/web#action=312&model=product.template&view_type=kanban&cids=1&menu_id=191';

  FutureOr onGoBack(dynamic value) {
    controller.loadRequest(Uri.parse(widget.urlLink));
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Odoo().initOdooConnection(email: widget.email, password: widget.password, branch: widget.branchNane).then((
        odooSessuion,
      ) async {
        //* //*
        log('ODOO SESSION ID >> ${odooSessuion!.id}');

        await WebViewCookieManager().setCookie(
          WebViewCookie(name: 'session_id', value: odooSessuion.id, domain: 'pos-c1.gosmart.eg'),
        );

        controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                context.read<AuthProvider>().setLoadingPercentage = progress;
              },
              onPageStarted: (String url) {
                showDialog(context: context, builder: (context) => const LoadingPercentDialog());

                showLoading = true;
              },
              onPageFinished: (String url) {
                print('onPageFinished $url');
                if (showLoading) {
                  Navigation().closeDialog(context);
                  showLoading = false;
                }
              },
              onHttpError: (HttpResponseError error) {},
              onWebResourceError: (WebResourceError error) {},
              onNavigationRequest: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
              onUrlChange: (change) async {
                print('onUrlChange ${change.url}');

                // await controller.loadRequest(
                //   Uri.parse(
                //     'https://pos-c1.gosmart.eg/web#action=312&model=product.template&view_type=kanban&cids=1&menu_id=191',
                //   ),
                // );

                if (change.url!.contains('pos.config')) {
                  Navigation().goToScreenWithGoBack(context, (context) => const AllPosScreens(), onGoBack);
                }
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.urlLink));

        dataLoaded = true;

        setState(() {});
      });
    });
  }

  final GlobalKey webViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;

          if (await controller.canGoBack()) {
            await controller.goBack();
          } else {
            Navigation().closeDialog(context);
          }
        },
        child: Scaffold(
          body: dataLoaded ? WebViewWidget(controller: controller) : const Center(child: CircularProgressIndicator()),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigation().goToScreenAndClearAll(context, (context) => const LoginScreen());
            },
          ),
        ),
      ),
    );
  }
}
