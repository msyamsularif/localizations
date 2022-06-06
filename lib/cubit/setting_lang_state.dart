part of 'setting_lang_cubit.dart';

abstract class SettingLangState extends Equatable {
  const SettingLangState();

  @override
  List<Object> get props => [];
}

class SettingLangInitial extends SettingLangState {}

class SettingChangeLang extends SettingLangState {}
