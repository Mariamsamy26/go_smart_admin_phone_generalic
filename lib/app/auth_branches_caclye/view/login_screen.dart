import 'dart:convert';
<<<<<<< HEAD

import 'package:go_smart_admin_windos/app/admin_caclye/provider/pos_provider.dart';
import 'package:go_smart_admin_windos/app/auth_branches_caclye/model/login_model.dart';
import 'package:go_smart_admin_windos/app/auth_branches_caclye/services/auth_apis.dart';
import 'package:go_smart_admin_windos/app/auth_branches_caclye/view/branches_screen.dart';
import 'package:go_smart_admin_windos/app/auth_branches_caclye/providers/auth_provider.dart';
=======
import 'dart:io';

import 'package:go_smart_admin/app/admin_caclye/provider/pos_provider.dart';
import 'package:go_smart_admin/app/auth_branches_caclye/model/login_model.dart';
import 'package:go_smart_admin/app/auth_branches_caclye/services/auth_apis.dart';
import 'package:go_smart_admin/app/auth_branches_caclye/view/branches_screen.dart';
import 'package:go_smart_admin/app/auth_branches_caclye/providers/auth_provider.dart';
import 'package:go_smart_admin/helpers/application_dimentions.dart';
import 'package:device_info_plus/device_info_plus.dart';

>>>>>>> 2324e96 (staple)
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
<<<<<<< HEAD
import 'package:go_smart_admin_windos/helpers/navigation_helper.dart';
import 'package:go_smart_admin_windos/styles/colors.dart';
import 'package:go_smart_admin_windos/styles/text_style.dart';
import 'package:go_smart_admin_windos/widget/ok_dialog.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:custom_platform_device_id/platform_device_id.dart';
=======
import 'package:go_smart_admin/helpers/navigation_helper.dart';
import 'package:go_smart_admin/styles/colors.dart';
import 'package:go_smart_admin/styles/text_style.dart';
import 'package:go_smart_admin/widget/ok_dialog.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> 2324e96 (staple)

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isHidden = true;

  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  String deviceId = '';

  @override
  void initState() {
    super.initState();
    _loadId();
    _loadSavedEmail();
  }

  Future<void> _loadId() async {
<<<<<<< HEAD
    final email = emailController.text;
    final pass = passwordController.text;

    deviceId = (await PlatformDeviceId.getDeviceId)!.toLowerCase().trim();
    await AuthApis().setClientuniqueId(emailController.text.trim(), passwordController.text, deviceId.trim());
=======
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? '';
    }
>>>>>>> 2324e96 (staple)

    setState(() {});
  }

  Future<void> _loadSavedEmail() async {
<<<<<<< HEAD
    final id = (await PlatformDeviceId.getDeviceId)!.toLowerCase().trim();
=======
>>>>>>> 2324e96 (staple)
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email') ?? '';

    setState(() {
<<<<<<< HEAD
      deviceId = id;
      emailController.text = savedEmail;
=======
      emailController.text = savedEmail.trim();
>>>>>>> 2324e96 (staple)
    });
  }

  Future<void> _lodinWithId() async {
<<<<<<< HEAD
    //  if (emailController.text.isEmpty || passwordController.text.isEmpty|| deviceId!="") {
    //     showDialog(
    //       context: context,
    //       builder: (context) => OkDialog(text: "Please enter email and password"),
    //     );
    //     return;
    //   }

=======
>>>>>>> 2324e96 (staple)
    await AuthApis().login(emailController.text.trim(), passwordController.text, deviceId.trim()).then((loginData) async {
      await _loadId();
      print("object $deviceId");
      if (loginData == null) {
        Login();
      } else {
        context.read<PosProvider>().setLoginData = loginData;
<<<<<<< HEAD
        if (loginData.status == 1) {
          _loginAdminFlow();
        } else {
=======
        //  Navigation().closeDialog(context);
        if (loginData.status == 1) {
          _loginAdminFlow();
        } else {
          await AuthApis().setClientuniqueId(emailController.text.trim(), deviceId.trim());
>>>>>>> 2324e96 (staple)
          showDialog(
            context: context,
            builder: (context) => OkDialog(text: loginData.messageAr!),
          );
        }
      }
    });
  }

  Future<void> _loginAdminFlow() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    final email = emailController.text.trim();
    final pass = passwordController.text;

    Navigation().showLoadingGifDialog(context);
    try {
      // 1) Backend auth
      await context.read<AuthProvider>().checkAdminLoginCase(email, pass);
      if (!mounted) return;
      final loginResponse = context.read<AuthProvider>().checkAdminLogin;

      if (loginResponse.status != 1) {
        Navigation().closeDialog(context);
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (_) => OkDialog(text: loginResponse.messageAr ?? 'login_failed'.tr()),
        );
        return;
      }
<<<<<<< HEAD

=======
>>>>>>> 2324e96 (staple)
      if (loginResponse.status == 1 && loginResponse.role!.toLowerCase() != "admin") {
        Navigation().closeDialog(context);
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (_) => OkDialog(text: "غير مسموح لهذا الحساب بالدخول"),
        );
        return;
      }

      final accountType = loginResponse.role ?? "";

      Navigation().closeDialog(context);
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) =>
              BranchesScreen(email: email, password: pass, branches: loginResponse.branches ?? [], accountType: accountType),
        ),
        (_) => false,
      );
<<<<<<< HEAD
=======
      //  DataSaveSharedPreferences().saveData(email: email, pass: pass, type: accountType, branches: loginResponse.branches!);

>>>>>>> 2324e96 (staple)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('saved_email', email);
      await prefs.setString('password', pass);
      await prefs.setString('account_Type', accountType);
      // Convert each Branch object to a JSON string
      final branchJson = jsonEncode(loginResponse.branches!.map((b) => b.toJson()).toList());

      // Save
      await prefs.setString('branches', branchJson);
    } on OdooException catch (e) {
      Navigation().closeDialog(context);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => OkDialog(
          text: e.toString().contains('AccessDenied')
              ? 'Access denied. Check DB name, login, or password/API key.'
              : 'Odoo error: $e',
        ),
      );
    } catch (e) {
      print("login error: ${e.toString()}");
      Navigation().closeDialog(context);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => OkDialog(text: e.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
    AppDimentions().appDimentionsInit(context);
>>>>>>> 2324e96 (staple)
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
<<<<<<< HEAD
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        ' $deviceId',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20.h),
                      // Logo
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset('assets/images/gg.png', width: 0.01.sw, height: 0.3.sh),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'email'.tr(),
                        style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          contentPadding: const EdgeInsets.all(15),
                          isDense: true,
                          border: loginRegisterTextBorder,
                          errorBorder: loginRegisterTextBorder,
                          enabledBorder: loginRegisterTextBorder,
                          focusedBorder: loginRegisterTextBorder,
                          hintText: 'email'.tr(),
                        ),
                        validator: (v) => (v == null || v.isEmpty) ? 'valid_value'.tr() : null,
                      ),

                      const SizedBox(height: 15),
                      Text(
                        'password'.tr(),
                        style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: isHidden,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          contentPadding: const EdgeInsets.all(15),
                          isDense: true,
                          border: loginRegisterTextBorder,
                          errorBorder: loginRegisterTextBorder,
                          enabledBorder: loginRegisterTextBorder,
                          focusedBorder: loginRegisterTextBorder,
                          hintText: 'password'.tr(),
                          suffixIcon: IconButton(
                            icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
                            onPressed: () => setState(() => isHidden = !isHidden),
                          ),
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'valid_value'.tr() : null,
                      ),

                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _lodinWithId,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: goSmartBlue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            "login".tr(),
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
=======
          height: AppDimentions().availableheightWithAppBar,
          width: AppDimentions().availableWidth,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        deviceId,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // Logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('assets/images/gg.png', width: 100.w, height: 100.h),
                  ),

                  SizedBox(height: 50.h),
                  Text(
                    'email'.tr(),
                    style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: white,
                      contentPadding: const EdgeInsets.all(15),
                      isDense: true,
                      border: loginRegisterTextBorder,
                      errorBorder: loginRegisterTextBorder,
                      enabledBorder: loginRegisterTextBorder,
                      focusedBorder: loginRegisterTextBorder,
                      hintText: 'email'.tr(),
                    ),
                    validator: (v) => (v == null || v.isEmpty) ? 'valid_value'.tr() : null,
                  ),

                  const SizedBox(height: 15),
                  Text(
                    'password'.tr(),
                    style: TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    obscureText: isHidden,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: white,
                      contentPadding: const EdgeInsets.all(15),
                      isDense: true,
                      border: loginRegisterTextBorder,
                      errorBorder: loginRegisterTextBorder,
                      enabledBorder: loginRegisterTextBorder,
                      focusedBorder: loginRegisterTextBorder,
                      hintText: 'password'.tr(),
                      suffixIcon: IconButton(
                        icon: Icon(isHidden ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setState(() => isHidden = !isHidden),
                      ),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'valid_value'.tr() : null,
                  ),

                  SizedBox(height: 60.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _lodinWithId,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: goSmartBlue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        "login".tr(),
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
>>>>>>> 2324e96 (staple)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
