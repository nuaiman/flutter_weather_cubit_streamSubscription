part of 'app_theme_cubit.dart';

enum AppThemeMode { light, dark }

class AppThemeState extends Equatable {
  final AppThemeMode appThemeMode;
  const AppThemeState({this.appThemeMode = AppThemeMode.light});

  @override
  List<Object> get props => [appThemeMode];

  @override
  bool get stringify => true;

  AppThemeState copyWith({
    AppThemeMode? appThemeMode,
  }) {
    return AppThemeState(
      appThemeMode: appThemeMode ?? this.appThemeMode,
    );
  }

  factory AppThemeState.initial() {
    return const AppThemeState();
  }
}
