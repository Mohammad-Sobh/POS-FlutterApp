import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_app/core/core.dart';
import 'package:provider/provider.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({
    super.key,
    required this.navigationShell,
    required this.pageName,
  });

  final StatefulNavigationShell navigationShell;
  final String pageName;
  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  void _switchTab(int index) {
    setState(() {
      widget.navigationShell.goBranch(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: Drawer(
            backgroundColor: AppTheme.of(context).secondaryBackground,
            elevation: 3,
            width: MediaQuery.sizeOf(context).width * 0.6,
            child: sideMenu(context)),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * 0.03,
                ),
                child: widget.navigationShell),
            Positioned(
              top: 0,
              child: Container(
                  //Glass Effect
                  alignment: Alignment.topCenter,
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.1,
                  decoration: BoxDecoration(
                    color:
                        AppTheme.of(context).primaryBackground.withAlpha(210),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(182, 0, 0, 0),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 2,
                          spreadRadius: -1)
                    ],
                  ),
                  child: ClipRect(
                      child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 5, sigmaY: 5, tileMode: TileMode.mirror),
                    child: appBar(),
                  ))),
            )
          ],
        ),
        extendBody: true,
        bottomNavigationBar: Container(
            height: MediaQuery.sizeOf(context).height * 0.06,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromARGB(182, 0, 0, 0),
                      blurStyle: BlurStyle.outer,
                      blurRadius: 2,
                      spreadRadius: -1)
                ],
                color: Colors.transparent,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 5, sigmaY: 5, tileMode: TileMode.mirror),
                  child: navBar(context),
                )))

        //TODO flutter pub add hidable
        ////to hide navbar and floating button

        );
  }

  NavigationBarTheme navBar(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        backgroundColor: AppTheme.of(context).primaryBackground.withAlpha(200),
        indicatorColor: AppTheme.of(context).accent4,
        indicatorShape: CircleBorder(),
        labelTextStyle: WidgetStatePropertyAll(AppTheme.of(context)
            .bodySmall
            .override(
                fontFamily: AppTheme.of(context).bodySmallFamily,
                color: AppTheme.of(context).secondaryText,
                fontSize: 8)),
      ),
      child: NavigationBar(
        animationDuration: const Duration(seconds: 1),
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: _switchTab,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.point_of_sale_outlined,
              color: AppTheme.of(context).secondaryText,
              size: 25,
            ),
            selectedIcon:
                Icon(Icons.point_of_sale, color: AppTheme.of(context).primary),
            label: Localization.of(context).getText('Home'),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.inventory_2_outlined,
              color: AppTheme.of(context).secondaryText,
              size: 25,
            ),
            selectedIcon:
                Icon(Icons.inventory_2, color: AppTheme.of(context).primary),
            label: Localization.of(context).getText('Edit'),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.document_scanner_outlined,
              color: AppTheme.of(context).secondaryText,
              size: 25,
            ),
            selectedIcon: Icon(Icons.document_scanner,
                color: AppTheme.of(context).primary),
            label: Localization.of(context).getText('Bills'),
          ),
          NavigationDestination(
            icon: Icon(
              Icons.attach_money_outlined,
              color: AppTheme.of(context).secondaryText,
              size: 25,
            ),
            selectedIcon: Icon(Icons.attach_money_rounded,
                color: AppTheme.of(context).primary),
            label: Localization.of(context).getText('Sales'),
          ),
        ],
      ),
    );
  }

  Column sideMenu(BuildContext context) {
    return Column(
      children: [
        ListTile(
            tileColor: AppTheme.of(context).accent4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 20)),
                Icon(
                  Icons.store_sharp,
                  size: 70,
                  color: AppTheme.of(context).primary,
                ),
                Text(
                  '${Provider.of<AppStateNotifier>(context).shopName}\n${Provider.of<AppStateNotifier>(context).userPhone}',
                  style: AppTheme.of(context).headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            )),
        ListTile(
          leading: Icon(
            Provider.of<AppStateNotifier>(context, listen: false).themeMode !=
                    ThemeMode.dark
                ? Icons.dark_mode
                : Icons.light_mode,
          ),
          title: Text(
            Localization.of(context).getText('theme mode'),
            style: AppTheme.of(context).bodyLarge,
          ),
          onTap: () {
            Provider.of<AppStateNotifier>(context, listen: false).toggleTheme();
          },
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text(
            Localization.of(context).getText('language'),
            style: AppTheme.of(context).bodyLarge,
          ),
          onTap: () {
            Provider.of<AppStateNotifier>(context, listen: false)
                .toggleLocale();
          },
        ),
        ListTile(
          leading: Icon(Icons.info_outlined),
          title: Text(
            Localization.of(context).getText('Info'),
            style: AppTheme.of(context).bodyLarge,
          ),
          onTap: () {
            GoRouter.of(context).push('/info');
          },
        ),
        ListTile(
          leading: Icon(Icons.output),
          title: Text(
            Localization.of(context).getText('log out'),
            style: AppTheme.of(context).bodyLarge,
          ),
          onTap: () {
            Provider.of<AppStateNotifier>(context, listen: false).logout();
          },
        )
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      systemOverlayStyle: Theme.of(context).brightness == Brightness.light
          ? SystemUiOverlayStyle(
              statusBarColor: AppTheme.of(context).primaryBackground,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: AppTheme.of(context).primaryBackground,
              systemNavigationBarIconBrightness: Brightness.dark,
            )
          : SystemUiOverlayStyle(
              
              statusBarColor: AppTheme.of(context).primaryBackground,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: AppTheme.of(context).primaryBackground,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
      title: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Image.asset(
          'assets/images/logo_landscape.PNG',
          fit: BoxFit.contain,
          width: 80,
        ),
      ),
      centerTitle: true,
      forceMaterialTransparency: true,
    );
  }
}
