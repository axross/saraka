import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../blocs/authentication_bloc.dart';
import '../../entities/card.dart';
import '../foundation/fancy_popup_dialog_route.dart';
import '../pages/card_confirm_deletion_dialog.dart';

class CardConfirmDeletionRoute extends FancyPopupDialogRoute<bool> {
  CardConfirmDeletionRoute({RouteSettings settings})
      : super(settings: settings);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      Consumer<AuthenticationBloc>(
        builder: (context, authenticationBloc, _) => StreamBuilder(
          stream: authenticationBloc.session,
          initialData: authenticationBloc.session.value,
          builder: (context, sessionSnapshot) => sessionSnapshot.hasData
              ? CardConfirmDeletionDialog(
                  card:
                      (settings.arguments as CardConfirmDeletionRouteArguments)
                          .card)
              : Container(),
        ),
      );
}

class CardConfirmDeletionRouteArguments {
  CardConfirmDeletionRouteArguments({@required this.card})
      : assert(card != null);

  final Card card;
}
