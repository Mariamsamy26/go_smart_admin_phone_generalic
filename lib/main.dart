import 'package:go_smart_admin/app/admin_caclye/provider/pos_provider.dart';
import 'package:go_smart_admin/app/auth_branches_caclye/view/branches_screen.dart';
import 'package:go_smart_admin/app/auth_branches_caclye/view/login_screen.dart';
import 'package:go_smart_admin/app/auth_branches_caclye/providers/auth_provider.dart';
import 'package:go_smart_admin/helpers/data_save_shared_preferences.dart';
import 'package:go_smart_admin/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Load saved data using your class
  final savedData = DataSaveSharedPreferences();
  await savedData.loadData();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => PosProvider()),
        ],
        child: MyApp(savedData: savedData),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final DataSaveSharedPreferences savedData;

  const MyApp({super.key, required this.savedData});

  @override
  Widget build(BuildContext context) {
    context.setLocale(const Locale('ar'));

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          theme: ThemeData(
            // textTheme: GoogleFonts.eduNswActFoundationTextTheme(),
            fontFamily: context.locale == const Locale('ar') ? 'Tajawal' : GoogleFonts.roboto().fontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: goSmartBlue, primary: goSmartBlue, secondary: goSmartBlue),
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 1,
            ),
          ),
          home: (savedData.savedEmail.isNotEmpty && savedData.password.isNotEmpty)
              ? BranchesScreen(
                  email: savedData.savedEmail,
                  password: savedData.password,
                  branches: savedData.savedBranches,
                  accountType: savedData.accountType,
                )
              : const LoginScreen(),
        );
      },
    );
  }
}
