# Script PowerShell para criar estrutura completa Flutter
# Seguindo as melhores praticas de desenvolvimento

# Definir o caminho base
$basePath = "C:\laragon\www\ci4_react_netx_typescript\src\public\flutter\modelo_v1"

# Funcao para criar diretorio se nao existir
function New-DirectoryIfNotExists {
    param([string]$Path)
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Host "Criado: $Path" -ForegroundColor Green
    }
}

# Funcao para criar arquivo se nao existir
function New-FileIfNotExists {
    param([string]$Path, [string]$Content = "")
    if (-not (Test-Path $Path)) {
        New-Item -ItemType File -Path $Path -Force | Out-Null
        if ($Content) {
            Set-Content -Path $Path -Value $Content -Encoding UTF8
        }
        Write-Host "Criado: $Path" -ForegroundColor Yellow
    }
}

Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "CRIANDO ESTRUTURA FLUTTER COMPLETA" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan

# 1. ESTRUTURA PRINCIPAL LIB
Write-Host "`n1. Criando estrutura principal lib..." -ForegroundColor Magenta

# Core - Nucleo da aplicacao
New-DirectoryIfNotExists "$basePath\lib\core"
New-DirectoryIfNotExists "$basePath\lib\core\constants"
New-DirectoryIfNotExists "$basePath\lib\core\errors"
New-DirectoryIfNotExists "$basePath\lib\core\network"
New-DirectoryIfNotExists "$basePath\lib\core\theme"
New-DirectoryIfNotExists "$basePath\lib\core\utils"
New-DirectoryIfNotExists "$basePath\lib\core\extensions"
New-DirectoryIfNotExists "$basePath\lib\core\validators"

# Data Layer - Camada de dados
New-DirectoryIfNotExists "$basePath\lib\data"
New-DirectoryIfNotExists "$basePath\lib\data\datasources"
New-DirectoryIfNotExists "$basePath\lib\data\datasources\local"
New-DirectoryIfNotExists "$basePath\lib\data\datasources\remote"
New-DirectoryIfNotExists "$basePath\lib\data\models"
New-DirectoryIfNotExists "$basePath\lib\data\repositories"

# Domain Layer - Camada de dominio
New-DirectoryIfNotExists "$basePath\lib\domain"
New-DirectoryIfNotExists "$basePath\lib\domain\entities"
New-DirectoryIfNotExists "$basePath\lib\domain\repositories"
New-DirectoryIfNotExists "$basePath\lib\domain\usecases"

# Presentation Layer - Camada de apresentacao
New-DirectoryIfNotExists "$basePath\lib\presentation"
New-DirectoryIfNotExists "$basePath\lib\presentation\pages"
New-DirectoryIfNotExists "$basePath\lib\presentation\widgets"
New-DirectoryIfNotExists "$basePath\lib\presentation\controllers"
New-DirectoryIfNotExists "$basePath\lib\presentation\blocs"
New-DirectoryIfNotExists "$basePath\lib\presentation\providers"

# Features - Organizacao por funcionalidades
New-DirectoryIfNotExists "$basePath\lib\features"
New-DirectoryIfNotExists "$basePath\lib\features\auth"
New-DirectoryIfNotExists "$basePath\lib\features\auth\data"
New-DirectoryIfNotExists "$basePath\lib\features\auth\domain"
New-DirectoryIfNotExists "$basePath\lib\features\auth\presentation"
New-DirectoryIfNotExists "$basePath\lib\features\home"
New-DirectoryIfNotExists "$basePath\lib\features\home\data"
New-DirectoryIfNotExists "$basePath\lib\features\home\domain"
New-DirectoryIfNotExists "$basePath\lib\features\home\presentation"
New-DirectoryIfNotExists "$basePath\lib\features\profile"
New-DirectoryIfNotExists "$basePath\lib\features\profile\data"
New-DirectoryIfNotExists "$basePath\lib\features\profile\domain"
New-DirectoryIfNotExists "$basePath\lib\features\profile\presentation"

# Services - Servicos globais
New-DirectoryIfNotExists "$basePath\lib\services"
New-DirectoryIfNotExists "$basePath\lib\services\api"
New-DirectoryIfNotExists "$basePath\lib\services\storage"
New-DirectoryIfNotExists "$basePath\lib\services\notifications"
New-DirectoryIfNotExists "$basePath\lib\services\analytics"
New-DirectoryIfNotExists "$basePath\lib\services\authentication"

# Shared - Componentes compartilhados
New-DirectoryIfNotExists "$basePath\lib\shared"
New-DirectoryIfNotExists "$basePath\lib\shared\widgets"
New-DirectoryIfNotExists "$basePath\lib\shared\components"
New-DirectoryIfNotExists "$basePath\lib\shared\mixins"
New-DirectoryIfNotExists "$basePath\lib\shared\enums"

# 2. ASSETS
Write-Host "`n2. Criando estrutura de assets..." -ForegroundColor Magenta

New-DirectoryIfNotExists "$basePath\assets"
New-DirectoryIfNotExists "$basePath\assets\images"
New-DirectoryIfNotExists "$basePath\assets\images\icons"
New-DirectoryIfNotExists "$basePath\assets\images\logos"
New-DirectoryIfNotExists "$basePath\assets\images\backgrounds"
New-DirectoryIfNotExists "$basePath\assets\fonts"
New-DirectoryIfNotExists "$basePath\assets\json"
New-DirectoryIfNotExists "$basePath\assets\animations"
New-DirectoryIfNotExists "$basePath\assets\translations"

# 3. TEST
Write-Host "`n3. Criando estrutura de testes..." -ForegroundColor Magenta

New-DirectoryIfNotExists "$basePath\test"
New-DirectoryIfNotExists "$basePath\test\unit"
New-DirectoryIfNotExists "$basePath\test\unit\core"
New-DirectoryIfNotExists "$basePath\test\unit\data"
New-DirectoryIfNotExists "$basePath\test\unit\domain"
New-DirectoryIfNotExists "$basePath\test\unit\presentation"
New-DirectoryIfNotExists "$basePath\test\widget"
New-DirectoryIfNotExists "$basePath\test\integration"
New-DirectoryIfNotExists "$basePath\test\mocks"
New-DirectoryIfNotExists "$basePath\test\fixtures"

# 4. DOCUMENTACAO
Write-Host "`n4. Criando estrutura de documentacao..." -ForegroundColor Magenta

New-DirectoryIfNotExists "$basePath\docs"
New-DirectoryIfNotExists "$basePath\docs\api"
New-DirectoryIfNotExists "$basePath\docs\architecture"
New-DirectoryIfNotExists "$basePath\docs\guides"
New-DirectoryIfNotExists "$basePath\docs\screenshots"

# 5. CRIANDO ARQUIVOS ESSENCIAIS
Write-Host "`n5. Criando arquivos essenciais..." -ForegroundColor Magenta

# Main.dart
$mainContent = @"
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
"@

New-FileIfNotExists "$basePath\lib\main.dart" $mainContent

# App Theme
$themeContent = @"
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
    );
  }
}
"@

New-FileIfNotExists "$basePath\lib\core\theme\app_theme.dart" $themeContent

# App Colors
$colorsContent = @"
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color error = Color(0xFFB00020);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F5F5);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF000000);
  static const Color onBackground = Color(0xFF000000);
}
"@

New-FileIfNotExists "$basePath\lib\core\theme\app_colors.dart" $colorsContent

# App Constants
$constantsContent = @"
class AppConstants {
  static const String appName = 'Flutter Clean Architecture';
  static const String appVersion = '1.0.0';
  
  // API
  static const String baseUrl = 'https://api.example.com';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_mode';
  
  // Routes
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String profileRoute = '/profile';
}
"@

New-FileIfNotExists "$basePath\lib\core\constants\app_constants.dart" $constantsContent

# App Strings
$stringsContent = @"
class AppStrings {
  static const String appTitle = 'Flutter Clean Architecture';
  static const String welcome = 'Welcome';
  static const String login = 'Login';
  static const String logout = 'Logout';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String dontHaveAccount = 'Don\\'t have an account?';
  static const String register = 'Register';
  static const String profile = 'Profile';
  static const String settings = 'Settings';
  static const String about = 'About';
  
  // Error messages
  static const String genericError = 'Something went wrong. Please try again.';
  static const String networkError = 'Please check your internet connection.';
  static const String invalidEmail = 'Please enter a valid email address.';
  static const String passwordTooShort = 'Password must be at least 6 characters.';
}
"@

New-FileIfNotExists "$basePath\lib\core\constants\app_strings.dart" $stringsContent

# Home Page
$homePageContent = @"
import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.welcome,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to another page
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
"@

New-FileIfNotExists "$basePath\lib\presentation\pages\home_page.dart" $homePageContent

# README.md
$readmeContent = @"
# Flutter Clean Architecture Project

This project follows Clean Architecture principles with best practices for Flutter development.

## Project Structure

```
lib/
├── core/                 # Core functionality
│   ├── constants/        # App constants
│   ├── errors/          # Error handling
│   ├── network/         # Network configuration
│   ├── theme/           # App theming
│   ├── utils/           # Utility functions
│   ├── extensions/      # Dart extensions
│   └── validators/      # Input validators
├── data/                # Data layer
│   ├── datasources/     # Data sources (API, DB)
│   ├── models/          # Data models
│   └── repositories/    # Repository implementations
├── domain/              # Domain layer
│   ├── entities/        # Business entities
│   ├── repositories/    # Repository interfaces
│   └── usecases/        # Business logic
├── presentation/        # Presentation layer
│   ├── pages/           # App pages/screens
│   ├── widgets/         # Custom widgets
│   ├── controllers/     # Controllers
│   ├── blocs/           # BLoC pattern
│   └── providers/       # State management
├── features/            # Feature-based organization
├── services/            # Global services
└── shared/              # Shared components
```

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

## Architecture

This project uses Clean Architecture with the following layers:
- **Presentation Layer**: UI and state management
- **Domain Layer**: Business logic and entities
- **Data Layer**: Data sources and repositories

## Best Practices Implemented

- Clean Architecture
- Feature-based folder structure
- Separation of concerns
- Dependency injection
- Error handling
- Testing structure
- Code organization
- Theme management
- Constants management
"@

New-FileIfNotExists "$basePath\README.md" $readmeContent

# .gitignore customizado
$gitignoreContent = @"
# Miscellaneous
*.class
*.log
*.pyc
*.swp
.DS_Store
.atom/
.buildlog/
.history
.svn/

# IntelliJ related
*.iml
*.ipr
*.iws
.idea/

# The .vscode folder contains launch configuration and tasks you configure in
# VS Code which you may wish to be included in version control, so this line
# is commented out by default.
#.vscode/

# Flutter/Dart/Pub related
**/doc/api/
**/ios/Flutter/.last_build_id
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
/build/

# Web related
lib/generated_plugin_registrant.dart

# Symbolication related
app.*.symbols

# Obfuscation related
app.*.map.json

# Android Studio will place build artifacts here
/android/app/debug
/android/app/profile
/android/app/release

# Custom additions
.env
*.env
secrets.json
*.log
coverage/
.nyc_output/
"@

New-FileIfNotExists "$basePath\.gitignore" $gitignoreContent

Write-Host "`n===========================================" -ForegroundColor Cyan
Write-Host "ESTRUTURA FLUTTER CRIADA COM SUCESSO!" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "Caminho: $basePath" -ForegroundColor Yellow
Write-Host "`nProximos passos:" -ForegroundColor Magenta
Write-Host "1. Execute: flutter pub get" -ForegroundColor White
Write-Host "2. Execute: flutter run" -ForegroundColor White
Write-Host "3. Comece a desenvolver seguindo a arquitetura limpa!" -ForegroundColor White