import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_theme_preference.dart';
import '../../domain/usecases/save_theme_preference.dart';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
  
  @override
  List<Object?> get props => [];
}

class ThemeInitialized extends ThemeEvent {}

class ThemeToggled extends ThemeEvent {}

// States
abstract class ThemeState extends Equatable {
  final bool isDarkMode;
  
  const ThemeState({required this.isDarkMode});
  
  @override
  List<Object?> get props => [isDarkMode];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial() : super(isDarkMode: false);
}

class ThemeLoaded extends ThemeState {
  const ThemeLoaded({required super.isDarkMode});
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemePreference _getThemePreference;
  final SaveThemePreference _saveThemePreference;
  
  ThemeBloc({
    required GetThemePreference getThemePreference,
    required SaveThemePreference saveThemePreference,
  }) : _getThemePreference = getThemePreference,
       _saveThemePreference = saveThemePreference,
       super(const ThemeInitial()) {
    
    on<ThemeInitialized>(_onThemeInitialized);
    on<ThemeToggled>(_onThemeToggled);
  }
  
  Future<void> _onThemeInitialized(
    ThemeInitialized event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      final result = await _getThemePreference(NoParams());
      
      result.fold(
        (failure) => emit(const ThemeLoaded(isDarkMode: false)),
        (isDarkMode) => emit(ThemeLoaded(isDarkMode: isDarkMode)),
      );
    } catch (e) {
      emit(const ThemeLoaded(isDarkMode: false));
    }
  }
  
  Future<void> _onThemeToggled(
    ThemeToggled event,
    Emitter<ThemeState> emit,
  ) async {
    try {
      final newTheme = !state.isDarkMode;
      
      final result = await _saveThemePreference(ThemeParams(isDarkMode: newTheme));
      
      result.fold(
        (failure) => {}, // Keep current state if save fails
        (_) => emit(ThemeLoaded(isDarkMode: newTheme)),
      );
    } catch (e) {
      // Keep current state if error occurs
    }
  }
}

// Use case parameters
class NoParams {}

class ThemeParams {
  final bool isDarkMode;
  
  ThemeParams({required this.isDarkMode});
}