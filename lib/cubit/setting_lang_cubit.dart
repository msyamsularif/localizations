import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

part 'setting_lang_state.dart';

class SettingLangCubit extends Cubit<SettingLangState> {
  BuildContext myContext;
  SettingLangCubit(
    this.myContext,
  ) : super(SettingLangInitial());

  void changeLanguage(Locale? locale) {
    if (locale != null) {
      myContext.setLocale(locale);
      emit(SettingChangeLang());
    } else {
      emit(SettingChangeLang());
    }
  }
}
