import 'package:cloud_functions/cloud_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:saraka/blocs.dart';
import 'package:saraka/constants.dart';
import 'package:saraka/implementations.dart';
import 'package:saraka/widgets.dart';

void main() {
  Firestore.instance.settings(timestampsInSnapshotsEnabled: true);

  final firebaseAnalytics = FirebaseAnalytics();

  final authentication = FirebaseAuthentication(
    firebaseAuth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
  );

  final cacheStorage = CacheStorage();

  final logger = FirebaseAnalyticsLogger(firebaseAnalytics: firebaseAnalytics);

  final cardRepository = FirestoreCardRepository(
    firestore: Firestore.instance,
  );

  final maintenanceRepository = FirestoreMaintenanceRepository(
    firestore: Firestore.instance,
  );

  final firebaseExternalFunctions = FirebaseExternalFunctions(
    cloudFunctions: CloudFunctions.instance,
  );

  final soundPlayer = SoundPlayer();

  final authenticationBlocFactory = AuthenticationBlocFactory(
    authenticatable: authentication,
    signable: authentication,
    signInOutLoggable: logger,
  );

  final maintenanceCheckBlocFactory = MaintenanceCheckBlocFactory(
    maintenanceSubscribable: maintenanceRepository,
  );

  final cardAdderBlocFactory = CardAdderBlocFactory(
    authenticatable: authentication,
    cardAddable: firebaseExternalFunctions,
    cardCreateLoggable: logger,
  );

  final cardDeleteBlocFactory = CardDeleteBlocFactory(
    authenticatable: authentication,
    cardDeletable: cardRepository,
  );

  final cardDetailBlocFactory = CardDetailBlocFactory(
    authenticatable: authentication,
    reviewSubscribable: cardRepository,
  );

  final cardReviewBlocFactory = CardReviewBlocFactory(
    authenticatable: authentication,
    cardReviewable: firebaseExternalFunctions,
    cardReviewLoggable: logger,
    inQueueCardSubscribable: cardRepository,
  );

  final cardListBlocFactory = CardListBlocFactory(
    authenticatable: authentication,
    cardSubscribable: cardRepository,
  );

  final synthesizerBlocFactory = SynthesizerBlocFactory(
    soundFilePlayable: soundPlayer,
    synthesizable: firebaseExternalFunctions,
    synthesizedSoundFileReferable: cacheStorage,
    synthesizeLoggable: logger,
  );

  final authenticationBloc = authenticationBlocFactory.create();

  final maintenanceCheckBloc = maintenanceCheckBlocFactory.create();

  runApp(
    MultiProvider(
      providers: [
        Provider<CardAdderBlocFactory>(value: cardAdderBlocFactory),
        Provider<CardDeleteBlocFactory>(value: cardDeleteBlocFactory),
        Provider<CardDetailBlocFactory>(value: cardDetailBlocFactory),
        Provider<CardReviewBlocFactory>(value: cardReviewBlocFactory),
        Provider<CardListBlocFactory>(value: cardListBlocFactory),
        Provider<SynthesizerBlocFactory>(value: synthesizerBlocFactory),
        Provider<AuthenticationBloc>(value: authenticationBloc),
        Provider<MaintenanceCheckBloc>(value: maintenanceCheckBloc),
      ],
      child: Application(
        title: "Saraka",
        color: SarakaColors.lightRed,
        child: MaintenanceCheckNavigator(
          child: AuthenticationNavigator(
            signedIn: SignedInNavigator(
              review: ReviewScreen(),
              cardList: CardListScreen(),
            ),
            signedOut: SignedOutScreen(),
            undecided: LandingScreen(),
          ),
        ),
      ),
    ),
  );
}
