import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_app/models/user_model.dart';
import 'package:pos_app/widgets/nav_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pos_app/core/localizations.dart';
import 'package:pos_app/pages/pages.dart';
import 'package:pos_app/services/user_service.dart';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier();

  late SharedPreferences _prefs;

  UserInfo? _user;
  String? _redirectLocation;
  bool _loggedIn = false;
  bool _active = false;
  bool? _darkMode;
  String? _locale;

  initialize() async {
    _prefs = await SharedPreferences.getInstance();
    await getPresistedData();
  }

  bool get authorized => _loggedIn && _active;
  bool get shouldRedirect => authorized && _redirectLocation != null;
  Map<String, dynamic> get getUserAuth => {
        'userId': _user?.userId,
        'phone': _user?.phone,
      };
  String get shopName => _user!.shopName!;
  String get userPhone => _user!.phone!;
  ThemeMode get themeMode => _darkMode == null
      ? ThemeMode.system
      : _darkMode!
          ? ThemeMode.dark
          : ThemeMode.light;
  Locale get locale => _locale != null && _locale!.isNotEmpty
      ? createLocale(_locale!)
      : createLocale('en');
  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  Future<void> setUser(UserInfo user) async {
    _user = user;
    _loggedIn = true;
    _active = user.active!;

    notifyListeners();

    await _prefs.setBool('isLoggedIn', true);
    await _prefs.setInt('userId', user.userId!);
    await _prefs.setString('phone', user.phone!);
    await _prefs.setBool('active', user.active!);
    await _prefs.setString('shopName', user.shopName!);
  }

  Future<void> logout() async {
    _user = null;
    _redirectLocation = null;
    _loggedIn = false;
    _active = false;
    notifyListeners();

    await _prefs.remove('isLoggedIn');
    await _prefs.remove('userId');
    await _prefs.remove('phone');
    await _prefs.remove('active');
    await _prefs.remove('shopName');
  }

  Future<void> toggleTheme() async {
    _darkMode = !_darkMode!;
    notifyListeners();
    await _prefs.setBool('themeMode', _darkMode!);
  }

  Future<void> toggleLocale() async {
    _locale = _locale == 'en' ? 'ar' : 'en';
    notifyListeners();
    await _prefs.setString('locale', _locale!);
  }

  Future<void> getPresistedData() async {
    _darkMode = _prefs.getBool('themeMode') ?? false;
    _locale = _prefs.getString('locale') ?? 'en';
    final isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      _loggedIn = true;
      _user = UserInfo(
        userId: _prefs.getInt('userId'),
        phone: _prefs.getString('phone'),
        active: _prefs.getBool('active'),
        shopName: _prefs.getString('shopName'),
      );
      _user = await UserService.refreshUser(getUserAuth);
      _active = _user!.active!;
      //notifyListeners();
    }
    notifyListeners();
  }
  Future<void> refresh() async{
    notifyListeners();
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
        initialLocation: '/Home',
        refreshListenable: appStateNotifier,
        errorBuilder: (context, state) => const LoginPage(),
        routes: [
          StatefulShellRoute(
              branches: <StatefulShellBranch>[
                StatefulShellBranch(
                  routes: [
                    AppRoute(
                      name: 'Home',
                      path: '/Home',
                      builder: (context, state) => const HomePage(),
                      requireAuth: true,
                    )
                  ].map((e) => e.toRoute(appStateNotifier)).toList(),
                ),
                StatefulShellBranch(
                  routes: [
                    AppRoute(
                        name: 'Edit',
                        path: '/Edit',
                        requireAuth: true,
                        builder: (context, state) => const EditPage())
                  ].map((e) => e.toRoute(appStateNotifier)).toList(),
                ),
                StatefulShellBranch(
                  routes: [
                    AppRoute(
                        name: 'Bills',
                        path: '/Bills',
                        requireAuth: true,
                        builder: (context, state) => const BillsPage())
                  ].map((e) => e.toRoute(appStateNotifier)).toList(),
                ),
                StatefulShellBranch(
                  routes: [
                    AppRoute(
                        name: 'Sales',
                        path: '/Sales',
                        requireAuth: true,
                        builder: (context, state) => const SalesPage())
                  ].map((e) => e.toRoute(appStateNotifier)).toList(),
                ),
              ],
              navigatorContainerBuilder: (context, navigationShell, children) {
                return IndexedStack(
                  index: navigationShell.currentIndex,
                  children: children,
                );
              },
              builder: (context, state, navigationShell) => NavBarWidget(
                    navigationShell: navigationShell,
                    pageName: state.uri.toString().splitMapJoin(RegExp(r'/'),
                        onMatch: (match) => '',
                        onNonMatch: (nonMatch) => nonMatch),
                  )),
          AppRoute(
            name: 'loginPage',
            path: '/loginPage',
            builder: (context, state) => appStateNotifier.authorized && appStateNotifier.shopName.isNotEmpty? HomePage() :LoginPage(),
          ).toRoute(appStateNotifier),
          AppRoute(
            name: 'About',
            path: '/info',
            builder: (context, state) => const InfoPage(),
          ).toRoute(appStateNotifier)
        ]);

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name, //the name of the page to build
    bool mounted, {
    // to check if the caller widget still used in the app
    Map<String, String> pathParameters =
        const <String, String>{}, //parameters passed to the new page in URL
    Map<String, String> queryParameters = const <String,
        String>{}, //parameters passed to the new page for query when the page is meant to show result
    Object? extra, //extra parameters for whatever
    bool ignoreRedirect =
        false, //tempererly bypass the redircects //the last four parameters are optional
  }) => //Go used to replace the caller widget in widgets stack
      !mounted ||
              (Provider.of<AppStateNotifier>(this, listen: false)
                      .hasRedirect() &&
                  !ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) => //this will put the new widget on top of the caller in the widget stack "can nav back to caller"
      !mounted ||
              (Provider.of<AppStateNotifier>(this, listen: false)
                      .hasRedirect() &&
                  !ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping. //For back button
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

class AppRoute {
  const AppRoute(
      {required this.name,
      required this.path,
      required this.builder,
      this.requireAuth = false,
      this.asyncParams = const {},
      this.routes = const []});
  final String name; //unique identifier for the route.
  final String path; //the URL path for the page.
  final bool
      requireAuth; //to make sure that the current user can access the page
  final Map<String, Future<dynamic> Function(String)>
      asyncParams; //used to fetch data when the widget called NOT REBUILT.
  final Widget Function(BuildContext, GoRouterState)
      builder; //to call the build method of the page
  final List<GoRoute> routes; //used to define the subroutes of the page called

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.authorized) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/loginPage';
          }
          return null;
        },
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            child: FutureBuilder<Map<String, dynamic>>(
              future: _fetchAsyncParams(state),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  if (snapshot.hasData) {
                    state.allParams.addAll(snapshot.data!);
                  }
                  final page = builder(context, state);
                  return page;
                }
              },
            ),
          );
        },
        routes: routes,
      );

  Future<Map<String, dynamic>> _fetchAsyncParams(GoRouterState state) async {
    if (asyncParams.isEmpty) {
      return {};
    }

    final extraData = <String, dynamic>{};
    for (final entry in asyncParams.entries) {
      final paramName = entry.key;
      final futureFunction = entry.value;
      final result =
          await futureFunction(state.allParams[paramName] ?? ""); // Handle null
      extraData[paramName] = result;
    }
    return extraData;
  }
}
