import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:saraka/entities.dart';

abstract class CardSubscribable {
  ValueObservable<List<Card>> subscribeAllCards({
    @required AuthenticationSession session,
  });
}
