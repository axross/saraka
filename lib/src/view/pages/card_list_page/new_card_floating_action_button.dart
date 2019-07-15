import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:saraka/constants.dart';

class NewCardFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FloatingActionButton.extended(
        backgroundColor: SarakaColor.lightRed,
        foregroundColor: SarakaColor.white,
        icon: Icon(Feather.getIconData('plus')),
        label: Text(
          'New Card',
          style: SarakaTextStyle.body.copyWith(color: SarakaColor.white),
        ),
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(24)),
        onPressed: () => _onPressed(context),
      );

  void _onPressed(BuildContext context) =>
      Navigator.of(context).pushNamed("/cards:new");
}