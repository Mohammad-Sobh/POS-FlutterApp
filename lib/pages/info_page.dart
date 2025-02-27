import 'package:flutter/material.dart';
import 'package:pos_app/core/core.dart';
import 'package:pos_app/packages/text/auto_size_text.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.close, size: 40),
          onPressed: () {
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
          padding: EdgeInsets.all(5),
        ),
      ),
      extendBody: true,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: Container(
        width: MediaQuery.sizeOf(context).width * 0.95,
        margin: EdgeInsets.all(10),
        child: ListView(scrollDirection: Axis.vertical, children: [
          Column(
            spacing: 30,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AutoSizeText(
                      Localization.of(context).getText('terms1'),
                      style: AppTheme.of(context).labelLarge,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: AutoSizeText(
                      Localization.of(context).getText('terms2'),
                      style: AppTheme.of(context).bodyLarge,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: AutoSizeText(
                      Localization.of(context).getText('terms3'),
                      style: AppTheme.of(context).headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
