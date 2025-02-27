
import 'package:flutter/material.dart';
import 'package:pos_app/core/core.dart';

class dialogWidget {
  const dialogWidget(
    this.context,
    this.title,
    this.content,
    {this.barrierDismissible = true}
  );
  final BuildContext context;
  final String? title;
  final String? content;
  final bool? barrierDismissible;
  // show the dialog
  void showDialog(){
    AlertDialog alert = AlertDialog(
      titlePadding: title!.isEmpty? EdgeInsets.all(0) : EdgeInsets.all(10),
      contentPadding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 30),
      title: Text(
        title!,
        style: AppTheme.of(context).labelLarge,
        ),
      content: Text(
        content!,
        style: AppTheme.of(context).bodyLarge,
        ),
      clipBehavior: Clip.none,
      backgroundColor: AppTheme.of(context).secondaryBackground,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );
    showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible!,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (context, animation1, animation2) {
        return Container(
          height: 50,
        );
      },
      transitionBuilder: (context, a1, a2, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.5,
            end: 1.0
            ).animate(a1),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0.5,
              end: 1.0,
              ).animate(a1),
            child: alert
          )
        );
      }  
    );
  }
}