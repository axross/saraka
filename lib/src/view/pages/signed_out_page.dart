import 'package:flutter/widgets.dart';
import 'package:saraka/constants.dart';
import './signed_out_page/privacy_policy_text.dart';
import './signed_out_page/sign_in_button.dart';

class SignedOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SarakaColor.white,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 64),
              SizedBox(
                width: constraints.maxWidth * .5,
                height: constraints.maxWidth * .5,
                child: Image.asset('assets/images/parrot.png'),
              ),
              SizedBox(height: 32),
              Text(
                "Parrot",
                style: SarakaTextStyle.heading.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: SarakaColor.lightRed,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Not study, just be used.",
                style: SarakaTextStyle.body.copyWith(
                  fontSize: 16,
                  color: SarakaColor.lightRed,
                ),
              ),
              SizedBox(height: 64),
              SignInButton(),
              SizedBox(height: 16),
              PrivacyPolicyItem(),
            ],
          ),
        ),
      ),
    );
  }
}
