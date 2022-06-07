import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:example_device_preview/cubit/setting_lang_cubit.dart';
import 'package:example_device_preview/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'const.dart';
import 'helper/localekeys.g.dart';
import 'locale_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  runApp(
    DevicePreview(
      enabled: kReleaseMode,
      builder: (context) => EasyLocalization(
        supportedLocales: LanguageManager.instance!.supportedLocales,
        path: ApplicationConstants.languageAssetsPath,
        startLocale: LanguageManager.instance?.idLocale,
        fallbackLocale: const Locale('id', 'ID'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      useInheritedMediaQuery: true,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            context.setLocale(supportedLocale);
          }
        }
        return null;
      },
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      builder: (context, widget) {
        ScreenUtil.init(
          context,
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
        );
        return DevicePreview.appBuilder(context, widget);
      },
      home: const HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.appBarTitle.tr()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            BlocProvider(
              create: (context) => SettingLangCubit(context),
              child: BlocBuilder<SettingLangCubit, SettingLangState>(
                builder: (context, state) {
                  return Card(
                    child: ListTile(
                      title: Text(LocaleKeys.bodyCardTitle.tr()),
                      trailing: DropdownButton<Locale>(
                        items: [
                          DropdownMenuItem(
                            value: LanguageManager.instance!.idLocale,
                            child: Text(
                              LanguageManager.instance!.idLocale.countryCode!
                                  .toUpperCase(),
                            ),
                          ),
                          DropdownMenuItem(
                            value: LanguageManager.instance!.enLocale,
                            child: Text(
                              LanguageManager.instance!.enLocale.countryCode!
                                  .toUpperCase(),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          context
                              .read<SettingLangCubit>()
                              .changeLanguage(value);
                        },
                        value: context.locale,
                      ),
                      subtitle: Text(
                        LocaleKeys.bodyCardSubTitle.tr(),
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              fontWeight: FontWeight.w100,
                              color: Colors.black54,
                            ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              LocaleKeys.bodyTitle.tr(),
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontSize: 34.sp,
                  ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: 100.h,
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(20.r),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
